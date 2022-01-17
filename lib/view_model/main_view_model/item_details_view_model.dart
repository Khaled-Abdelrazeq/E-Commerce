import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/services/firestore_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ItemDetailsViewModel extends GetxController {
  var pageViewIndex = ValueNotifier<int>(0);
  List<bool> isSelectedSize = [];
  List<bool> isSelectedColor = [];

  bool isSizedInitialized = false;
  bool isColoredInitialized = false;

  int? currentSelectedSize;
  int? currentSelectedColor;

  bool isFavorite = false;
  isProductInFavorite(ProductModel model) async {
    List<ProductModel> models = await FirestoreUser().getFavouriteProducts();
    isFavorite = models.contains(model);
    for (int i = 0; i < models.length; i++) {
      if (models[i].name == model.name) {
        print('Found');
        isFavorite = true;
        update();
        break;
      } else {
        isFavorite = false;
        update();
      }
    }
    update();
    print(models[0].name);
    print(models[1].name);
    print(model.name);
    print(isFavorite);
  }

  void changePageView(index) {
    pageViewIndex.value = index;
    update();
  }

  void changeSizeSelected(int index) {
    for (int i = 0; i < isSelectedSize.length; i++) {
      isSelectedSize[i] = false;
    }
    isSelectedSize[index] = true;
    currentSelectedSize = index;
    update();
  }

  void changeColorSelected(int index) {
    for (int i = 0; i < isSelectedColor.length; i++) {
      isSelectedColor[i] = false;
    }
    isSelectedColor[index] = true;
    currentSelectedColor = index;
    update();
  }
}
