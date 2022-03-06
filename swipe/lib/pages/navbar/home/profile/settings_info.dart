import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';
import 'package:swipe/pages/navbar/home/profile/switch_profile/switch_profile_dialog.dart';
import 'package:swipe/pages/navbar/home/profile/block/block_list_page.dart';
import 'package:swipe/pages/navbar/home/profile/favourite/favourite_list_page.dart';

class SettingsInfo extends StatefulWidget {
  final String gender;
  final String country;
  final String profileType;
  const SettingsInfo({
    Key? key,
    required this.gender,
    required this.country,
    required this.profileType,
  }) : super(key: key);

  @override
  State<SettingsInfo> createState() => _SettingsInfoState();
}

class _SettingsInfoState extends State<SettingsInfo> {
  String profileMode = '';
  @override
  void initState() {
    setState(() {
      profileMode = widget.profileType;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          children: [
            ListTile(
              leading: Image.asset(
                'assets/images/male.png',
                height: 40,
              ),
              title: Text(
                profileMode,
                style: TextStyle(
                  color: AppColor.secondaryTextColor,
                ),
              ),
              trailing: Icon(
                Icons.arrow_drop_down_sharp,
                color: Colors.blue,
                size: 28,
              ),
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
                    return SwitchProfileDialog(
                      onTapChange: (value) {
                        setState(() {
                          profileMode = value;
                        });
                      },
                    );
                  },
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Image.asset(
                'assets/images/gender_color.png',
                height: 35,
              ),
              title: Text(
                widget.gender,
                style: TextStyle(
                  color: AppColor.secondaryTextColor,
                ),
              ),
              // onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Image.asset(
                'assets/images/earth_color.png',
                height: 35,
              ),
              title: Text(
                widget.country,
                style: TextStyle(
                  color: AppColor.secondaryTextColor,
                ),
              ),
              // onTap: () {},
            ),
            Divider(),
            ListTile(
              leading: Image.asset(
                'assets/images/block.png',
                height: 35,
              ),
              title: Text(
                'Block/Unblock',
                style: TextStyle(
                  color: AppColor.secondaryTextColor,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlockListPage(),
                  ),
                );
              },
            ),
            Divider(),
            ListTile(
              leading: Image.asset(
                'assets/images/star.png',
                height: 35,
              ),
              title: Text(
                'Favourite list',
                style: TextStyle(
                  color: AppColor.secondaryTextColor,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavouriteListPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
