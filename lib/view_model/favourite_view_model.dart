import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/model/user_model.dart';
import 'package:e_commerce/services/firestore_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FavouriteViewModel extends GetxController {
  List<ProductModel> favouriteProducts = [];
  UserModel? userModel;

  final ValueNotifier<bool> _loadingCategory = ValueNotifier(false);
  ValueNotifier<bool> get loadingCategory => _loadingCategory;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getFavouriteProducts();
  }

  void getFavouriteProducts() async {
    _loadingCategory.value = true;
    favouriteProducts = await FirestoreUser().getFavouriteProducts();
    loadingCategory.value = false;
    update();
  }

  void addFavoriteProduct(ProductModel model) async {
    bool isFound = false;
    for (int i = 0; i < favouriteProducts.length; i++) {
      if (favouriteProducts[i].name == model.name) {
        isFound = true;
        break;
      } else {
        isFound = false;
      }
    }

    if (!isFound) {
      favouriteProducts.add(model);

      int max = favouriteProducts.length - 1;
      List<Map> data =
          List.generate(max + 1, (index) => favouriteProducts[index].toJson());
      data[max] = model.toJson();

      await FirestoreUser().addCartOrFavoriteProduct({'favourites': data});
      Get.snackbar('Notification', 'Product Added To Favorites!');
    } else {
      Get.snackbar('Notification', 'Product Already Added!');
    }
    update();
  }

  void deleteElementFromFavoriteList(ProductModel model) async {
    favouriteProducts.remove(model);
    int max = favouriteProducts.length - 1;
    List<Map> data =
        List.generate(max + 1, (index) => favouriteProducts[index].toJson());

    await FirestoreUser()
        .addCartOrFavoriteProduct({'favourites': data})
        .then((value) => print('Deleted Successfully!'))
        .catchError((e) => print('error in deleting ${e.toString()}'));
    update();
  }
}
