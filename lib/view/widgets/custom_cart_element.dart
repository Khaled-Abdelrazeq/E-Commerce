import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/model/cart_product_model.dart';
import 'package:e_commerce/services/firestore_user.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:e_commerce/view/widgets/review_image.dart';
import 'package:e_commerce/view_model/cart_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class CustomCartElement extends StatelessWidget {
  final CartProductModel model;
  final int index;

  const CustomCartElement({
    Key? key,
    required this.model,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            ReviewImage(
              boxFit: BoxFit.fill,
              size: 70,
              imageURL: model.image!,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 5,
                        child: CustomText(
                          text: '${model.name}',
                          maxLines: 3,
                          isFontBold: true,
                          fontSize: 14,
                        ),
                      ),
                      // Spacer(),
                      Expanded(
                        child: IconButton(
                          onPressed: () {},
                          alignment: Alignment.topLeft,
                          icon: const Icon(Icons.favorite,
                              color: notificationColor),
                        ),
                      ),
                      GetBuilder<CartViewModel>(
                        init: CartViewModel(),
                        builder: (controller) {
                          return Expanded(
                            child: IconButton(
                              onPressed: () {
                                controller.deleteElementFromCart(model, index);
                              },
                              alignment: Alignment.topLeft,
                              icon: const Icon(Icons.delete_outline,
                                  color: Colors.grey),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      CustomText(
                        text: '\$${model.price}',
                        color: primaryColor,
                        isFontBold: true,
                        fontSize: 14,
                      ),
                      const Spacer(),
                      Container(
                        alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          children: [
                            GetBuilder<CartViewModel>(
                              init: CartViewModel(),
                              builder: (controller) {
                                return Container(
                                    width: 30,
                                    height: 28,
                                    alignment: Alignment.topCenter,
                                    color: Colors.white,
                                    child: IconButton(
                                      onPressed: () {
                                        controller.addProductQuantity(
                                            -1, model, index);
                                      },
                                      alignment: Alignment.topCenter,
                                      icon: Image.asset(
                                        'assets/images/remove.PNG',
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    ));
                              },
                            ),
                            StreamBuilder(
                              stream: FirestoreUser()
                                  .userCollection
                                  .doc(FirebaseAuth.instance.currentUser?.uid)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                return Container(
                                    width: 40,
                                    height: 25,
                                    color: Colors.grey.shade100,
                                    child: CustomText(
                                      text: '${model.quantity}',
                                      // text: '${snapshot.data['quantity']}',
                                      alignment: Alignment.center,
                                    ));
                              },
                            ),
                            GetBuilder<CartViewModel>(
                              builder: (controller) {
                                return Container(
                                    width: 30,
                                    height: 28,
                                    alignment: Alignment.topCenter,
                                    color: Colors.white,
                                    child: IconButton(
                                      onPressed: () {
                                        controller.addProductQuantity(
                                            1, model, index);
                                      },
                                      alignment: Alignment.topCenter,
                                      icon: Image.asset(
                                        'assets/images/add.PNG',
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    ));
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
