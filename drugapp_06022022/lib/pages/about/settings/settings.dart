import 'package:flutter/material.dart';
import 'package:mediinfo/config/CommonConstant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mediinfo/config/language_constants.dart';
import 'package:mediinfo/services/db/db_provider.dart';
import 'package:mediinfo/services/web/webservices.dart';
import 'package:mediinfo/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isSwitchOn = false;
  String selected;
  DBProvider dbProvider = DBProvider();

  void choiceAction(String choice) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (choice == Languages.English) {
      //click events
      String userActivity = 'Switched language to English';
      String page = 'Settings';
      String date = DateTime.now().toString();
      dbProvider.addToClickEvent(userActivity, page, date);

      EasyLocalization.of(context).locale = Locale('en', 'US');
      prefs.setString('lang', 'EN');
      Webservice().tokenAuth().then((value) {
        Webservice().fetchCountries();
        DBProvider().initDB();
      });
    } else if (choice == Languages.Bangla) {
      //click events
      String userActivity = 'Switched language to Bangla';
      String page = 'Settings';
      String date = DateTime.now().toString();
      dbProvider.addToClickEvent(userActivity, page, date);

      EasyLocalization.of(context).locale = Locale('bn', 'BD');
      prefs.setString('lang', 'BN');
      Webservice().tokenAuth().then((value) {
        Webservice().fetchCountries();
        DBProvider().initDB();
      });
    }
  }

  @override
  void initState() {
    //click events
    String userActivity = 'User is in Settings page';
    String page = 'Settings';
    String date = DateTime.now().toString();
    dbProvider.addToClickEvent(userActivity, page, date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      brightness: Brightness.dark,
      title: Text(
        'settingsTitle'.tr().toString(),
        style: TextStyle(fontSize: 19),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Color(PrimaryColor),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Common',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              height: 40,
              child: ListTile(
                title: Text('darkTheme'.tr().toString()),
                leading: Icon(Icons.brightness_6),
                trailing: Switch(
                  value: _isSwitchOn,
                  onChanged: (val) {
                    //click events
                    String userActivity = val == false
                        ? 'Switched to Light mode'
                        : 'Switched to Dark Mode';
                    String page = 'Settings';
                    String date = DateTime.now().toString();
                    dbProvider.addToClickEvent(userActivity, page, date);
                    setState(() {
                      _isSwitchOn = val;
                      Provider.of<ThemeProvider>(context, listen: false)
                          .swapTheme();
                    });
                  },
                ),
              ),
            ),
            // Divider(
            //   color: Colors.grey[300],
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                height: 1.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey[200],
              ),
            ),
            Container(
              height: 40,
              child: ListTile(
                title: Text('language'.tr().toString()),
                leading: Icon(Icons.language),
                trailing: PopupMenuButton<String>(
                  // icon: Icon(
                  //   Icons.arrow_forward_ios,
                  //   size: 20,
                  // ),
                  initialValue: selected,
                  //onSelected: choiceAction,
                  onSelected: (val) {
                    setState(() {
                      choiceAction(val);
                      selected = val;
                    });
                  },
                  itemBuilder: (BuildContext context) {
                    return Languages.choices.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            // Padding(
            //   padding: const EdgeInsets.all(20.0),
            //   child: Text(
            //     'Misc',
            //     style: TextStyle(
            //       color: Colors.blue,
            //       fontWeight: FontWeight.w500,
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                height: 1.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey[200],
              ),
            ),
            // Container(
            //   height: 40,
            //   child: ListTile(
            //     title: Text('Open source liscenses'),
            //     leading: Icon(Icons.info),
            //     trailing: Icon(Icons.arrow_forward_ios),
            //     onTap: () {
            //       showLicensePage(
            //         useRootNavigator: false,
            //         applicationIcon: Image.asset(
            //           'assests/images/drug.png',
            //           height: 40,
            //           width: 40,
            //         ),
            //         applicationName: 'Drug App',
            //         applicationVersion: 'v1.0.0',
            //         applicationLegalese: 'Developed by ATI Limited',
            //         context: context,
            //       );
            //     },
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 8),
            //   child: Container(
            //     height: 1.0,
            //     width: MediaQuery.of(context).size.width,
            //     color: Colors.grey[200],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
