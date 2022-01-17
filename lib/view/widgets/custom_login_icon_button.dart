import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomButtonSocial extends StatelessWidget {
  final String text;
  final double fontSize;
  final Alignment alignment;
  final Color textColor;
  final String imagePath;
  final Function onPressed;
  final bool isImage;
  final IconData icon;

  const CustomButtonSocial(
      {Key? key,
      required this.text,
      this.fontSize = 16,
      this.alignment = Alignment.center,
      this.textColor = Colors.black,
      required this.imagePath,
      required this.onPressed,
      this.isImage = true,
      this.icon = Icons.phone_outlined})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border(
              top: BorderSide(color: Colors.grey.shade300),
              left: BorderSide(color: Colors.grey.shade300),
              right: BorderSide(color: Colors.grey.shade300),
              bottom: BorderSide(color: Colors.grey.shade300))),
      child: MaterialButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          elevation: 0,
          color: Colors.grey.shade50,
          onPressed: () {
            onPressed();
          },
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: isImage
                    ? Image.asset(
                        imagePath,
                        width: 20,
                        fit: BoxFit.scaleDown,
                      )
                    : Icon(icon),
              ),
              Expanded(
                child: CustomText(
                  text: text,
                  alignment: alignment,
                  fontSize: fontSize,
                  color: textColor,
                ),
              ),
            ],
          )),
    );
  }
}
