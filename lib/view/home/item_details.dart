import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/model/cart_product_model.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/view/home/item_all_reviews.dart';
import 'package:e_commerce/view/widgets/cashed_image.dart';
import 'package:e_commerce/view/widgets/custom_app_bar_icon.dart';
import 'package:e_commerce/view/widgets/custom_button.dart';
import 'package:e_commerce/view/widgets/custom_comment.dart';
import 'package:e_commerce/view/widgets/custom_product_item.dart';
import 'package:e_commerce/view/widgets/custom_rating_bar.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:e_commerce/view_model/cart_view_model.dart';
import 'package:e_commerce/view_model/favourite_view_model.dart';
import 'package:e_commerce/view_model/main_view_model/home_view_model.dart';
import 'package:e_commerce/view_model/main_view_model/item_details_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:searchbar_animation/searchbar_animation.dart';

class ItemDetails extends GetWidget<ItemDetailsViewModel> {
  final ProductModel model;

  ItemDetails({Key? key, required this.model}) : super(key: key);

  var detailsController = Get.put(ItemDetailsViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.2,
        title: CustomText(
          text: '${model.name}',
          isFontBold: true,
          fontSize: 16,
        ),
        leading: const CustomAppBarIcon(),
        actions: [
          searchBarAnimation(context),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ///Item Images
            itemImages(),
            const SizedBox(height: 10),
            imagesIndicator(),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  ///Item Name
                  Row(
                    children: [itemTitle(model.name!), itemFavouriteButton()],
                  ),
                  const SizedBox(height: 7),

                  ///Rating Bar
                  CustomRatingBar(
                    onRatingUpdate: (rating) {},
                    initRate: double.parse(model.rate!),
                  ),
                  const SizedBox(height: 15),

                  ///Price
                  CustomText(
                    text: '\$${model.priceAfterDiscount}',
                    color: primaryColor,
                    fontSize: 20,
                    isFontBold: true,
                  ),
                  const SizedBox(height: 15),

                  ///Size
                  const CustomText(
                    text: 'Select Size',
                    color: Colors.black,
                    fontSize: 14,
                    isFontBold: true,
                  ),
                  const SizedBox(height: 5),
                  selectSize(),
                  const SizedBox(height: 20),

                  ///Color
                  const CustomText(
                    text: 'Select Color',
                    color: Colors.black,
                    fontSize: 14,
                    isFontBold: true,
                  ),
                  const SizedBox(height: 5),
                  selectColor(),
                  const SizedBox(height: 20),

                  ///Description
                  const CustomText(
                    text: 'Specification',
                    color: Colors.black,
                    fontSize: 14,
                    isFontBold: true,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const CustomText(
                        text: 'Shown:',
                        color: Colors.black,
                        fontSize: 12,
                      ),
                      const Spacer(),
                      CustomText(
                        textDirection: TextDirection.rtl,
                        text: model.shown![0],
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.only(
                        start: MediaQuery.of(context).size.width / 2 - 8),
                    child: CustomText(
                      textDirection: TextDirection.ltr,
                      alignment: Alignment.bottomRight,
                      text: model.shown![1],
                      color: Colors.grey,
                      fontSize: 12,
                      maxLines: 3,
                    ),
                  ),
                  const SizedBox(height: 15),

                  ///Description
                  const SizedBox(height: 15),
                  CustomText(
                    text: '${model.description}',
                    color: Colors.grey,
                    maxLines: 4,
                    fontSize: 14,
                  ),
                  const SizedBox(height: 20),

                  ///Review
                  review(),
                  const SizedBox(height: 10),
                  totalRate(),
                  const SizedBox(height: 10),

                  ///Comments
                  CustomComment(model: model.comments![0]),

                  ///Also items
                  const CustomText(
                    text: 'You Might Also Like',
                    fontSize: 16,
                    color: Colors.black,
                    isFontBold: true,
                  ),
                  const SizedBox(height: 15),
                  suggestedItems(),
                  const SizedBox(height: 20),

                  ///Add to cart button
                  GetBuilder<CartViewModel>(
                    init: CartViewModel(),
                    builder: (controller) {
                      return CustomButton(
                        text: 'Add To Cart',
                        onPressed: () {
                          if (detailsController.currentSelectedSize == null) {
                            Get.snackbar(
                                'Notification', 'Please select size first');
                          } else if (detailsController.currentSelectedColor ==
                              null) {
                            Get.snackbar(
                                'Notification', 'Please select color first');
                          } else {
                            controller.addCartProduct(CartProductModel(
                              name: model.name,
                              image: model.image![0],
                              price: model.priceAfterDiscount,
                              quantity: 1,
                              color: model.color![
                                  detailsController.currentSelectedColor!],
                              size: model.size![
                                  detailsController.currentSelectedSize!],
                            ));
                            detailsController.currentSelectedSize = 0;
                            detailsController.currentSelectedColor = 0;
                          }
                        },
                        alignment: Alignment.center,
                        textColor: Colors.white,
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  GetBuilder<HomeViewModel> suggestedItems() {
    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      builder: (homeController) {
        return SizedBox(
          height: 250,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CustomProductItem(
                  fromDetails: true,
                  model: homeController.mightLikeProducts[index],
                  isRatingView: true,
                  onTabClicked: () {
                    Get.back();
                    controller.isColoredInitialized = false;
                    Get.to(() => ItemDetails(
                          model: homeController.mightLikeProducts[index],
                        ));
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 10);
              },
              itemCount: homeController.mightLikeProducts.length),
        );
      },
    );
  }

  GetBuilder<ItemDetailsViewModel> totalRate() {
    return GetBuilder<ItemDetailsViewModel>(
      builder: (controller) {
        int? length = model.comments?.length;
        double rates = 0;
        for (int i = 0; i < length!; i++) {
          rates += double.parse(model.comments![i].rate!);
        }
        rates /= length;
        return Row(
          children: [
            CustomRatingBar(
              onRatingUpdate: (double rating) {},
              initRate: rates,
            ),
            const SizedBox(width: 5),
            CustomText(
              text: '$rates',
              fontSize: 12,
              isFontBold: true,
              color: Colors.grey,
            ),
            const SizedBox(width: 5),
            CustomText(
              text: '(${model.comments?.length} Review)',
              fontSize: 12,
              color: Colors.grey,
            ),
          ],
        );
      },
    );
  }

  Row review() {
    return Row(
      children: [
        const CustomText(
          text: 'Review Product',
          color: Colors.black,
          fontSize: 14,
          isFontBold: true,
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            Get.to(ItemAllReviewsPage(
              listOfModel: model.comments!,
            ));
          },
          child: const CustomText(
            textDirection: TextDirection.rtl,
            text: 'See More',
            color: primaryColor,
            fontSize: 14,
            isFontBold: true,
          ),
        ),
      ],
    );
  }

  GetBuilder<ItemDetailsViewModel> selectColor() {
    return GetBuilder<ItemDetailsViewModel>(
      builder: (controller) {
        if (!controller.isColoredInitialized) {
          controller.isSelectedColor =
              List.generate(model.color?.length ?? 0, (index) => false);
          controller.isColoredInitialized = true;
        }
        return SizedBox(
          height: 50,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.changeColorSelected(index);
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: model.color![index] == '0x0'
                                ? Colors.black
                                : Color(int.parse(model.color![index])),
                            border: Border.all(color: Colors.grey)),
                      ),
                    ),
                    Positioned(
                      left: 17,
                      top: 17,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: controller.isSelectedColor[index]
                                ? model.color![index] == '0xFFFFFFFF'
                                    ? Colors.grey
                                    : Colors.white
                                : model.color![index] == '0x0'
                                    ? Colors.black
                                    : Color(int.parse(model.color![index]))),
                      ),
                    )
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 10);
              },
              itemCount: model.color?.length ?? 0),
        );
      },
    );
  }

  GetBuilder<ItemDetailsViewModel> selectSize() {
    return GetBuilder<ItemDetailsViewModel>(
      builder: (controller) {
        if (!controller.isSizedInitialized) {
          controller.isSelectedSize =
              List.generate(model.size?.length ?? 0, (index) => false);
          controller.isSizedInitialized = true;
        }
        return SizedBox(
          height: 50,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    controller.changeSizeSelected(index);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                            color: controller.isSelectedSize[index]
                                ? primaryColor
                                : Colors.grey)),
                    child: CustomText(
                      alignment: Alignment.center,
                      text: '${model.size![index]}',
                      isFontBold: true,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 10);
              },
              itemCount: model.size?.length ?? 0),
        );
      },
    );
  }

  Widget itemFavouriteButton() {
    var detailsController = ItemDetailsViewModel();
    detailsController.isProductInFavorite(model);
    return GetBuilder<FavouriteViewModel>(
      init: FavouriteViewModel(),
      builder: (controller) {
        return IconButton(
          alignment: Alignment.topLeft,
          icon: Icon(
            // controller.favouriteProducts.contains(model)
            detailsController.isFavorite ||
                    controller.favouriteProducts.contains(model)
                ? Icons.favorite
                : Icons.favorite_border,
            color:
                // controller.favouriteProducts.contains(model)
                detailsController.isFavorite ||
                        controller.favouriteProducts.contains(model)
                    ? notificationColor
                    : Colors.grey,
            size: 30,
          ),
          onPressed: () {
            // if (controller.favouriteProducts.contains(model)) {
            if (detailsController.isFavorite ||
                controller.favouriteProducts.contains(model)) {
              controller.deleteElementFromFavoriteList(model);
              detailsController.update();
            } else {
              controller.addFavoriteProduct(model);
              detailsController.update();
            }
          },
        );
      },
    );
  }

  Expanded itemTitle(String name) {
    return Expanded(
      child: CustomText(
        text: name,
        isFontBold: true,
        fontSize: 20,
        maxLines: 2,
      ),
    );
  }

  GetBuilder<ItemDetailsViewModel> imagesIndicator() {
    return GetBuilder<ItemDetailsViewModel>(
      builder: (controller) {
        return CirclePageIndicator(
          currentPageNotifier: controller.pageViewIndex,
          itemCount: model.image!.length,
          selectedDotColor: primaryColor,
          dotColor: Colors.blue.shade50,
          onPageSelected: (index) {
            controller.changePageView(index);
          },
        );
      },
    );
  }

  SizedBox itemImages() {
    return SizedBox(
      height: 200,
      child: GetBuilder<ItemDetailsViewModel>(
          init: ItemDetailsViewModel(),
          builder: (controller) {
            return PageView(
                onPageChanged: (index) {
                  controller.changePageView(index);
                },
                children: List.generate(
                    model.image!.length,
                    (index) => CustomCashedImage(
                        imageURL: model.image![index], fit: BoxFit.cover)));
          }),
    );
  }

  SearchBarAnimation searchBarAnimation(BuildContext context) {
    return SearchBarAnimation(
      searchBoxWidth: MediaQuery.of(context).size.width - 25,
      isOriginalAnimation: false,
      buttonBorderColour: Colors.black45,
      buttonIcon: Icons.search,
      onFieldSubmitted: (String value) {
        debugPrint('onFieldSubmitted value $value');
      },
      textEditingController: TextEditingController(),
    );
  }
}
