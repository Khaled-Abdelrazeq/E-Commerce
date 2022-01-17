import 'package:e_commerce/view/widgets/custom_app_bar_icon.dart';
import 'package:e_commerce/view/widgets/custom_product_item.dart';
import 'package:e_commerce/view/widgets/custom_home_timer.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:e_commerce/view/widgets/stack_element.dart';
import 'package:e_commerce/view/widgets/top_image.dart';
import 'package:flutter/material.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class FlashSale extends StatelessWidget {
  const FlashSale({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.2,
        title: const CustomText(
          text: 'Super Flash Sale',
          isFontBold: true,
          fontSize: 16,
        ),
        leading: const CustomAppBarIcon(),
        actions: [
          SearchBarAnimation(
            searchBoxWidth: MediaQuery.of(context).size.width - 25,
            isOriginalAnimation: false,
            buttonBorderColour: Colors.black45,
            buttonIcon: Icons.search,
            onFieldSubmitted: (String value) {
              debugPrint('onFieldSubmitted value $value');
            },
            textEditingController: TextEditingController(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              const SizedBox(height: 15),
              const TopImage(),
              const SizedBox(height: 10),
              Column(
                children: [
                  // GridView.count(
                  //     crossAxisCount: 2,
                  //     physics: const NeverScrollableScrollPhysics(),
                  //     shrinkWrap: true,
                  //     crossAxisSpacing: 8,
                  //     mainAxisSpacing: 8,
                  //     semanticChildCount: 1,
                  //     childAspectRatio: 0.65,
                  //     children: List.generate(
                  //       10,
                  //       (index) => const CustomProductItem(isRatingView: true),
                  //     )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
