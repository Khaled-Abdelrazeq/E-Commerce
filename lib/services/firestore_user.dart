import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreUser {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Users');

  Future<void> addNewUserToFirestore(UserModel userModel) async {
    return await userCollection.doc(userModel.userId).set(userModel.toJson());
  }

  Future<void> addCartOrFavoriteProduct(Map<String, Object> data) async {
    return await userCollection
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .update(data);
  }

  Future<DocumentSnapshot> getProducts() async {
    var data =
        await userCollection.doc(FirebaseAuth.instance.currentUser?.uid).get();
    return data;
  }

  Future<List<ProductModel>> getFavouriteProducts() async {
    UserModel? userModel;
    List<ProductModel> favouriteProducts = [];

    await getProducts().then((value) {
      userModel = UserModel.fromJson(value);
    });

    int length = userModel?.favourites?.length ?? 0;
    for (int i = 0; i < length; i++) {
      favouriteProducts.add(userModel!.favourites![i]);
    }
    return favouriteProducts;
  }

  getSnapshot() {
    userCollection.doc(FirebaseAuth.instance.currentUser?.uid).snapshots();
  }
}
