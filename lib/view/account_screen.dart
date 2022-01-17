import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: CustomText(text: 'Account Screen')),
    );
  }
}
