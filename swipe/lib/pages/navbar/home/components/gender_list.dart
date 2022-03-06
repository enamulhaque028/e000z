import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';

import 'trailing_item_tile.dart';

class GenderList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: Image.asset(
            'assets/images/gender_color.png',
            height: 40,
          ),
          title: Text(
            'All',
            style: TextStyle(
              color: AppColor.primaryTextColor,
            ),
          ),
          onTap: () {},
        ),
        Divider(),
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
          trailing: TrailingItemTile(),
          onTap: () {},
        ),
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
          trailing: TrailingItemTile(),
          onTap: () {},
        ),
      ],
    );
  }
}
