import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/model/carousel_model.dart';
import 'package:e_commerce/view/widgets/cashed_image.dart';
import 'package:e_commerce/view/widgets/stack_element.dart';
import 'package:flutter/material.dart';

import 'custom_home_timer.dart';
import 'custom_text.dart';

class CarouselItem extends StatelessWidget {
  final CarouselModel model;

  const CarouselItem({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timestamp time = model.endedTime;
    Timestamp now = Timestamp.now();
    int offerTime = time.seconds - now.seconds;
    int days = (offerTime / 60 / 60) ~/ 24;
    int hours = (offerTime - (days * 24 * 60 * 60)) / 60 ~/ 60;
    int minutes =
        (offerTime - ((days * 24 * 60 * 60) + (hours * 60 * 60))) ~/ 60;
    // int sec = offerTime -
    //     ((minutes * 60) + (hours * 60 * 60) + (days * 24 * 60 * 60));
    if (days <= 0) days = 0;
    if (hours <= 0) hours = 0;
    if (minutes <= 0) minutes = 0;

    return Stack(
      alignment: Alignment.topLeft,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CustomCashedImage(
            fit: BoxFit.cover,
            imageURL: model.imageUrl!,
          ),
        ),
        StackElement(
          text: model.title!,
          startPadding: 25,
          endPadding: 100,
          topPadding: 30,
        ),
        Positioned(
          left: 20,
          bottom: 40,
          child: Row(
            children: [
              CustomHomeTimer(text: '$days'),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: CustomText(
                  text: ':',
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              CustomHomeTimer(text: '$hours'),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: CustomText(
                  text: ':',
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              CustomHomeTimer(text: '$minutes'),
            ],
          ),
        ),
      ],
    );
  }
}
