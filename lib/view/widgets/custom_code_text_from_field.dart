import 'package:e_commerce/constants/colors.dart';
import 'package:flutter/material.dart';
import 'custom_text_from_field.dart';

class CustomCodeTextFromField extends StatelessWidget {
  final Function(String) onSavedFunction;
  final bool isLast;

  const CustomCodeTextFromField(
      {Key? key, required this.onSavedFunction, this.isLast = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 49,
      height: 49,
      color: codeColor,
      child: CustomTextFromField(
        validateText: '',
        //isLast: isLast,
        onSaveFunction: onSavedFunction,
        hintText: '',
        onTapFunction: () {}, prefixIcon: Text(''),
        onSubmittedFunction: (String value) {},
        controller: TextEditingController(),
      ),
    );
  }
}
