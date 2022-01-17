import 'package:e_commerce/constants/colors.dart';
import 'package:flutter/material.dart';

import '../custom_text.dart';

class CustomNotificationTitle extends StatelessWidget {
  final String title;
  final IconData titleIcon;
  final int numberOfNotification;

  const CustomNotificationTitle(
      {Key? key,
      required this.title,
      required this.titleIcon,
      required this.numberOfNotification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(titleIcon, color: primaryColor),
        const SizedBox(width: 15),
        Expanded(
          child: CustomText(
            text: title,
            isFontBold: true,
            fontSize: 16,
          ),
        ),
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: notificationColor,
            borderRadius: BorderRadius.circular(50),
          ),
          child: CustomText(
            text: '$numberOfNotification',
            alignment: Alignment.center,
            color: Colors.white,
            fontSize: 14,
            isFontBold: true,
          ),
        ),
      ],
    );
  }
}
