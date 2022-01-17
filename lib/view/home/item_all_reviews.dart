import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/view/home/write_review.dart';
import 'package:e_commerce/view/widgets/custom_app_bar_icon.dart';
import 'package:e_commerce/view/widgets/custom_button.dart';
import 'package:e_commerce/view/widgets/custom_comment.dart';
import 'package:e_commerce/view/widgets/custom_review_filter.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:e_commerce/view_model/main_view_model/item_all_review_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemAllReviewsPage extends StatelessWidget {
  final List<ProductCommentModel> listOfModel;

  const ItemAllReviewsPage({Key? key, required this.listOfModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.2,
        title: const CustomText(
          text: '5 Review',
          isFontBold: true,
          fontSize: 16,
        ),
        leading: const CustomAppBarIcon(),
      ),
      body: GetBuilder<ItemAllReviewsViewModel>(
        init: ItemAllReviewsViewModel(),
        builder: (controller) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  /// Search Filters
                  const SizedBox(height: 10),
                  filterBar(controller),
                  const SizedBox(height: 10),

                  ///List of Reviews
                  if ((controller.currentListOfComments.isEmpty &&
                          controller.currentFilter != SearchFilter.allReview) ||
                      listOfModel.isEmpty)
                    CustomText(
                        text: controller.searchBy, alignment: Alignment.center),

                  if (listOfModel.isNotEmpty)
                    ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return CustomComment(
                            model: controller.searchBy == 'Comments'
                                ? listOfModel[index]
                                : controller.currentListOfComments[index],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 10);
                        },
                        itemCount: controller.searchBy == 'Comments'
                            ? listOfModel.length
                            : controller.currentListOfComments.length),
                  const SizedBox(height: 10),

                  ///Button to add Review
                  CustomButton(
                      text: 'Write Review',
                      textColor: Colors.white,
                      alignment: Alignment.center,
                      onPressed: () {
                        Get.to(const WriteReviewPage());
                      }),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  SingleChildScrollView filterBar(ItemAllReviewsViewModel controller) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              controller.changeSearchFilter(
                  SearchFilter.allReview, listOfModel);
            },
            child: Container(
              width: 100,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: controller.currentFilter == SearchFilter.allReview
                      ? secondaryColor
                      : Colors.white,
                  border: Border.all(
                    color: controller.currentFilter == SearchFilter.oneStar
                        ? secondaryColor
                        : Colors.grey.shade200,
                  )),
              child: CustomText(
                text: 'All Reviews',
                alignment: Alignment.center,
                color: controller.currentFilter == SearchFilter.allReview
                    ? primaryColor
                    : Colors.grey,
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              controller.changeSearchFilter(SearchFilter.oneStar, listOfModel);
            },
            child: CustomReviewFilter(
              condition: controller.currentFilter == SearchFilter.oneStar,
              text: '1',
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              controller.changeSearchFilter(SearchFilter.twoStars, listOfModel);
            },
            child: CustomReviewFilter(
              condition: controller.currentFilter == SearchFilter.twoStars,
              text: '2',
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              controller.changeSearchFilter(
                  SearchFilter.threeStars, listOfModel);
            },
            child: CustomReviewFilter(
              condition: controller.currentFilter == SearchFilter.threeStars,
              text: '3',
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              controller.changeSearchFilter(
                  SearchFilter.fourStars, listOfModel);
            },
            child: CustomReviewFilter(
              condition: controller.currentFilter == SearchFilter.fourStars,
              text: '4',
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              controller.changeSearchFilter(
                  SearchFilter.fiveStars, listOfModel);
            },
            child: CustomReviewFilter(
              condition: controller.currentFilter == SearchFilter.fiveStars,
              text: '5',
            ),
          ),
        ],
      ),
    );
  }
}
