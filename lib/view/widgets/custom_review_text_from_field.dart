import 'package:e_commerce/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomReviewTextFromField extends StatelessWidget {
  final Function(String) onChangedFunction;
  final String hintText;
  final String validateText;

  const CustomReviewTextFromField({
    Key? key,
    required this.onChangedFunction,
    required this.hintText,
    required this.validateText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChangedFunction,
      maxLines: 10,
      style: const TextStyle(color: Colors.grey),
      validator: (value) {
        if (value != null && value.isNotEmpty) {
          return null;
        }
        return validateText;
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade100),
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
