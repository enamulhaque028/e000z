import 'package:advanced_app_manager/config/presentation/app_color.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.title,
    required this.onTap,
    this.btnColor = Colors.transparent,
    this.btnTextColor = Colors.black,
  }) : super(key: key);

  final String title;
  final Function onTap;
  final Color btnColor;
  final Color btnTextColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding:
            MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(12)),
        foregroundColor:
            MaterialStateProperty.all<Color>(AppColor.kPrimaryColor),
        backgroundColor: MaterialStateProperty.all<Color>(btnColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: const BorderSide(
              color: AppColor.kPrimaryColor,
            ),
          ),
        ),
      ),
      onPressed: () {
        onTap();
      },
      child: Text(
        title,
        style: TextStyle(fontSize: 14, color: btnTextColor),
      ),
    );
  }
}
