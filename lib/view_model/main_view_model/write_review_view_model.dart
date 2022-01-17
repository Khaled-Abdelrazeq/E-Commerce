import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WriteReviewViewModel extends GetxController {
  double ratingValue = 4;

  List<Widget> images = [];

  void changeReviewRating(double rating) {
    ratingValue = rating;
    update();
  }

  void addImage() {
    // images.insert(images.length - 1, const ReviewImage());
    update();
  }
}
