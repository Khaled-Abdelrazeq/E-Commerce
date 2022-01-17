import 'package:e_commerce/view/widgets/stack_element.dart';
import 'package:flutter/material.dart';

import 'custom_home_timer.dart';
import 'custom_text.dart';

class CarouselItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String hours;
  final String seconds;
  final String minutes;

  const CarouselItem({
    Key? key,
    required this.imagePath,
    this.title = 'Super Flash Sale 50% Off',
    this.hours = '08',
    this.minutes = '34',
    this.seconds = '52',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            imagePath,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        StackElement(
          text: title,
          startPadding: 25,
          endPadding: 100,
          topPadding: 30,
        ),
        Positioned(
          left: 20,
          bottom: 40,
          child: Row(
            children: [
              CustomHomeTimer(text: hours),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: CustomText(
                  text: ':',
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              CustomHomeTimer(text: minutes),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: CustomText(
                  text: ':',
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              CustomHomeTimer(text: seconds),
            ],
          ),
        ),
      ],
    );
  }
}
