import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/view/auth/login_screen.dart';
import 'package:e_commerce/view/widgets/custom_button.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:e_commerce/view/widgets/custom_text_from_field.dart';
import 'package:e_commerce/view_model/auth_view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Registrationscreen extends GetWidget<AuthViewModel> {
  Registrationscreen({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade50,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/facebook.png',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 30),
                      const CustomText(
                        alignment: Alignment.center,
                        text: 'Let’s Get Started',
                        color: Colors.black,
                        fontSize: 16,
                        isFontBold: true,
                      ),
                      const SizedBox(height: 10),
                      CustomText(
                        alignment: Alignment.center,
                        text: 'Create an new account',
                        fontSize: 15,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 20),
                      CustomTextFromField(
                        controller: TextEditingController(),
                        hintText: 'Full Name',
                        validateText: 'Name can\'t be empty!',
                        textInputType: TextInputType.emailAddress,
                        onSaveFunction: (value) {
                          controller.name = value;
                        },
                        prefixIcon: const Icon(Icons.person),
                        onTapFunction: () {},
                        onSubmittedFunction: (String value) {},
                      ),
                      const SizedBox(height: 10),
                      CustomTextFromField(
                        controller: TextEditingController(),
                        hintText: 'Your Email',
                        validateText: 'Email can\'t be empty!',
                        textInputType: TextInputType.emailAddress,
                        onSaveFunction: (value) {
                          controller.email = value;
                        },
                        prefixIcon: const Icon(Icons.email_outlined),
                        onTapFunction: () {},
                        onSubmittedFunction: (String value) {},
                      ),
                      const SizedBox(height: 10),
                      CustomTextFromField(
                        controller: TextEditingController(),
                        hintText: 'Password',
                        validateText: 'Password can\'t be empty!',
                        textInputType: TextInputType.visiblePassword,
                        obscureText: true,
                        onSaveFunction: (value) {
                          controller.password = value;
                        },
                        prefixIcon: const Icon(Icons.lock_outline),
                        onTapFunction: () {},
                        onSubmittedFunction: (String) {},
                      ),
                      const SizedBox(height: 10),
                      CustomTextFromField(
                        controller: TextEditingController(),
                        hintText: 'Password Again',
                        validateText: 'Password can\'t be empty!',
                        textInputType: TextInputType.visiblePassword,
                        obscureText: true,
                        onSaveFunction: (value) {
                          controller.passwordAgain = value;
                        },
                        prefixIcon: const Icon(Icons.lock_outline),
                        onTapFunction: () {},
                        onSubmittedFunction: (String value) {},
                      ),
                      const SizedBox(height: 15),
                      ConditionalBuilder(
                        condition: !(controller.isLoading),
                        fallback: (BuildContext context) {
                          debugPrint('${controller.isLoading}');
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                        builder: (BuildContext context) {
                          return CustomButton(
                              text: 'Sign Up',
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  controller.isLoading = true;
                                  controller.signUpWithEmailAndPassword();
                                }
                              },
                              alignment: Alignment.center,
                              textColor: Colors.white,
                              fontSize: 14);
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustomText(
                            text: 'have a account? ',
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.offAll(LoginPage());
                            },
                            child: const CustomText(
                              text: 'Sign In',
                              color: primaryColor,
                              fontSize: 14,
                              isFontBold: true,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
