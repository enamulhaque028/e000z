import 'package:advanced_app_manager/config/presentation/app_color.dart';
import 'package:advanced_app_manager/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<bool> exitDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Confirm Exit"),
        content: const Text("Are you sure you want to exit?"),
        actions: <Widget>[
          CustomButton(
            title: 'YES',
            onTap: () {
              SystemNavigator.pop();
            },
          ),
          CustomButton(
            title: 'NO',
            onTap: () {
              Navigator.of(context).pop();
            },
            btnColor: AppColor.kDarkBlueColor,
            btnTextColor: Colors.white,
          ),
        ],
      );
    },
  );
  return Future.value(true);
}
