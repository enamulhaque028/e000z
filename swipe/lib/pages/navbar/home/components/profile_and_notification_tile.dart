import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';

class ProfileAndNotificationTile extends StatelessWidget {
  final VoidCallback onTapProfile;
  final VoidCallback onTapNotification;
  const ProfileAndNotificationTile({
    Key? key,
    required this.onTapProfile,
    required this.onTapNotification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 16.0),
          child: InkWell(
            onTap: () {
              onTapProfile();
            },
            child: CircleAvatar(
              backgroundColor: AppColor.kBackground,
              radius: 29.0,
              child: CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage("assets/images/background.png"),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 16.0, top: 16.0),
          child: InkWell(
            onTap: () {
              onTapNotification();
            },
            child: CircleAvatar(
              backgroundColor: AppColor.kBackground,
              radius: 25,
              child: Image.asset(
                "assets/images/notification.png",
                fit: BoxFit.cover,
                height: 30,
                width: 25,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
