import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';

class TextFieldRounded extends StatelessWidget {
  final String placeholderText;
  final TextEditingController textEditingController;
  final bool readOnly;
  final IconData icon;
  final bool obscureText;
  final Color textColor;

  const TextFieldRounded({
    Key? key,
    required this.placeholderText,
    required this.textEditingController,
    this.readOnly = false,
    required this.icon,
    this.obscureText = false,
    this.textColor = AppColor.primaryTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        height: 48,
        child: TextFormField(
          controller: textEditingController,
          validator: (value) => value!.isEmpty ? '* required' : null,
          readOnly: readOnly,
          obscureText: obscureText,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: placeholderText,
            labelStyle: TextStyle(
              color: textColor,
              fontSize: 15,
            ),
            prefixIcon: Icon(
              icon,
              color: AppColor.primaryTextColor,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(
                color: AppColor.borderColor,
                width: 1,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(
                color: AppColor.borderColor,
                width: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
