import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchViewModel extends GetxController {
  bool isSearchedValue = true;
  bool isCategoryOped = false;
  bool isSortedByOped = false;
  bool isFilterByOped = false;

  String? searchKeyword;
  TextEditingController searchController = TextEditingController();

  // Start Filter by Variables
  TextEditingController priceMinController = TextEditingController();
  TextEditingController priceMaxController = TextEditingController();
  double currentPriceRangMin = 1.245;
  double currentPriceRangMax = 9.344;

  double priceRangeMin = 1;
  double priceRangeMax = 10;

  List<bool> conditionSearchFilter = [false, false, false];
  List<List<dynamic>> conditionSearchFilterText = [
    /// Title, Width, Index
    ['New', 60.0, 0],
    ['Used', 60.0, 1],
    ['Not Specified', 130.0, 2]
  ];

  List<List<dynamic>> buyingFormatSearchFilterText = [
    /// Title, Width, Index
    ['All Listings', 100.0, 0],
    ['Accepts Offers', 130.0, 1],
    ['Auction', 70.0, 2],
    ['Buy It Now', 90.0, 3],
    ['Classified Ads', 130.0, 4],
  ];

  List<bool> buyingFormatSearchFilter = [false, false, false, false, false];

  List<List<dynamic>> itemLocationSearchFilterText = [
    /// Title, Width, Index
    ['Egypt', 70.0, 0],
    ['Saudi Arabia ', 130.0, 1],
    ['Syria', 70.0, 2],
    ['US', 50.0, 3],
    ['Europe', 90.0, 4],
  ];

  List<bool> itemLocationSearchFilter = [false, false, false, false, false];

  bool showSaleSearchFilter = false;

  // End Filter by Variables

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    changePriceValues();
  }

  void onSearchChanged(String value) {
    searchKeyword = value;

    ///Show List of Products Name
    update();
  }

  void onSearchSubmitted(String value) {
    searchKeyword = value;

    /// Show GridView of Products
  }

  void onCategoryClicked() {
    isCategoryOped = !isCategoryOped;
    update();
  }

  void onSortByClicked() {
    isSortedByOped = !isSortedByOped;
    update();
  }

  void onFilterByClicked() {
    isFilterByOped = !isFilterByOped;
    update();
  }

  // Start Filter by Methods
  void changePriceValues() {
    priceMinController.text = '\$$currentPriceRangMin'.substring(0, 5);
    priceMaxController.text = '\$$currentPriceRangMax'.substring(0, 5);
  }

  void onChangePriceSliderValues(RangeValues values) {
    currentPriceRangMin = values.start;
    currentPriceRangMax = values.end;
    changePriceValues();
    update();
  }

  void updateSlider(String value, bool isMin) {
    if (isMin) {
      currentPriceRangMin = double.parse(value.substring(1));
    } else {
      currentPriceRangMax = double.parse(value.substring(1));
    }
    update();
  }

  void changeSearchConditionFilter(int index) {
    conditionSearchFilter[index] = !conditionSearchFilter[index];
    update();
  }

  void changeSearchBuyingFormatFilter(int index) {
    buyingFormatSearchFilter[index] = !buyingFormatSearchFilter[index];
    update();
  }

  void changeSearchItemLocationFilter(int index) {
    itemLocationSearchFilter[index] = !itemLocationSearchFilter[index];
    update();
  }

  void changeSearchShowSaleFilter() {
    showSaleSearchFilter = !showSaleSearchFilter;
    update();
  }
  // End Filter by Variables
}
