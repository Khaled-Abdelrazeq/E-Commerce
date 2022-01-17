import 'package:e_commerce/constants/colors.dart';
import 'package:flutter/material.dart';

import '../custom_text.dart';

class CustomNotificationElement extends StatelessWidget {
  final String notificationTitle;
  final String notificationContent;
  final String notificationTime;
  final Widget notificationImage;

  const CustomNotificationElement(
      {Key? key,
      required this.notificationTitle,
      required this.notificationContent,
      required this.notificationTime,
      required this.notificationImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///Notification Icon
        notificationImage,
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            children: [
              /// Notification Title
              CustomText(
                text: notificationTitle,
                isFontBold: true,
                maxLines: 3,
              ),

              /// Notification body
              const SizedBox(height: 10),
              CustomText(
                text: notificationContent,
                color: Colors.grey.shade400,
                fontSize: 14,
                maxLines: 6,
              ),
              const SizedBox(height: 10),
              CustomText(
                text: notificationTime,
                fontSize: 12,
                maxLines: 3,
                color: Colors.black87,
              ),
            ],
          ),
        )
      ],
    );
  }
}
