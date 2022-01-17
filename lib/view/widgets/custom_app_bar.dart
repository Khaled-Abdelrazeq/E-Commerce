import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final Function() onBackButtonClicked;
  final IconData icon;
  final bool isIconViewd;

  const CustomAppBar({
    Key? key,
    required this.title,
    required this.onBackButtonClicked,
    this.icon = Icons.arrow_back_ios,
    this.isIconViewd = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (isIconViewd)
          IconButton(
            icon: Icon(
              icon,
              color: Colors.grey,
              size: 25,
            ),
            onPressed: onBackButtonClicked,
          ),
        CustomText(
          text: title,
          fontSize: 22,
          isFontBold: true,
          alignment: Alignment.center,
        )
      ],
    );
  }
}
