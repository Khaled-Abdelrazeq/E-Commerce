import 'package:flutter/material.dart';

import 'custom_text.dart';

class StackElement extends StatelessWidget {
  final String text;
  final double startPadding, endPadding, topPadding;
  final double fontSize;
  final bool isFontBold;

  const StackElement(
      {Key? key,
      required this.text,
      required this.startPadding,
      required this.endPadding,
      required this.topPadding,
      this.fontSize = 22,
      this.isFontBold = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          start: startPadding, end: endPadding, top: topPadding),
      child: CustomText(
        text: text,
        color: Colors.white,
        maxLines: 2,
        fontSize: fontSize,
        isFontBold: isFontBold,
      ),
    );
  }
}
