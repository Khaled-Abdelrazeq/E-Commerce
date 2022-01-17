import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final Alignment alignment;
  final bool isFontBold;
  final TextAlign textAlign;
  final int maxLines;
  final bool isLineThrough;
  final TextDirection textDirection;

  const CustomText(
      {Key? key,
      required this.text,
      this.color = Colors.black,
      this.fontSize = 18,
      this.isFontBold = false,
      this.textAlign = TextAlign.start,
      this.alignment = Alignment.topLeft,
      this.maxLines = 1,
      this.isLineThrough = false,
      this.textDirection = TextDirection.ltr})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(
        text,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
        textAlign: textAlign,
        textDirection: textDirection,
        style: TextStyle(
            fontSize: fontSize,
            color: color,
            decoration: isLineThrough
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            fontWeight: isFontBold ? FontWeight.bold : FontWeight.normal),
      ),
    );
  }
}
