import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';
import 'package:swipe/pages/navbar/celebrity_list/components/diamond_dialog.dart';

class ChatOptionTile extends StatelessWidget {
  const ChatOptionTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        width: 180,
        decoration: BoxDecoration(
          color: AppColor.iconBackground,
          border: Border.all(color: AppColor.borderColor),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: AppColor.kBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                  ),
                  builder: (context) {
                    return DiamondDialog(
                      assetIconPath: 'assets/images/video.png',
                      title: 'For video call you',
                    );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.asset(
                    'assets/images/video.png',
                    height: 20,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: AppColor.kBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                  ),
                  builder: (context) {
                    return DiamondDialog(
                      assetIconPath: 'assets/images/tel.png',
                      title: 'For audio call you',
                    );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.asset(
                    'assets/images/audio.png',
                    height: 20,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: AppColor.kBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                    ),
                  ),
                  builder: (context) {
                    return DiamondDialog(
                      assetIconPath: 'assets/images/message.png',
                      title: 'For chat call you',
                    );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.asset(
                    'assets/images/message.png',
                    height: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
