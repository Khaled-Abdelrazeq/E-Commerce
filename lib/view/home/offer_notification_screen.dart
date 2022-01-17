import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/view/widgets/custom_app_bar_icon.dart';
import '../widgets/notification/custom_notification_element.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class OfferNotificationPage extends StatelessWidget {
  const OfferNotificationPage({Key? key}) : super(key: key);

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
        padding: const EdgeInsetsDirectional.only(top: 20, end: 15, start: 15),
        child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return const CustomNotificationElement(
                  notificationTitle: 'The Best Title',
                  notificationContent:
                      'Culpa cillum consectetur labore nulla nulla magna irure. Id veniam culpa officia aute dolor amet deserunt ex proident commodo',
                  notificationTime: 'April 30, 2014 1:01 PM',
                  notificationImage: Icon(
                    Icons.local_offer_outlined,
                    color: primaryColor,
                  ));
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 40);
            },
            itemCount: 3),
      ),
    );
  }
}
