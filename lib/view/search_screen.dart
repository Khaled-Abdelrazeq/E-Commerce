import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/constants/strings.dart';
import 'package:e_commerce/view/widgets/custom_app_bar.dart';
import 'package:e_commerce/view/widgets/custom_button.dart';
import 'package:e_commerce/view/widgets/custom_product_item.dart';
import 'package:e_commerce/view/widgets/custom_review_filter.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:e_commerce/view/widgets/custom_text_from_field.dart';
import 'package:e_commerce/view/widgets/custom_text_from_field_without_icons.dart';
import 'package:e_commerce/view_model/search_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPage extends StatelessWidget {
  final String searchText;

  const SearchPage({Key? key, required this.searchText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<SearchViewModel>(
        init: SearchViewModel(),
        builder: (controller) {
          controller.searchKeyword = searchText;
          controller.searchController.text = searchText;
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    ///App bar

                    controller.isCategoryOped
                        ? CustomAppBar(
                            title: 'Category',
                            onBackButtonClicked: () {
                              controller.onCategoryClicked();
                            })
                        : controller.isSortedByOped
                            ? CustomAppBar(
                                title: 'Sort By',
                                onBackButtonClicked: () {
                                  controller.onSortByClicked();
                                })
                            : controller.isFilterByOped
                                ? CustomAppBar(
                                    title: 'Filter Search',
                                    icon: Icons.close,
                                    onBackButtonClicked: () {
                                      controller.onFilterByClicked();
                                    })
                                : Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: CustomTextFromField(
                                            controller:
                                                controller.searchController,
                                            prefixIcon:
                                                const Icon(Icons.search),
                                            hintText: 'Search Product',
                                            onSaveFunction: (String value) {
                                              controller.onSearchChanged(value);
                                            },
                                            validateText:
                                                'You must enter keyword to search',
                                            onTapFunction: () {},
                                            onSubmittedFunction:
                                                (String value) {
                                              controller
                                                  .onSearchSubmitted(value);
                                            },
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                controller.onSortByClicked();
                                              },
                                              icon: const Icon(
                                                Icons.sort_outlined,
                                                color: Colors.grey,
                                              )),
                                          IconButton(
                                              onPressed: () {
                                                controller.onFilterByClicked();
                                              },
                                              icon: const Icon(
                                                  Icons.filter_alt_outlined,
                                                  color: primaryColor)),
                                        ],
                                      ),
                                    ],
                                  ),

                    ///Dividor
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey.shade300,
                    ),

                    ///Body
                    /// Check if search has a value or not

                    controller.isCategoryOped
                        ? const CategoriesView()
                        : controller.isSortedByOped
                            ? const SortedByView()
                            : controller.isFilterByOped
                                ? FilterByView(controller: controller)
                                : controller.isSearchedValue
                                    ?

                                    ///If search has a value => Show its value
                                    AvailableProducts(controller: controller)
                                    :

                                    /// If search hasn't value => show hint
                                    const ValueNotFound(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CategoriesView extends StatelessWidget {
  const CategoriesView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: 15,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 10);
        },
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: Image.asset(
                  'assets/images/categories_icon/man_pants.png',
                  fit: BoxFit.scaleDown,
                ),
              ),
              const SizedBox(width: 10),
              const FittedBox(
                child: CustomText(
                  text: 'Man Pants',
                  isFontBold: true,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class SortedByView extends StatelessWidget {
  const SortedByView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: 6,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 10);
        },
        itemBuilder: (BuildContext context, int index) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0),
            child: CustomText(
              text: 'Best Match',
              isFontBold: true,
              fontSize: 18,
            ),
          );
        },
      ),
    );
  }
}

class FilterByView extends StatelessWidget {
  final SearchViewModel controller;

