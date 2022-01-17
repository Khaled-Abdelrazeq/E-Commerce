import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/view/home/item_details.dart';
import 'package:e_commerce/view_model/favourite_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'cashed_image.dart';
import 'custom_rating_bar.dart';
import 'custom_text.dart';

class CustomProductItem extends StatelessWidget {
  final bool isRatingView;
  final bool isFavoriteView;
  final ProductModel model;
  final bool fromDetails;
  final Function() onTabClicked;

  const CustomProductItem(
      {Key? key,
      this.isRatingView = false,
      this.isFavoriteView = false,
      this.fromDetails = false,
      required this.model,
      required this.onTabClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!fromDetails) {
          Get.to(() => ItemDetails(
                model: model,
              ));
        } else {
          onTabClicked();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(10)),
        width: 140,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CustomCashedImage(
                    fit: BoxFit.fill, imageURL: model.image![0]),
              ),
            ),
            const SizedBox(height: 7),
            Expanded(
              child: CustomText(
                text: '${model.name}',
                maxLines: 2,
                color: Colors.black,
                fontSize: 12,
                isFontBold: true,
              ),
            ),
            if (isRatingView)
              CustomRatingBar(
                onRatingUpdate: (rating) {},
                initRate: double.parse(model.rate!),
              ),
            if (isRatingView) const SizedBox(height: 10),
            CustomText(
              text: '\$${model.priceAfterDiscount}',
              color: primaryColor,
              fontSize: 12,
              isFontBold: true,
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                CustomText(
                  text: '\$${model.price}',
                  color: Colors.grey.shade400,
                  fontSize: 11,
                  isFontBold: true,
                  isLineThrough: true,
                ),
                const SizedBox(width: 6),
                CustomText(
                  text: '${model.discount}% Off',
                  color: Colors.red,
                  fontSize: 11,
                  isFontBold: true,
                ),
                if (isFavoriteView)
                  GetBuilder<FavouriteViewModel>(
                    init: FavouriteViewModel(),
                    builder: (controller) {
                      return IconButton(
                        icon: Icon(
                          Icons.delete_outline,
                          color: Colors.grey.shade400,
                        ),
                        onPressed: () {
                          controller.deleteElementFromFavoriteList(model);
                        },
                      );
                    },
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
