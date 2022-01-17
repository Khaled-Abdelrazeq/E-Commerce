import 'package:e_commerce/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFromField extends StatelessWidget {
  final String hintText;
  final String validateText;
  final TextInputType textInputType;
  final bool obscureText;
  final Function(String) onSaveFunction;
  final Function(String) onSubmittedFunction;
  final Function() onTapFunction;
  final Widget prefixIcon;
  final Widget suffixWidget;
  final TextEditingController controller;

  const CustomTextFromField(
      {Key? key,
      required this.hintText,
      required this.validateText,
      required this.onSaveFunction,
      this.textInputType = TextInputType.text,
      this.obscureText = false,
      required this.prefixIcon,
      required this.onTapFunction,
      this.suffixWidget = const Text(''),
      required this.controller,
      required this.onSubmittedFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.grey.shade600),
      onChanged: onSaveFunction,
      onTap: onTapFunction,
      onFieldSubmitted: onSubmittedFunction,
      validator: (value) {
        if (value != null && value.isNotEmpty) {
          return null;
        }
        return validateText;
      },
      keyboardType: textInputType,
      obscureText: obscureText,
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(5)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: primaryColor),
              borderRadius: BorderRadius.circular(5)),
          prefixIcon: prefixIcon,
          suffixIcon: suffixWidget,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          focusColor: Colors.white),
    );
  }
}
