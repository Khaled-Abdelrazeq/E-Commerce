import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/view/widgets/cashed_image.dart';
import 'package:e_commerce/view/widgets/review_image.dart';
import 'package:flutter/material.dart';

import 'custom_rating_bar.dart';
import 'custom_text.dart';

class CustomComment extends StatelessWidget {
  final ProductCommentModel model;

  const CustomComment({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                  width: 60,
                  height: 60,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  // child: Image.asset('assets/images/facebook.png')),
                  child: CustomCashedImage(
                    fit: BoxFit.fill,
                    imageURL: '${model.profilePic}',
                  )),
            ),
            const SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: '${model.name}',
                  isFontBold: true,
                  fontSize: 16,
                ),
                const SizedBox(height: 6),
                CustomRatingBar(
                  onRatingUpdate: (rating) {},
                  initRate: double.parse(model.rate!),
                )
              ],
            )
          ],
        ),
        const SizedBox(height: 10),
        //Comment text
        CustomText(
          text: '${model.comment}',
          fontSize: 14,
          maxLines: 10,
          color: Colors.grey,
        ),
        const SizedBox(height: 15),
        //Comment images
        if (model.commentImage![0] != '')
          SizedBox(
            height: 100,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ReviewImage(
                    imageURL: model.commentImage![index],
                    boxFit: BoxFit.fill,
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 10);
                },
                itemCount: model.commentImage!.length),
          ),
        if (model.commentImage![0] != '') const SizedBox(height: 15),
        // Comment date
        CustomText(
          text: '${model.date}',
          fontSize: 14,
          color: Colors.grey,
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
