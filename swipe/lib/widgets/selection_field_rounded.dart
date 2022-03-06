import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';

class SelectionFieldRounded extends StatelessWidget {
  final String placeholderText;
  final String iconPath;
  final double iconHeight;
  final VoidCallback onTap;

  const SelectionFieldRounded({
    Key? key,
    required this.placeholderText,
    required this.iconPath,
    this.iconHeight = 25.0,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.borderColor, width: 1),
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
          ),
          child: Row(
            children: [
              SizedBox(width: 16),
              Image.asset(
                iconPath,
                height: iconHeight,
              ),
              SizedBox(width: 16),
              Text(
                placeholderText,
                style: TextStyle(
                  color: AppColor.primaryTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
