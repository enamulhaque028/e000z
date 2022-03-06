import 'package:aits_gallery/config/presentation/app_color.dart';
import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  final String btnText;
  final Function btnTap;

  CustomButtom({required this.btnText, required this.btnTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: InkWell(
        onTap: () {
          btnTap();
        },
        child: new Container(
          height: 50.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: AppColor.buttonGradient,
          ),
          child: new Center(
            child: new Text(
              btnText,
              style: new TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
