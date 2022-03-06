import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';

class TextFieldSquire extends StatelessWidget {
  final TextEditingController textEditingController;
  final int maxLines;

  const TextFieldSquire({
    Key? key,
    required this.textEditingController,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        // height: 48,
        child: TextFormField(
          controller: textEditingController,
          keyboardType: TextInputType.text,
          maxLines: maxLines,
          style: TextStyle(
            color: AppColor.primaryTextColor,
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(
                color: AppColor.borderColor,
                width: 1,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
              borderSide: BorderSide(
                color: AppColor.borderColor,
                width: 1,
              ),
            ),
            filled: true,
            fillColor: AppColor.iconBackground.withOpacity(0.3),
          ),
        ),
      ),
    );
  }
}
