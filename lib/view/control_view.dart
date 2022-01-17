import 'package:e_commerce/view/auth/login_screen.dart';
import 'package:e_commerce/view/home/home_screen.dart';
import 'package:e_commerce/view/main_screen.dart';
import 'package:e_commerce/view_model/auth_view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControlView extends GetWidget<AuthViewModel> {
  const ControlView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (Get.find<AuthViewModel>().user != null)
          ? MainControl()
          : LoginPage();
    });
  }
}
