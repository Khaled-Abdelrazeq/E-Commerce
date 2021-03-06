import 'package:e_commerce/view/widgets/stack_element.dart';
import 'package:flutter/material.dart';

import 'custom_home_timer.dart';
import 'custom_text.dart';

class TopImage extends StatelessWidget {
  const TopImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            'assets/images/home_image.png',
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        const StackElement(
          text: 'Super Flash Sale 50% Off',
          startPadding: 25,
          endPadding: 100,
          topPadding: 30,
        ),
        Positioned(
          left: 20,
          bottom: 40,
          child: Row(
            children: const [
              CustomHomeTimer(text: '08'),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: CustomText(
                  text: ':',
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              CustomHomeTimer(text: '34'),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: CustomText(
                  text: ':',
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              CustomHomeTimer(text: '52'),
            ],
          ),
        ),
      ],
    );
  }
}
