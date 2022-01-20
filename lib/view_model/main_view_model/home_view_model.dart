import 'dart:math';

import 'package:e_commerce/model/advertiser_model.dart';
import 'package:e_commerce/model/carousel_model.dart';
import 'package:e_commerce/model/category_model.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/services/advertiser_service.dart';
import 'package:e_commerce/services/carousel_service.dart';
import 'package:e_commerce/services/categories_service.dart';
import 'package:e_commerce/services/product_service.dart';
import 'package:e_commerce/view/widgets/custom_categories_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeViewModel extends GetxController {
  var carouselIndex = ValueNotifier<int>(0);

  /// Carousel Variables
  final ValueNotifier<bool> _loadingCarousel = ValueNotifier(false);
  ValueNotifier<bool> get loadingCarousel => _loadingCarousel;

  /// Advertiser Variables
  final ValueNotifier<bool> _loadingAdvertiser = ValueNotifier(false);
  ValueNotifier<bool> get loadingAdvertiser => _loadingAdvertiser;
  AdvertiserModel? advertiserModel;

  /// Categories Variables
  final ValueNotifier<bool> _loadingCategory = ValueNotifier(false);
  ValueNotifier<bool> get loadingCategory => _loadingCategory;

  List<CategoryModel> manFashion = [];
  List<CategoryModel> womanFashion = [];
  List<CategoryModel> allCategories = [];

  final List<Widget> manFashionCategories = [];
  final List<Widget> womanFashionCategories = [];

  /// Products Variables
  final ValueNotifier<bool> _loadingProducts = ValueNotifier(false);
  ValueNotifier<bool> get loadingProducts => _loadingCategory;
  List<ProductModel> bestProducts = [];
  List<ProductModel> flashSaleProducts = [];
  List<ProductModel> megaSaleProducts = [];
  List<ProductModel> mightLikeProducts = [];

  List<CarouselModel> carouselModel = [];

  HomeViewModel() {
    getManCategories();
    getWomanCategories();
    getHomeProducts();
    getCarouselData();
    getAdvertiserData();
  }

  getAdvertiserData() async {
    _loadingAdvertiser.value = true;
    AdvertiserService().getAdvertiser().then((value) {
      advertiserModel = AdvertiserModel.fromJson(value[0].data());
      _loadingAdvertiser.value = false;

      update();
    });
  }

  getCarouselData() async {
    _loadingCarousel.value = true;
    CarouselService().getCarousels().then((value) {
      for (int i = 0; i < value.length; i++) {
        carouselModel.add(CarouselModel.fromJson(value[i].data()));
        _loadingCarousel.value = false;
      }
      update();
    });
  }

  void changePageView(int index) {
    carouselIndex.value = index;
    update();
  }

  getManCategories() async {
    _loadingCategory.value = true;
    CategoriesService().getManCategory().then((value) {
      for (int i = 0; i < value.length; i++) {
        manFashion.add(CategoryModel.fromJson(value[i].data()));
        allCategories.add(CategoryModel.fromJson(value[i].data()));
        manFashionCategories.add(CustomCategoriesView(
            imagePath: manFashion[i].image!,
            categoryName: manFashion[i].name!));
        _loadingCategory.value = false;
      }
      update();
    });
  }

  getWomanCategories() async {
    _loadingCategory.value = true;
    CategoriesService().getManCategory().then((value) {
      for (int i = 0; i < value.length; i++) {
        womanFashion.add(CategoryModel.fromJson(value[i].data()));
        allCategories.add(CategoryModel.fromJson(value[i].data()));
        womanFashionCategories.add(CustomCategoriesView(
            imagePath: womanFashion[i].image!,
            categoryName: womanFashion[i].name!));
      }
      _loadingCategory.value = false;
      update();
    });
  }

  getHomeProducts() async {
    _loadingProducts.value = true;
    ProductService().getProducts().then((value) {
      int maxMightLike = value.length > 5 ? 5 : value.length;
      bool isLengthBig = value.length > 5;
      for (int i = 0; i < value.length; i++) {
        if (value[i]['best']) {
          bestProducts.add(ProductModel.fromJson(value[i].data()));
        }
        if (value[i]['megaSale']) {
          megaSaleProducts.add(ProductModel.fromJson(value[i].data()));
        }
        if (value[i]['flashSale']) {
          flashSaleProducts.add(ProductModel.fromJson(value[i].data()));
        }

        if (isLengthBig && mightLikeProducts.length <= maxMightLike) {
          int check = Random().nextInt(2);
          if (check == 0) {
          } else {
            mightLikeProducts.add(ProductModel.fromJson(value[i].data()));
          }
        } else {
          mightLikeProducts.add(ProductModel.fromJson(value[i].data()));
        }
      }
      _loadingProducts.value = false;
      update();
    });
  }
}
