import 'package:e_commerce/view_model/auth_view_model/auth_view_model.dart';
import 'package:e_commerce/view_model/cart_view_model.dart';
import 'package:e_commerce/view_model/explore_view_model.dart';
import 'package:e_commerce/view_model/favourite_view_model.dart';
import 'package:e_commerce/view_model/main_view_model/item_details_view_model.dart';
import 'package:e_commerce/view_model/main_view_model/home_view_model.dart';
import 'package:e_commerce/view_model/main_view_model/item_all_review_view_model.dart';
import 'package:e_commerce/view_model/main_view_model/main_view_model.dart';
import 'package:e_commerce/view_model/main_view_model/write_review_view_model.dart';
import 'package:e_commerce/view_model/search_view_model.dart';
import 'package:get/get.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthViewModel());
    Get.lazyPut(() => MainControlViewModel());
    Get.lazyPut(() => HomeViewModel());
    Get.lazyPut(() => ItemDetailsViewModel());
    Get.lazyPut(() => ItemAllReviewsViewModel());
    Get.lazyPut(() => WriteReviewViewModel());
    Get.lazyPut(() => ExploreViewModel());
    Get.lazyPut(() => SearchViewModel());
    Get.lazyPut(() => FavouriteViewModel());
    Get.lazyPut(() => CartViewModel());
  }
}
