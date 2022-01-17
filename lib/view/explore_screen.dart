import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:e_commerce/view_model/explore_view_model.dart';
import 'package:e_commerce/view_model/main_view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExplorePage extends StatelessWidget {
  ExplorePage({Key? key}) : super(key: key);

  var homeController = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),
            const CustomText(
              text: 'Man Fashion',
              fontSize: 16,
              isFontBold: true,
            ),
            const SizedBox(height: 10),
            GetBuilder<ExploreViewModel>(
              init: ExploreViewModel(),
              builder: (controller) {
                return homeController.loadingCategory.value
                    ? const CircularProgressIndicator()
                    : Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: homeController.manFashionCategories,
                      );
              },
            ),
            const SizedBox(height: 15),
            const CustomText(
              text: 'Woman Fashion',
              fontSize: 16,
              isFontBold: true,
            ),
            const SizedBox(height: 10),
            GetBuilder<ExploreViewModel>(
              init: ExploreViewModel(),
              builder: (controller) {
                return homeController.loadingCategory.value
                    ? const CircularProgressIndicator()
                    : Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 12,
                        runSpacing: 12,
                        children: homeController.womanFashionCategories,
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}
