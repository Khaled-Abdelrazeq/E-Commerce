import 'package:e_commerce/view/widgets/custom_app_bar_icon.dart';
import 'package:e_commerce/view/widgets/custom_rating_bar.dart';
import 'package:e_commerce/view/widgets/custom_review_text_from_field.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:e_commerce/view_model/main_view_model/write_review_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WriteReviewPage extends StatelessWidget {
  const WriteReviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.2,
        title: const CustomText(
          text: 'Write Review',
          isFontBold: true,
          fontSize: 16,
        ),
        leading: const CustomAppBarIcon(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Title
              const SizedBox(height: 15),
              const CustomText(
                text:
                    'Please write Overall level of satisfaction with your shipping / Delivery Service',
                maxLines: 3,
                fontSize: 16,
                isFontBold: true,
              ),

              ///Add Rate
              const SizedBox(height: 15),
              GetBuilder<WriteReviewViewModel>(
                init: WriteReviewViewModel(),
                builder: (controller) {
                  return Row(
                    children: [
                      CustomRatingBar(
                        starsSize: 40,
                        addRate: true,
                        onRatingUpdate: (rating) {
                          controller.changeReviewRating(rating);
                        },
                      ),
                      const SizedBox(width: 15),
                      const CustomText(
                        text: '4',
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      const CustomText(
                        text: '/5',
                        fontSize: 16,
                        color: Colors.grey,
                      )
                    ],
                  );
                },
              ),
              const SizedBox(height: 15),

              ///Write Review
              const CustomText(
                text: 'Write Your Review',
                isFontBold: true,
                fontSize: 16,
              ),
              const SizedBox(height: 10),
              CustomReviewTextFromField(
                validateText: 'Add some text for review',
                hintText: 'Write your review here',
                onChangedFunction: (value) {},
              ),
              const SizedBox(height: 20),
              const CustomText(
                text: 'Add Photo',
                isFontBold: true,
                fontSize: 16,
              ),
              const SizedBox(height: 10),
              GetBuilder<WriteReviewViewModel>(
                builder: (controller) {
                  if (controller.images.isEmpty) {
                    controller.images.add(GestureDetector(
                      onTap: () {
                        controller.addImage();
                      },
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.only(top: 5, start: 5),
                        child: Container(
                          alignment: Alignment.center,
                          width: 80,
                          height: 80,
                          child: const Icon(Icons.add),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade200)),
                        ),
                      ),
                    ));
                  }

                  return Wrap(
                    children: controller.images,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
