import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';

class GenderListDialog extends StatelessWidget {
  final Function(String) onTapChangeGender;
  const GenderListDialog({
    required this.onTapChangeGender,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: Image.asset(
            'assets/images/male.png',
            height: 40,
          ),
          title: Text(
            'Male',
            style: TextStyle(
              color: AppColor.primaryTextColor,
            ),
          ),
          onTap: () {
            onTapChangeGender('Male');
          },
        ),
        Divider(),
        ListTile(
          leading: Image.asset(
            'assets/images/female.png',
            height: 40,
          ),
          title: Text(
            'Female',
            style: TextStyle(
              color: AppColor.primaryTextColor,
            ),
          ),
          onTap: () {
            onTapChangeGender('Female');
          },
        ),
      ],
    );
  }
}
