import 'package:cool_alert/cool_alert.dart';
import 'package:dil_app/api/db/db_provider.dart';
import 'package:dil_app/config/common_const.dart';
import 'package:dil_app/pages/account/account_list.dart';
import 'package:dil_app/pages/chart/chart.dart';
import 'package:dil_app/pages/complain/complain_page.dart';
import 'package:dil_app/pages/edit_profile/edit_profile_dialog.dart';
import 'package:dil_app/pages/faqs/faqs_page.dart';
import 'package:dil_app/pages/login/login_page.dart';
import 'package:dil_app/pages/recommendation/recommendation_page.dart';
import 'package:dil_app/pages/settings/settings_page.dart';
import 'package:dil_app/pages/ticketing/support_ticket.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'custom_side_menu.dart';

class DrawerMenu extends StatefulWidget {
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  String userName = '';
  bool isLoading = true;
  Future getRespFromSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userNameValue = prefs.getString('userName').toString();
    setState(() {
      userName = userNameValue == 'null' ? 'Not found!' : userNameValue;
    });
  }

  @override
  void initState() {
    getRespFromSP().then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: (MediaQuery.of(context).size.width) * 0.65,
      width: 250,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(PrimaryColor),
                    Colors.blue,
                  ],
                ),
              ),
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 50,
                        backgroundImage: AssetImage('assets/images/logo.png'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      isLoading
                          ? Container()
                          : Text(
                              userName.toString(),
                              style: TextStyle(
                                color: titleTextColor,
                                fontSize: 16,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ),
            CustomListTile(
              Icons.home,
              'Home',
              () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChartPage(),
                  ),
                );
              },
            ),
            CustomListTile(
              Icons.assignment,
              'Ticket Info',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowTicket(),
                  ),
                );
              },
            ),
            CustomListTile(
              Icons.account_circle,
              'User Account',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext ctx) => AccountListPage(),
                  ),
                );
                //Navigator.of(context).pop();
              },
            ),
            CustomListTile(
              Icons.recommend,
              'Recommendation',
              () {
                CoolAlert.show(
                    context: context,
                    type: CoolAlertType.info,
                    text: 'coming soon!');
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (BuildContext ctx) => RecommendationPage(),
                //   ),
                // );
                //Navigator.of(context).pop();
              },
            ),
            CustomListTile(
              Icons.support_agent_rounded,
              'Complain',
              () {
                CoolAlert.show(
                    context: context,
                    type: CoolAlertType.info,
                    text: 'coming soon!');
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (BuildContext ctx) => ComplainPage(),
                //   ),
                // );
                //Navigator.of(context).pop();
              },
            ),
            CustomListTile(
              Icons.help_sharp,
              'FAQs',
              () {
                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.info,
                  text: 'coming soon!',
                );
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (BuildContext ctx) => FaqsPage(),
                //   ),
                // );
                //Navigator.of(context).pop();
              },
            ),
            CustomListTile(
              Icons.edit,
              'User Profile',
              () {
                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.info,
                  text: 'coming soon!',
                );
                // showDialog(
                //   context: context,
                //   builder: (BuildContext context) => EditProfileDialog(),
                // );
                // Navigator.of(context).pop();
              },
            ),
            CustomListTile(
              FontAwesomeIcons.signOutAlt,
              'Logout',
              () {
                CoolAlert.show(
                    context: context,
                    type: CoolAlertType.warning,
                    text: 'Do you want to logout?',
                    showCancelBtn: true,
                    onConfirmBtnTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.remove('email');
                      DBProvider().deleteAllEmployees();
                      Navigator.of(context, rootNavigator: true).pop();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext ctx) => LoginPage(),
                        ),
                      );
                    });
              },
            ),
            CustomListTile(
              Icons.settings,
              'Settings',
              () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext ctx) => SettingsPage(),
                  ),
                );
                //Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
