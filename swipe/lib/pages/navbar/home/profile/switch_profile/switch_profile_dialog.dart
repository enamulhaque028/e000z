import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';
import 'package:swipe/pages/navbar/home/profile/switch_profile/celebrity_profile_setting_page.dart';
import 'package:swipe/services/switch_profile_service.dart';
import 'package:swipe/widgets/ProgressHUD.dart';

class SwitchProfileDialog extends StatefulWidget {
  final Function(String) onTapChange;

  const SwitchProfileDialog({Key? key, required this.onTapChange})
      : super(key: key);
  @override
  State<SwitchProfileDialog> createState() => _SwitchProfileDialogState();
}

class _SwitchProfileDialogState extends State<SwitchProfileDialog> {
  bool isApiCallProcess = false;
  SwitchProfileService switchProfileService = new SwitchProfileService();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ProgressHUD(
        inAsyncCall: isApiCallProcess,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColor.iconBackground,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/switch_profile.png',
                    height: 35,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Switch your Profile',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColor.secondaryTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProfileCategoryTile(
                    title: 'General',
                    iconData: Icons.person,
                    iconColor: Colors.blue,
                    onTap: () {
                      setState(() {
                        isApiCallProcess = true;
                      });
                      switchProfileService
                          .switchProfile(userMode: 'general')
                          .then((value) {
                        if (switchProfileService.statusCode == 200) {
                          setState(() {
                            isApiCallProcess = false;
                          });
                          widget.onTapChange('General');
                          Navigator.of(context).pop();
                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.success,
                            text: value['message'],
                          );
                        } else {
                          setState(() {
                            isApiCallProcess = false;
                          });
                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.error,
                            text: 'Failed! Try again',
                          );
                        }
                      });
                    },
                  ),
                  SizedBox(width: 24),
                  ProfileCategoryTile(
                    title: 'Celebrity',
                    iconData: Icons.star,
                    iconColor: Colors.yellow[700],
                    onTap: () {
                      setState(() {
                        isApiCallProcess = true;
                      });
                      switchProfileService
                          .switchProfile(userMode: 'celebrity')
                          .then((value) {
                        if (switchProfileService.statusCode == 200) {
                          setState(() {
                            isApiCallProcess = false;
                          });
                          widget.onTapChange('Celebrity');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CelebrityProfileSettingPage(),
                            ),
                          );
                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.success,
                            text: value['message'],
                          );
                        } else {
                          setState(() {
                            isApiCallProcess = false;
                          });
                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.error,
                            text: 'Failed! Try again',
                          );
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileCategoryTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final IconData iconData;
  final Color? iconColor;

  const ProfileCategoryTile({
    Key? key,
    required this.title,
    required this.onTap,
    required this.iconData,
    required this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.iconBackground,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Icon(
                    iconData,
                    color: iconColor,
                  ),
                ),
              ),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: AppColor.primaryTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
