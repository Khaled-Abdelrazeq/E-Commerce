import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/view_model/main_view_model/item_all_review_view_model.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomReviewFilter extends StatelessWidget {
  final bool condition;
  final String text;
  final bool isContainIcon;
  final double width;
  final double height;
  final double fontSize;

  const CustomReviewFilter(
      {Key? key,
      required this.condition,
      required this.text,
      this.isContainIcon = true,
      this.width = 60,
      this.height = 50,
      this.fontSize = 18})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: condition ? secondaryColor : Colors.white,
            border: Border.all(
              color: condition ? secondaryColor : Colors.grey.shade200,
            )),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isContainIcon)
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
              if (isContainIcon) const SizedBox(width: 10),
              CustomText(
                text: text,
                alignment: Alignment.center,
                color: condition ? primaryColor : Colors.grey,
                isFontBold: condition ? true : false,
                fontSize: fontSize,
              )
            ],
          ),
        ));
  }
}
