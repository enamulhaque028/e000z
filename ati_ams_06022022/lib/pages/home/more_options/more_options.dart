import 'package:ati_ams/config/common_const.dart';
import 'package:ati_ams/pages/login/login_page.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreOptions extends StatelessWidget {
  final BuildContext ctxMoreOption;
  const MoreOptions({
    Key key,
    @required this.ctxMoreOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: Icon(
            Icons.logout,
            color: cViolet,
          ),
          title: Text('Logout'),
          onTap: () {
            // print('Send email');
            // Navigator.of(ctxMoreOption).pop();
            logOutUser(context);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.security,
            color: cViolet,
          ),
          title: Text('Privacy Policy'),
          onTap: () async {
            Navigator.of(context, rootNavigator: true).pop();
            const url =
                'https://docs.google.com/document/d/12YTOX_XP34eIJeu5b4-x_NcB4uS5TBeTv_IC_AvDixM/edit?usp=sharing';
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          },
        ),
      ],
    );
  }
}

//logout user
logOutUser(BuildContext context) {
  CoolAlert.show(
      context: context,
      type: CoolAlertType.confirm,
      text: 'Do you want to logout?',
      confirmBtnText: 'Yes',
      cancelBtnText: 'No',
      confirmBtnColor: cViolet,
      onCancelBtnTap: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
      onConfirmBtnTap: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('email');
        prefs.remove('saveUser');
        // await Phoenix.rebirth(context);
        Navigator.of(context).pop();
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => LoginPage(),
        //   ),
        // );
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
            (Route<dynamic> route) => false);
      });
}
