import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/constants/strings.dart';
import 'package:e_commerce/view/auth/registeration_screen.dart';
import 'package:e_commerce/view/auth/sign_in_with_phone_number.dart';
import 'package:e_commerce/view/widgets/custom_button.dart';
import 'package:e_commerce/view/widgets/custom_login_icon_button.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:e_commerce/view/widgets/custom_text_from_field.dart';
import 'package:e_commerce/view_model/auth_view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends GetWidget<AuthViewModel> {
  LoginPage({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade50,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/facebook.png',
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 30),
                  const CustomText(
                    alignment: Alignment.center,
                    text: 'Welcome to $appName',
                    color: Colors.black,
                    fontSize: 16,
                    isFontBold: true,
                  ),
                  const SizedBox(height: 10),
                  CustomText(
                    alignment: Alignment.center,
                    text: 'Sign in to Continue',
                    color: Colors.grey.shade400,
                    fontSize: 15,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFromField(
                    hintText: 'Your Email',
                    validateText: 'Email can\'t be empty!',
                    textInputType: TextInputType.emailAddress,
                    onSaveFunction: (value) {
                      controller.email = value;
                    },
                    prefixIcon: const Icon(Icons.email_outlined),
                    onTapFunction: () {},
                    controller: TextEditingController(),
                    onSubmittedFunction: (String) {},
                  ),
                  const SizedBox(height: 10),
                  CustomTextFromField(
                    controller: TextEditingController(),
                    hintText: 'Password',
                    validateText: 'Password can\'t be empty!',
                    textInputType: TextInputType.visiblePassword,
                    obscureText: true,
                    onSaveFunction: (value) {
                      controller.password = value;
                    },
                    prefixIcon: const Icon(Icons.lock_outline),
                    onTapFunction: () {},
                    onSubmittedFunction: (String) {},
                  ),
                  const SizedBox(height: 15),
                  ConditionalBuilder(
                    condition: !(controller.isLoading),
                    fallback: (BuildContext context) {
                      debugPrint('${controller.isLoading}');
                      return const Center(child: CircularProgressIndicator());
                    },
                    builder: (BuildContext context) {
                      return CustomButton(
                          text: 'Sign In',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              controller.isLoading = true;
                              controller.signInWithEmailAndPassword();
                            }
                          },
                          alignment: Alignment.center,
                          textColor: Colors.white,
                          fontSize: 16);
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: 1,
                        color: Colors.grey.shade300,
                      ),
                      const CustomText(
                        text: 'OR',
                        alignment: Alignment.center,
                        fontSize: 18,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        height: 1,
                        color: Colors.grey.shade300,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomButtonSocial(
                    text: 'Login with Google',
                    imagePath: 'assets/images/google.png',
                    onPressed: () {
                      controller.signInWithGoogle();
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomButtonSocial(
                    text: 'Login with Facebook',
                    imagePath: 'assets/images/facebook.png',
                    onPressed: () {
                      controller.signInWithFacebook();
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomButtonSocial(
                    text: 'Login with Phone',
                    isImage: false,
                    imagePath: 'assets/images/google.png',
                    onPressed: () {
                      Get.to(PhoneAuthentication());
                    },
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {},
                    child: const CustomText(
                      text: 'Forgot Password?',
                      color: primaryColor,
                      alignment: Alignment.center,
                      fontSize: 14,
                      isFontBold: true,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CustomText(
                        text: 'Don’t have a account? ',
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.offAll(Registrationscreen());
                        },
                        child: const CustomText(
                          text: 'Register',
                          color: primaryColor,
                          fontSize: 14,
                          isFontBold: true,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
