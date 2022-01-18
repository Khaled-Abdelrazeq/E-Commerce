import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/view/widgets/custom_app_bar.dart';
import 'package:e_commerce/view/widgets/custom_button.dart';
import 'package:e_commerce/view/widgets/custom_cart_element.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:e_commerce/view/widgets/custom_text_from_field_without_icons.dart';
import 'package:e_commerce/view_model/cart_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
      child: Column(
        children: [
          ///Title
          CustomAppBar(
            title: 'Your Cart',
            onBackButtonClicked: () {},
            isIconViewd: false,
          ),
          const SizedBox(height: 20),

          ///Dividor
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 10),

          /// List of Items in Cart
          cardItems(),

          /// Coupon code
          const SizedBox(height: 30),
          couponCode(context),

          /// Summary
          const SizedBox(height: 20),
          summary(),
          const SizedBox(height: 20),

          GetBuilder<CartViewModel>(
            init: CartViewModel(),
            builder: (controller) {
              return CustomButton(
                  alignment: Alignment.center,
                  textColor: Colors.white,
                  text: 'Check Out',
                  fontSize: 19,
                  onPressed: () {
                    // FirebaseAuth.instance.signOut();
                    controller.checkOut();
                  });
            },
          ),
        ],
      ),
    );
  }

  Container summary() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300)),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GetBuilder<CartViewModel>(
          init: CartViewModel(),
          builder: (controller) {
            return Column(
              children: [
                SalaryElement(
                  titleText: 'Items',
                  itemsCount: controller.itemCount,
                  priceText: (controller.itemsPrice).toStringAsFixed(2),
                  isFirstItem: true,
                ),
                const SizedBox(height: 20),
                SalaryElement(
                  titleText: 'Shipping',
                  priceText: '${controller.shipping}',
                ),
                const SizedBox(height: 20),
                SalaryElement(
                  titleText: 'Import charges',
                  priceText: (controller.importCharges).toStringAsFixed(2),
                ),
                const SizedBox(height: 25),
                Flex(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    direction: Axis.horizontal,
                    children: List.generate(22, (_) {
                      return Container(
                        width: 10,
                        height: 2,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                      );
                    })),
                const SizedBox(height: 20),
                SalaryElement(
                  titleText: 'Total Price',
                  priceText: (controller.totalPrice).toStringAsFixed(2),
                  isFontBold: true,
                  priceColor: primaryColor,
                  titleColor: Colors.black,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Stack couponCode(BuildContext context) {
    return Stack(
      children: [
        CustomTextFromFieldWithoutIcons(
            hintText: 'Enter Coupon Code',
            validateText: 'Your Coupon Is Not Correct',
            onSaveFunction: (value) {},
            controller: TextEditingController()),
        Positioned(
          right: 0,
          child: CustomButton(
              width: MediaQuery.of(context).size.width / 4,
              isWidth: true,
              textColor: Colors.white,
              alignment: Alignment.center,
              text: 'Apply',
              onPressed: () {}),
        )
      ],
    );
  }

  GetBuilder<CartViewModel> cardItems() {
    return GetBuilder<CartViewModel>(
      init: CartViewModel(),
      builder: (controller) {
        return ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return CustomCartElement(
                index: index,
                model: controller.cartProducts[index],
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10);
            },
            itemCount: controller.cartProducts.length);
      },
    );
  }
}

class SalaryElement extends StatelessWidget {
  final String titleText;
  final String priceText;
  final bool isFirstItem;
  final Color titleColor;
  final Color priceColor;
  final bool isFontBold;
  final int itemsCount;

  const SalaryElement({
    Key? key,
    required this.titleText,
    required this.priceText,
    this.isFirstItem = false,
    this.titleColor = Colors.grey,
    this.priceColor = Colors.black,
    this.isFontBold = false,
    this.itemsCount = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText(
          text: titleText,
          color: titleColor,
          isFontBold: isFontBold,
          alignment: Alignment.center,
          fontSize: 16,
        ),
        if (isFirstItem)
          CustomText(
            text: '($itemsCount)',
            color: Colors.grey,
            alignment: Alignment.center,
            fontSize: 16,
          ),
        const Spacer(),
        CustomText(
          text: '\$$priceText',
          color: priceColor,
          isFontBold: isFontBold,
          alignment: Alignment.center,
          fontSize: 16,
        ),
      ],
    );
  }
}
