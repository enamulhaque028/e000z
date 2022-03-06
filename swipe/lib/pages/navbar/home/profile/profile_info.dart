import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';
import 'package:swipe/pages/navbar/home/components/add_social_link_dialog.dart';

class ProfileInfo extends StatelessWidget {
  final String name;
  final String profileDesc;
  const ProfileInfo({
    Key? key,
    required this.name,
    required this.profileDesc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColor.secondaryTextColor,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 8,
          ),
          child: Text(
            profileDesc,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.primaryTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: InkWell(
                onTap: () {},
                child: Image.asset(
                  'assets/images/facebook.png',
                  fit: BoxFit.cover,
                  height: 30,
                  // width: size.width,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: InkWell(
                onTap: () {},
                child: Image.asset(
                  'assets/images/twitter.png',
                  fit: BoxFit.cover,
                  height: 30,
                  // width: size.width,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: InkWell(
                onTap: () {},
                child: Image.asset(
                  'assets/images/instagram.png',
                  fit: BoxFit.cover,
                  height: 30,
                  // width: size.width,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: AppColor.kBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      ),
                    ),
                    builder: (context) {
                      return Container(
                        margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: AddSocialLinkDialog(),
                      );
                    },
                  );
                },
                child: Image.asset(
                  'assets/images/add_icon.png',
                  fit: BoxFit.cover,
                  height: 30,
                  // width: size.width,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
