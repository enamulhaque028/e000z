import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';

class ChatHeaderTile extends StatelessWidget {
  const ChatHeaderTile({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.activeStatus,
  }) : super(key: key);

  final String imageUrl;
  final String name;
  final String activeStatus;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: 110,
      width: size.width,
      child: Card(
        color: AppColor.kBackground,
        elevation: 0.3,
        margin: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColor.kBackground,
                radius: 29.0,
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(
                    imageUrl,
                  ),
                ),
              ),
              title: Text(
                name,
                style: TextStyle(
                  color: AppColor.secondaryTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                activeStatus,
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w400,
                ),
              ),
              trailing: Icon(
                Icons.more_vert,
                color: AppColor.secondaryTextColor,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
