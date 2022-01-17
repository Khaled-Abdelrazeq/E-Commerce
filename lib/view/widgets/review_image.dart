import 'package:e_commerce/view/widgets/cashed_image.dart';
import 'package:flutter/material.dart';

class ReviewImage extends StatelessWidget {
  final double size;
  final BoxFit boxFit;
  final String imageURL;

  const ReviewImage(
      {Key? key,
      this.size = 80,
      this.boxFit = BoxFit.fitWidth,
      required this.imageURL})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 5, start: 5),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade100)),
        child: CustomCashedImage(
          imageURL: imageURL,
          fit: boxFit,
        ),
      ),
    );
  }
}
