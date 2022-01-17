import 'package:e_commerce/view/widgets/custom_app_bar_icon.dart';
import 'package:e_commerce/view/widgets/review_image.dart';
import '../widgets/notification/custom_notification_element.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class FeedNotificationPage extends StatelessWidget {
  const FeedNotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.2,
        title: const CustomText(
          text: 'Feed',
          isFontBold: true,
          fontSize: 16,
        ),
        leading: const CustomAppBarIcon(),
      ),
      // body: Padding(
      //   padding: const EdgeInsetsDirectional.only(top: 20, end: 15, start: 15),
      //   child: ListView.separated(
      //       physics: const BouncingScrollPhysics(),
      //       itemBuilder: (context, index) {
      //         return const CustomNotificationElement(
      //             notificationTitle: 'New Product',
      //             notificationContent:
      //                 'Nike Air Zoom Pegasus 36 Miami - Special For your Activity',
      //             notificationTime: 'April 30, 2014 1:01 PM',
      //             notificationImage: ReviewImage(
      //               size: 50,
      //             ));
      //       },
      //       separatorBuilder: (context, index) {
      //         return const SizedBox(height: 40);
      //       },
      //       itemCount: 3),
      // ),
    );
  }
}
