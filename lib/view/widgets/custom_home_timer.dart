import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomHomeTimer extends StatelessWidget {
  final String text;

  const CustomHomeTimer({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: CustomText(
        text: text,
        alignment: Alignment.center,
        fontSize: 20,
        isFontBold: true,
      ),
    );
  }
}
