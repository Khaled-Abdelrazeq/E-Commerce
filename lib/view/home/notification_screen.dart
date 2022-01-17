import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/view/home/activity_notification_screen.dart';
import 'package:e_commerce/view/home/feed_notification_screen.dart';
import 'package:e_commerce/view/home/offer_notification_screen.dart';
import 'package:e_commerce/view/widgets/custom_app_bar_icon.dart';
import 'package:e_commerce/view/widgets/notification/custom_notification_title.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.2,
        title: const CustomText(
          text: 'Notification',
          isFontBold: true,
          fontSize: 16,
        ),
        leading: const CustomAppBarIcon(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.height,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Get.to(const OfferNotificationPage());
                },
                child: const CustomNotificationTitle(
                  title: 'Offer',
                  numberOfNotification: 2,
                  titleIcon: Icons.local_offer_outlined,
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Get.to(const FeedNotificationPage());
                },
                child: const CustomNotificationTitle(
                  title: 'Feed',
                  numberOfNotification: 3,
                  titleIcon: Icons.feed_outlined,
                ),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Get.to(const ActivityNotificationPage());
                },
                child: const CustomNotificationTitle(
                  title: 'Activity',
                  numberOfNotification: 3,
                  titleIcon: Icons.notifications_none_outlined,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
