import 'dart:math';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:e_commerce/constants/colors.dart';
import 'package:e_commerce/view/widgets/custom_button.dart';
import 'package:e_commerce/view/widgets/custom_code_text_from_field.dart';
import 'package:e_commerce/view/widgets/custom_phone_login_text_from_view.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:e_commerce/view_model/auth_view_model/auth_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';

class PhoneAuthentication extends GetWidget<AuthViewModel> {
  PhoneAuthentication({Key? key}) : super(key: key);

  var formKey = GlobalKey<FormState>();

  int randWaveDraw = Random().nextInt(3);

  void listenToCode() async {
    await SmsAutoFill().listenForCode;
  }

  @override
  Widget build(BuildContext context) {
    listenToCode();
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back();
            }),
      ),
      body: SafeArea(
        child: GetBuilder<AuthViewModel>(
          init: AuthViewModel(),
          builder: (controller) {
            return Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20.0, left: 16, right: 16),
                    child: Column(
                      children: [
                        if (controller.isLoading)
                          const LinearProgressIndicator(),
                        const SizedBox(height: 90),
                        // To Enter your phone number
                        Visibility(
                          visible: !controller.optCodeVisible,
                          child: Column(
                            children: [
                              const CustomText(
                                text: 'Please enter your mobile number',
                                alignment: Alignment.center,
                                fontSize: 20,
                                isFontBold: true,
                              ),
                              const SizedBox(height: 10),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: const CustomText(
                                  text: 'You’ll receive a 6 digit code',
                                  alignment: Alignment.center,
                                  textAlign: TextAlign.center,
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 20),
                              CustomPhoneLoginTextFromField(
                                onCountrySelected: (value) {
                                  controller.countryPhoneCode = value.dialCode!;
                                },
                                text: 'Phone number',
                                hintText: 'Mobile Number',
                                validateText: 'Please, enter your number',
                                obscureText: false,
                                textInputType: TextInputType.phone,
                                onSaveFunction: (value) {
                                  controller.phoneNumber = value;
                                },
                              ),
                              const SizedBox(height: 20),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                        // To Enter your code
                        Visibility(
                          visible: controller.optCodeVisible,
                          child: Column(
                            children: [
                              const CustomText(
                                text: 'Verify Phone',
                                alignment: Alignment.center,
                                fontSize: 20,
                                isFontBold: true,
                              ),
                              const SizedBox(height: 10),
                              GestureDetector(
                                onTap: () {
                                  debugPrint(controller.msgCodeSent);
                                  controller.update();
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 70),
                                  child: CustomText(
                                    text: controller.msgCodeSent,
                                    alignment: Alignment.center,
                                    textAlign: TextAlign.center,
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     CustomCodeTextFromField(
                              //         onSavedFunction: (String value) {
                              //       controller.otpCode[0] = value;
                              //     }),
                              //     CustomCodeTextFromField(
                              //         onSavedFunction: (String value) {
                              //       controller.otpCode[1] = value;
                              //     }),
                              //     CustomCodeTextFromField(
                              //         onSavedFunction: (String value) {
                              //       controller.otpCode[2] = value;
                              //     }),
                              //     CustomCodeTextFromField(
                              //         onSavedFunction: (String value) {
                              //       controller.otpCode[3] = value;
                              //     }),
                              //     CustomCodeTextFromField(
                              //         onSavedFunction: (String value) {
                              //       controller.otpCode[4] = value;
                              //     }),
                              //     CustomCodeTextFromField(
                              //         onSavedFunction: (String value) {
                              //           controller.otpCode[5] = value;
                              //         },
                              //         isLast: true)
                              //   ],
                              // ),

                              PinFieldAutoFill(
                                  decoration: const BoxLooseDecoration(
                                    radius: Radius.circular(0),
                                    textStyle: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                    bgColorBuilder:
                                        FixedColorBuilder(codeColor),
                                    strokeColorBuilder:
                                        FixedColorBuilder(codeColor),
                                  ),
                                  currentCode: '      ',
                                  onCodeSubmitted: (code) {},
                                  onCodeChanged: (code) {
                                    if (code!.length == 6) {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      controller.otpCode = code;
                                      debugPrint(code);
                                      debugPrint(controller.otpCode);
                                      if (controller.otpCode != '      ' &&
                                          controller.otpCode.isNotEmpty) {
                                        controller.verifyCode();
                                      }
                                    }
                                  },
                                  codeLength: 6 //code length, default 6
                                  ),

                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CustomText(
                                    text: 'Didn’t receive the code?  ',
                                    color: Colors.grey,
                                    fontSize: 14,
                                    alignment: Alignment.center,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.isLoading = true;
                                      String number =
                                          '${controller.countryPhoneCode}${controller.phoneNumber}';
                                      controller.verifyNumber(number);
                                    },
                                    child: const CustomText(
                                      text: 'Request Again',
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                        ConditionalBuilder(
                          condition: !controller.isLoading,
                          fallback: (BuildContext context) {
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                          builder: (BuildContext context) {
                            return CustomButton(
                                alignment: Alignment.center,
                                textColor: Colors.white,
                                width: MediaQuery.of(context).size.width,
                                isWidth: true,
                                text: controller.optCodeVisible
                                    ? 'VERIFY AND CONTINUE'
                                    : 'CONTINUE',
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    controller.isLoading = true;
                                    if (controller.optCodeVisible) {
                                      controller.verifyCode();
                                    } else {
                                      //await SmsAutoFill().listenForCode();
                                      String number =
                                          '${controller.countryPhoneCode}${controller.phoneNumber}';
                                      controller.msgCodeSent =
                                          'Code sent to: $number';
                                      controller.verifyNumber(number);
                                    }
                                  }
                                });
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
