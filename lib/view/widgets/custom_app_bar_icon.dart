import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBarIcon extends StatelessWidget {
  const CustomAppBarIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back_ios,
        color: Colors.grey,
        size: 25,
      ),
      onPressed: () {
        Get.back();
      },
    );
  }
}
