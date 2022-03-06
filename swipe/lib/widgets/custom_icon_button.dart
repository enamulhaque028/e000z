import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';

class CustomIconButton extends StatelessWidget {
  final String title;
  final String assetImgIcon;
  final VoidCallback onTapBtn;
  const CustomIconButton({
    Key? key,
    required this.title,
    required this.onTapBtn,
    required this.assetImgIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        onTapBtn();
      },
      child: Container(
        height: 48,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.borderColor),
          borderRadius: BorderRadius.all(
            Radius.circular(25),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(right: width * 0.1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                assetImgIcon,
                height: 25,
                width: 25,
              ),
              Text(
                title,
                style: TextStyle(
                  color: AppColor.primaryTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
