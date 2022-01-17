import 'package:e_commerce/constants/colors.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double fontSize;
  final Alignment alignment;
  final Color backgroundColor;
  final Color textColor;
  final Function onPressed;
  final double width;
  final bool isWidth;

  const CustomButton(
      {Key? key,
      required this.text,
      this.fontSize = 16,
      this.alignment = Alignment.topLeft,
      this.backgroundColor = primaryColor,
      this.textColor = Colors.black,
      required this.onPressed,
      this.width = 0,
      this.isWidth = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: isWidth ? width : MediaQuery.of(context).size.width,
      child: MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          elevation: 5,
          color: backgroundColor,
          onPressed: () {
            onPressed();
          },
          child: CustomText(
            text: text,
            alignment: alignment,
            fontSize: fontSize,
            color: textColor,
            isFontBold: true,
          )),
    );
  }
}
