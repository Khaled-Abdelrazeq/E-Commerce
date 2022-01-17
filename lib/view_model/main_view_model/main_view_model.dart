import 'package:e_commerce/view/account_screen.dart';
import 'package:e_commerce/view/cart_screen.dart';
import 'package:e_commerce/view/explore_screen.dart';
import '../../view/home/home_screen.dart';
import 'package:e_commerce/view/offer_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainControlViewModel extends GetxController {
  int screenIndex = 0;

  TextEditingController searchController = TextEditingController();
  bool isSearchNow = false;
  String? searchKeyword;

  List<Widget> homeScreens = [
    HomePage(),
    ExplorePage(),
    const CartPage(),
    const OfferPage(),
    const AccountPage()
  ];

  void updateBottomNavBar(index) {
    screenIndex = index;
    update();
  }

  void onSearchChanged(String value) {
    if (value.isEmpty || value == '') {
      isSearchNow = false;
    } else {
      isSearchNow = true;
    }

    ///Show List of Product Name
    update();
  }
}
