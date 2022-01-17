import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/view/home/favorite_screen.dart';
import 'package:e_commerce/view/home/notification_screen.dart';
import 'package:e_commerce/view/search_screen.dart';
import 'package:e_commerce/view/widgets/custom_text_from_field.dart';
import 'package:e_commerce/view_model/main_view_model/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainControl extends StatelessWidget {
  MainControl({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainControlViewModel>(
      init: MainControlViewModel(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          bottomNavigationBar: BottomNavigationBar(
              onTap: (index) {
                controller.updateBottomNavBar(index);
              },
              elevation: 2,
              showSelectedLabels: true,
              selectedItemColor: primaryColor,
              unselectedItemColor: Colors.grey,
              currentIndex: controller.screenIndex,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.search), label: 'Explore'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.local_offer_outlined), label: 'Offer'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline_outlined),
                    label: 'Account'),
              ]),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SafeArea(
              child: Column(
                children: [
                  ///App bar
                  if (controller.screenIndex == 0 ||
                      controller.screenIndex == 1)
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          GetBuilder<MainControlViewModel>(
                            init: MainControlViewModel(),
                            builder: (controller) {
                              return Expanded(
                                flex: 8,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Form(
                                    key: formKey,
                                    child: CustomTextFromField(
                                      controller: controller.searchController,
                                      prefixIcon: const Icon(Icons.search),
                                      suffixWidget: controller.isSearchNow
                                          ? IconButton(
                                              onPressed: () {
                                                controller.searchController
                                                    .clear();
                                                controller.isSearchNow = false;
                                                controller.update();
                                              },
                                              icon: const Icon(
                                                Icons.close,
                                                color: Colors.grey,
                                              ))
                                          : const Text(''),
                                      hintText: 'Search Product',
                                      onSaveFunction: (String value) {
                                        controller.searchKeyword = value;
                                        controller.onSearchChanged(value);
                                      },
                                      validateText:
                                          'You must enter keyword to search',
                                      onTapFunction: () {},
                                      onSubmittedFunction: (String value) {
                                        if (formKey.currentState!.validate()) {
                                          Get.to(SearchPage(
                                              searchText:
                                                  controller.searchKeyword!));
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          if (!controller.isSearchNow)
                            Expanded(
                              child: IconButton(
                                  onPressed: () {
                                    Get.to(const NotificationPage());
                                  },
                                  icon: const Icon(
                                      Icons.notifications_none_outlined,
                                      color: Colors.grey)),
                            ),
                          !controller.isSearchNow
                              ? Expanded(
                                  child: IconButton(
                                      onPressed: () {
                                        Get.to(const FavoritePage());
                                      },
                                      icon: const Icon(
                                        Icons.favorite_border,
                                        color: Colors.grey,
                                      )),
                                )
                              : Expanded(
                                  child: IconButton(
                                      onPressed: () {
                                        Get.to(const FavoritePage());
                                      },
                                      icon: const Icon(
                                        Icons.keyboard_voice_outlined,
                                        color: Colors.grey,
                                      )),
                                )
                        ],
                      ),
                    ),

                  ///Dividor
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey.shade300,
                  ),

                  controller.homeScreens[controller.screenIndex],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
