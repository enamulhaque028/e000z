import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';

class CustomButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onTap;
  const CustomButton({
    Key? key,
    required this.iconData,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0XFF49c5fb),
      ),
      child: IconButton(
        onPressed: () {
          onTap();
        },
        icon: Icon(
          iconData,
          color: AppColor.kBackground,
        ),
      ),
    );
  }
}
