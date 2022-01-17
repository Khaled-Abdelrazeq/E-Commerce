import 'package:e_commerce/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class CustomTextFromFieldWithoutIcons extends StatelessWidget {
  final String hintText;
  final TextInputType textInputType;
  final Function(String) onSaveFunction;
  final TextEditingController controller;
  final bool isFontBold;
  final String validateText;

  const CustomTextFromFieldWithoutIcons({
    Key? key,
    required this.hintText,
    required this.onSaveFunction,
    this.textInputType = TextInputType.text,
    required this.controller,
    this.isFontBold = false,
    this.validateText = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value != null && value.isNotEmpty) {
          return null;
        }
        return validateText;
      },
      style: TextStyle(
          color: Colors.grey.shade600,
          fontWeight: isFontBold ? FontWeight.bold : FontWeight.normal),
      onChanged: onSaveFunction,
      keyboardType: textInputType,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(5)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: primaryColor),
              borderRadius: BorderRadius.circular(5)),
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          focusColor: Colors.white),
    );
  }
}
