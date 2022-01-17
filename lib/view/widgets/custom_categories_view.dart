import 'package:flutter/material.dart';

import 'cashed_image.dart';
import 'custom_text.dart';

class CustomCategoriesView extends StatelessWidget {
  final String imagePath;
  final String categoryName;

  const CustomCategoriesView(
      {Key? key, required this.imagePath, required this.categoryName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 72,
      height: 110,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.all(20),
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(500)),
              child: CustomCashedImage(
                  fit: BoxFit.scaleDown, imageURL: imagePath)),
          const SizedBox(height: 7),
          Expanded(
            child: CustomText(
              text: categoryName,
              textAlign: TextAlign.center,
              alignment: Alignment.center,
              maxLines: 2,
              color: Colors.grey.shade400,
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}
