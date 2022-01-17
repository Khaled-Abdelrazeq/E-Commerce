import 'package:e_commerce/services/database/database_helper.dart';
import 'package:e_commerce/utils/binding.dart';
import 'package:e_commerce/view/auth/login_screen.dart';
import 'package:e_commerce/view/control_view.dart';
import 'package:e_commerce/view/home/home_screen.dart';
import 'package:e_commerce/view/main_screen.dart';
import 'package:e_commerce/view_model/main_view_model/main_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white, // navigation bar color
    statusBarColor: Colors.white, // status bar color
  ));

  DatabaseHelper.initDB();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: Binding(),
      debugShowCheckedModeBanner: false,
      home: const ControlView(),
      // home: LoginPage(),
      // home: MainControl(),
    );
  }
}
