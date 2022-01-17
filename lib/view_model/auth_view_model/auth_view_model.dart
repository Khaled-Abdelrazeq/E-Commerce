import 'package:e_commerce/model/user_model.dart';
import 'package:e_commerce/services/firestore_user.dart';
import 'package:e_commerce/view/auth/login_screen.dart';
import 'package:e_commerce/view/main_screen.dart';
import 'package:e_commerce/view_model/cart_view_model.dart';
import 'package:e_commerce/view_model/favourite_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sms_autofill/sms_autofill.dart';

class AuthViewModel extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FacebookLogin _facebookLogin = FacebookLogin();

  late String name = '';
  late String email;
  late String password;
  late String passwordAgain;

  String? phoneNumber;
  String countryPhoneCode = '+20';

  String otpCode = '';
  String msgCodeSent = '';

  String verificationIDReceived = '';
  bool optCodeVisible = false;

  bool isLoading = false;

  final Rxn<User> _user = Rxn<User>();

  String? get user => _user.value?.email;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    _user.bindStream(_firebaseAuth.authStateChanges());
    listenToCode();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  void listenToCode() async {
    await SmsAutoFill().listenForCode;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

  void signInWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

    GoogleSignInAuthentication? googleAuth =
        await googleSignInAccount?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);

    await _firebaseAuth.signInWithCredential(credential).then((value) {
      addNewUserToFirestore(value);
      Get.to(MainControl());
    });
  }

  void signInWithFacebook() async {
    FacebookLoginResult result = await _facebookLogin.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    String accessToken = result.accessToken?.token ?? '';

    if (result.status == FacebookLoginStatus.success) {
      final AuthCredential credential =
          FacebookAuthProvider.credential(accessToken);

      await _firebaseAuth.signInWithCredential(credential).then((value) {
        addNewUserToFirestore(value);
        Get.to(MainControl());
      });
    }
  }

  void signInWithEmailAndPassword() async {
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Get.snackbar('Status', 'Login Successfully');
        isLoading = false;
        update();
        Get.offAll(MainControl());
      });
    } catch (e) {
      Get.snackbar('Error When Login Account', e.toString(),
          colorText: Colors.black, snackPosition: SnackPosition.BOTTOM);
      isLoading = false;
      update();
    }
  }

  void signUpWithEmailAndPassword() async {
    isLoading = true;
    update();
    try {
      _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        Get.snackbar('Status', 'Email Created Successfully');

        addNewUserToFirestore(value);

        Get.offAll(LoginPage());
        isLoading = false;
        update();
      });
    } catch (e) {
      Get.snackbar('Error When Create Account', e.toString(),
          colorText: Colors.black, snackPosition: SnackPosition.BOTTOM);
      isLoading = false;
      update();
    }
  }

  void verifyNumber(String number) async {
    isLoading = true;
    update();
    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // await _firebaseAuth.signInWithCredential(credential);
          await SmsAutoFill().listenForCode();
          Get.snackbar('Status', 'Login Successfully');
          isLoading = false;
          update();
        },
        verificationFailed: (FirebaseAuthException exception) {
          Get.snackbar('verificationFailed', exception.message ?? '');
          isLoading = false;
          update();
        },
        codeSent: (String verificationID, int? resendToken) {
          verificationIDReceived = verificationID;
          optCodeVisible = true;
          isLoading = false;
          update();
        },
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationID) {
          Get.snackbar('verificationFailed', 'Time out!');
        });
  }

  void verifyCode() async {
    // String result = '';
    // otpCode.forEach((element) => result += element);
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationIDReceived, smsCode: otpCode);

      await _firebaseAuth.signInWithCredential(credential).then((value) {
        Get.snackbar('Status', 'Login Successfully after verification');

        addNewUserToFirestore(value);

        Get.offAll(MainControl());
      });
    } catch (e) {
      Get.snackbar('Status', e.toString());
      debugPrint(e.toString());
    }
  }

  void signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> addNewUserToFirestore(UserCredential value) async {
    return await FirestoreUser().addNewUserToFirestore(UserModel(
      userId: value.user?.uid,
      email: value.user?.email,
      name: value.user?.displayName ?? name,
      pic: value.user?.photoURL ?? '',
      cart: CartViewModel().cartProducts,
      favourites: FavouriteViewModel().favouriteProducts,
    ));
  }
}

//keytool -exportcert -alias androiddebugkey -keystore "C:\Users\khale\.android\debug.keystore" | "C:\OpenSSL\bin\openssl" sha1 -binary | "C:\OpenSSL\bin\openssl" base64