  const FilterByView({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          const CustomText(
            text: 'Price Range',
            isFontBold: true,
            fontSize: 16,
          ),
          const SizedBox(height: 10),

          ///Price Range Text
          GetBuilder<SearchViewModel>(
            builder: (controller) {
              return Row(
                children: [
                  Expanded(
                    child: CustomTextFromFieldWithoutIcons(
                      hintText: '\$${controller.currentPriceRangMin}',
                      onSaveFunction: (value) {
                        controller.updateSlider(value, true);
                      },
                      isFontBold: true,
                      controller: controller.priceMinController,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomTextFromFieldWithoutIcons(
                      hintText: '\$${controller.currentPriceRangMax}',
                      onSaveFunction: (value) {
                        controller.updateSlider(value, false);
                      },
                      isFontBold: true,
                      controller: controller.priceMaxController,
                    ),
                  ),
                ],
              );
            },
          ),

          ///Price Slider
          RangeSlider(
              activeColor: primaryColor,
              min: controller.priceRangeMin,
              max: controller.priceRangeMax,
              values: RangeValues(controller.currentPriceRangMin,
                  controller.currentPriceRangMax),
              onChanged: (RangeValues values) {
                controller.onChangePriceSliderValues(values);
              }),

          ///Text MIN and MAX
          Row(
            children: const [
              CustomText(
                text: 'MIN',
                isFontBold: true,
                color: Colors.grey,
              ),
              Spacer(),
              CustomText(
                text: 'MAX',
                isFontBold: true,
                color: Colors.grey,
              ),
            ],
          ),

          const SizedBox(height: 20),

          ///Condition Title
          const CustomText(
            text: 'Condition',
            isFontBold: true,
            fontSize: 16,
          ),
          const SizedBox(height: 10),

          ///Condition values
          Align(
            alignment: Alignment.topLeft,
            child: Wrap(
              alignment: WrapAlignment.end,
              runSpacing: 10,
              spacing: 10,
              // crossAxisAlignment: WrapCrossAlignment.start,
              children: controller.conditionSearchFilterText
                  .map(
                    (e) => GestureDetector(
                      onTap: () {
                        controller.changeSearchConditionFilter(e[2]);
                      },
                      child: CustomReviewFilter(
                        fontSize: 16,
                        width: e[1],
                        height: 60,
                        isContainIcon: false,
                        condition:
                            controller.conditionSearchFilter[e[2]] == true,
                        text: e[0],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),

          ///Buying Title
          const SizedBox(height: 20),
          const CustomText(
            text: 'Buying Format',
            isFontBold: true,
            fontSize: 16,
          ),
          const SizedBox(height: 10),

          ///Buying Format values
          Align(
            alignment: Alignment.topLeft,
            child: Wrap(
              alignment: WrapAlignment.start,
              runSpacing: 10,
              spacing: 10,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: controller.buyingFormatSearchFilterText
                  .map(
                    (e) => GestureDetector(
                      onTap: () {
                        controller.changeSearchBuyingFormatFilter(e[2]);
                      },
                      child: CustomReviewFilter(
                        fontSize: 16,
                        width: e[1],
                        height: 60,
                        isContainIcon: false,
                        condition:
                            controller.buyingFormatSearchFilter[e[2]] == true,
                        text: e[0],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),

          ///Item Location Title
          const SizedBox(height: 20),
          const CustomText(
            text: 'Item Location',
            isFontBold: true,
            fontSize: 16,
          ),
          const SizedBox(height: 10),

          ///Item Location values
          Align(
            alignment: Alignment.topLeft,
            child: Wrap(
              alignment: WrapAlignment.start,
              runSpacing: 10,
              spacing: 10,
              crossAxisAlignment: WrapCrossAlignment.start,
              children: controller.itemLocationSearchFilterText
                  .map(
                    (e) => GestureDetector(
                      onTap: () {
                        controller.changeSearchItemLocationFilter(e[2]);
                      },
                      child: CustomReviewFilter(
                        fontSize: 16,
                        width: e[1],
                        height: 60,
                        isContainIcon: false,
                        condition:
                            controller.itemLocationSearchFilter[e[2]] == true,
                        text: e[0],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),

          ///Show Only Title
          const SizedBox(height: 20),
          const CustomText(
            text: 'Show Only',
            isFontBold: true,
            fontSize: 16,
          ),
          const SizedBox(height: 10),

          ///Item Location values
          Align(
              alignment: Alignment.topLeft,
              child: Wrap(
                  alignment: WrapAlignment.start,
                  runSpacing: 10,
                  spacing: 10,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.changeSearchShowSaleFilter();
                      },
                      child: CustomReviewFilter(
                        fontSize: 16,
                        width: 80,
                        height: 60,
                        isContainIcon: false,
                        condition: controller.showSaleSearchFilter == true,
                        text: 'Sale Only',
                      ),
                    ),
                  ])),

          const SizedBox(height: 20),
          CustomButton(
              textColor: Colors.white,
              alignment: Alignment.center,
              text: 'Apply',
              onPressed: () {})
        ],
      ),
    );
  }
}

class AvailableProducts extends StatelessWidget {
  final SearchViewModel controller;

  const AvailableProducts({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///Result and filter
        const SizedBox(height: 15),
        Row(
          children: [
            const CustomText(
              text: '145 Result',
              color: Colors.grey,
              isFontBold: true,
              fontSize: 16,
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                controller.onCategoryClicked();
              },
              child: Row(
                children: const [
                  CustomText(
                    text: 'Man Shoes',
                    isFontBold: true,
                    fontSize: 16,
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
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
        //     ))
      ],
    );
  }
}

class ValueNotFound extends StatelessWidget {
  const ValueNotFound({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          top: MediaQuery.of(context).size.height / 6),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: primaryColor),
                child: FittedBox(
                  child: FloatingActionButton(
                    onPressed: () {},
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 50,
                    ),
                    backgroundColor: primaryColor,
                  ),
                )),
            const SizedBox(height: 25),
            const FittedBox(
              child: CustomText(
                text: 'Product Not Found',
                isFontBold: true,
                fontSize: 30,
                alignment: Alignment.center,
              ),
            ),
            const SizedBox(height: 20),
            const FittedBox(
              child: CustomText(
                text: 'Thank you for shopping using $appName',
                isFontBold: true,
                fontSize: 14,
                color: Colors.grey,
                alignment: Alignment.center,
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              textColor: Colors.white,
              fontSize: 18,
              alignment: Alignment.center,
              text: 'Back To Home',
              onPressed: () {
                Get.back();
              },
            )
          ],
        ),
      ),
    );
  }
}
