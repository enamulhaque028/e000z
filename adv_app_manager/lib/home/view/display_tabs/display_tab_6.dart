import 'package:advanced_app_manager/config/presentation/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_redirect/store_redirect.dart';

class DisplayTab6 extends StatelessWidget {
  const DisplayTab6({
    Key? key,
    required this.openSetting,
    required this.packageName,
  }) : super(key: key);

  final Future<bool> Function() openSetting;
  final String packageName;

  @override
  Widget build(BuildContext context) {
    final kTextStyle = TextStyle(
      fontSize: 16,
      color: Colors.black.withOpacity(0.7),
      fontWeight: FontWeight.w400,
    );
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Background data stop',
                style: kTextStyle,
              ),
              Transform.scale(
                scale: 0.8,
                child: CupertinoSwitch(
                  value: true,
                  onChanged: (val) {
                    openSetting();
                  },
                  activeColor: AppColor.kDarkBlueColor,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Install from unknown source',
                style: kTextStyle,
              ),
              Transform.scale(
                scale: 0.8,
                child: CupertinoSwitch(
                  value: true,
                  onChanged: (val) {
                    openSetting();
                  },
                  activeColor: AppColor.kDarkBlueColor,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Open app in playstore',
                style: kTextStyle,
              ),
              Transform.scale(
                scale: 0.8,
                child: CupertinoSwitch(
                  value: true,
                  onChanged: (val) {
                    StoreRedirect.redirect(androidAppId: packageName);
                  },
                  activeColor: AppColor.kDarkBlueColor,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
