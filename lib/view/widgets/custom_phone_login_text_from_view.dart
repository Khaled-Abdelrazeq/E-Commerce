import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomPhoneLoginTextFromField extends StatelessWidget {
  final String text;
  final String hintText;
  final String validateText;
  final TextInputType textInputType;
  final bool obscureText;
  final Function(String) onSaveFunction;
  final Function(CountryCode) onCountrySelected;
  // final String dropdownValue;

  const CustomPhoneLoginTextFromField({
    Key? key,
    required this.text,
    required this.hintText,
    required this.validateText,
    required this.onSaveFunction,
    this.textInputType = TextInputType.text,
    this.obscureText = false,
    // required this.dropdownValue,
    required this.onCountrySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          CountryCodePicker(
            initialSelection: 'EG',
            onChanged: onCountrySelected,
            dialogSize: const Size(350, 400),
            favorite: const ['EG'],
          ),
          const SizedBox(width: 15),
          Expanded(
            child: TextFormField(
              textAlignVertical: TextAlignVertical.center,
              inputFormatters: [
                LengthLimitingTextInputFormatter(10),
              ],
              onChanged: onSaveFunction,
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  return null;
                }
                return validateText;
              },
              keyboardType: textInputType,
              obscureText: obscureText,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  focusColor: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
