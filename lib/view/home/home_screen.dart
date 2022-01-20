import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/view/home/flash_sale.dart';
import 'package:e_commerce/view/widgets/carousel_item.dart';
import 'package:e_commerce/view/widgets/cashed_image.dart';
import 'package:e_commerce/view/widgets/custom_categories_view.dart';
import 'package:e_commerce/view/widgets/custom_product_item.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:e_commerce/view/widgets/stack_element.dart';
import 'package:e_commerce/view_model/main_view_model/home_view_model.dart';
import 'package:e_commerce/view_model/main_view_model/main_view_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

class HomePage extends GetWidget<HomeViewModel> {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        children: [
          const SizedBox(height: 15),

          ///Carousel Images
          carouselImage(),
          const SizedBox(height: 10),
          carouselIndicator(),
          const SizedBox(height: 25),

          ///Categories
          categoriesTitle(),
          const SizedBox(height: 10),
          categoriesElements(),
          const SizedBox(height: 25),

          ///Flash Sale
          flashSaleTitle(),
          const SizedBox(height: 10),
          flashSaleElements(),
          const SizedBox(height: 25),

          ///Mega Sale
          megaSaleTitle(),
          const SizedBox(height: 10),
          megaSaleElements(),
          const SizedBox(height: 20),

          ///Advertiser
          advertiser(),

          const SizedBox(height: 10),
          topSales(),
        ],
      ),
    );
  }

  Widget categoriesElements() {
    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      builder: (controller) {
        return controller.loadingCategory.value
            ? const CircularProgressIndicator()
            : SizedBox(
                height: 120,
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CustomCategoriesView(
                          imagePath: controller.allCategories[index].image!,
                          categoryName: controller.allCategories[index].name!);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 10);
                    },
                    itemCount: controller.allCategories.length),
              );
      },
    );
  }

  Widget topSales() {
    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      builder: (controller) {
        return controller.loadingCategory.value
            ? const CircularProgressIndicator()
            : Column(
                children: [
                  GridView.count(
                      crossAxisCount: 2,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      semanticChildCount: 1,
                      childAspectRatio: 0.65,
                      children: List.generate(
                        controller.bestProducts.length,
                        (index) => CustomProductItem(
                          isRatingView: true,
                          model: controller.bestProducts[index],
                          onTabClicked: () {},
                        ),
                      )),
                ],
              );
      },
    );
  }

  Container advertiser() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
      width: double.infinity,
      height: 200,
      child: GetBuilder<HomeViewModel>(builder: (controller) {
        return controller.loadingAdvertiser.value
            ? const CircularProgressIndicator()
            : Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CustomCashedImage(
                      fit: BoxFit.cover,
                      imageURL: controller.advertiserModel!.imageUrl!,
                    ),
                  ),
                  StackElement(
                    text: controller.advertiserModel!.title!,
                    startPadding: 25,
                    endPadding: 100,
                    topPadding: 50,
                  ),
                  StackElement(
                    text: controller.advertiserModel!.content!,
                    startPadding: 25,
                    endPadding: 0,
                    topPadding: 130,
                    isFontBold: false,
                    fontSize: 14,
                  ),
                ],
              );
      }),
    );
  }

  Row megaSaleTitle() {
    return Row(
      children: [
        const CustomText(
          text: 'Mega Sale',
          isFontBold: true,
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {},
          child: const CustomText(
            text: 'See More',
            isFontBold: true,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Widget flashSaleElements() {
    return GetBuilder<HomeViewModel>(
      builder: (controller) {
        return controller.loadingCategory.value
            ? const CircularProgressIndicator()
            : SizedBox(
                height: 220,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CustomProductItem(
                        model: controller.flashSaleProducts[index],
                        onTabClicked: () {},
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 10);
                    },
                    itemCount: controller.flashSaleProducts.length),
              );
      },
    );
  }

  Widget megaSaleElements() {
    return GetBuilder<HomeViewModel>(
      builder: (controller) {
        return controller.loadingCategory.value
            ? const CircularProgressIndicator()
            : SizedBox(
                height: 220,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CustomProductItem(
                        model: controller.megaSaleProducts[index],
                        onTabClicked: () {},
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 10);
                    },
                    itemCount: controller.megaSaleProducts.length),
              );
      },
    );
  }

  Row flashSaleTitle() {
    return Row(
      children: [
        const CustomText(
          text: 'Flash Sale',
          isFontBold: true,
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            Get.to(const FlashSale());
          },
          child: const CustomText(
            text: 'See More',
            isFontBold: true,
            color: primaryColor,
          ),
        ),
      ],
    );
  }

  Row categoriesTitle() {
    return Row(
      children: [
        const CustomText(
          text: 'Category',
          isFontBold: true,
        ),
        const Spacer(),
        GetBuilder<MainControlViewModel>(
          init: MainControlViewModel(),
          builder: (controller) {
            return GestureDetector(
              onTap: () {
                controller.updateBottomNavBar(1);
              },
              child: const CustomText(
                text: 'More Category',
                isFontBold: true,
                color: primaryColor,
              ),
            );
          },
        ),
      ],
    );
  }

  GetBuilder<HomeViewModel> carouselIndicator() {
    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      builder: (controller) {
        return CirclePageIndicator(
          currentPageNotifier: controller.carouselIndex,
          itemCount: controller.carouselModel.length,
          selectedDotColor: primaryColor,
          dotColor: Colors.blue.shade50,
          onPageSelected: (index) {
            // controller.changePageView(index);
          },
        );
      },
    );
  }

  GetBuilder<HomeViewModel> carouselImage() {
    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      builder: (controller) {
        return controller.loadingCarousel.value
            ? const CircularProgressIndicator()
            : CarouselSlider(
                items: controller.carouselModel
                    .map((e) => CarouselItem(model: e))
                    .toList(),
                options: CarouselOptions(
                  onPageChanged: (int index, x) {
                    controller.changePageView(index);
                  },
                  height: 200,
                  initialPage: 0,
                  viewportFraction: 1,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal,
                ),
              );
      },
    );
  }
}
