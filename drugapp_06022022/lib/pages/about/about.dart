import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:mediinfo/config/CommonConstant.dart';
import 'package:mediinfo/pages/about/privacy_policy/privacy_policy.dart';
import 'package:mediinfo/pages/about/request/components/dropdown/dropdown_view.dart';
import 'package:mediinfo/pages/about/settings/settings.dart';
import 'package:mediinfo/pages/about/terms_and_conditions/terms_and_conditions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mediinfo/services/db/db_provider.dart';
import 'request/pharmacy_request.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  DBProvider dbProvider = DBProvider();
  @override
  void initState() {
    //click events
    String userActivity = 'User is in About page';
    String page = 'About';
    String date = DateTime.now().toString();
    dbProvider.addToClickEvent(userActivity, page, date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      brightness: Brightness.dark,
      title: Text(
        'aboutTitle'.tr().toString(),
        //'test.test2'.tr().toString(),
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 19),
      ),
      backgroundColor: Color(PrimaryColor),
      actions: <Widget>[
        Container(
          child: IconButton(
            icon: Icon(Icons.settings),
            color: Colors.white,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => SettingsPage(),
                ),
              );
            },
          ),
        ),
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListView(
          children: <Widget>[
            Card(
              elevation: 5,
              child: ListTile(
                leading: Icon(Icons.request_page_rounded),
                trailing: Icon(Icons.keyboard_arrow_right),
                title: Text('newPharmacyRequest.title'.tr().toString()),
                onTap: () async {
                  DropDownView.selectedDistrict = null;
                  DropDownView.selectedDivisions = null;
                  await requestDialog(context);
                }
              ),
            ),
            // Card(
            //   elevation: 5,
            //   child: ListTile(
            //     leading: Icon(Icons.account_circle),
            //     trailing: Icon(Icons.keyboard_arrow_right),
            //     title: Text(
            //       'company.title'.tr().toString(),
            //     ),
            //     onTap: () => companyProfile(context),
            //   ),
            // ),
            // Card(
            //   elevation: 5,
            //   child: ListTile(
            //     leading: Icon(Icons.person),
            //     trailing: Icon(Icons.keyboard_arrow_right),
            //     title: Text(
            //       'chairman.title'.tr().toString(),
            //     ),
            //     onTap: () => chairmanProfile(context),
            //   ),
            // ),
            // Card(
            //   elevation: 5,
            //   child: ListTile(
            //     leading: Icon(Icons.message),
            //     trailing: Icon(Icons.keyboard_arrow_right),
            //     title: Text(
            //       'managingDirector.title'.tr().toString(),
            //     ),
            //     onTap: () => messageFromMd(context),
            //   ),
            // ),
            // Card(
            //   elevation: 5,
            //   child: ListTile(
            //     leading: Icon(Icons.widgets),
            //     trailing: Icon(Icons.keyboard_arrow_right),
            //     title: Text(
            //       "missionVision.title".tr().toString(),
            //     ),
            //     onTap: () => missionAndVision(context),
            //   ),
            // ),
            // Card(
            //   elevation: 5,
            //   child: ListTile(
            //     leading: Icon(Icons.people),
            //     trailing: Icon(Icons.keyboard_arrow_right),
            //     title: Text(
            //       'people.title'.tr().toString(),
            //     ),
            //     onTap: () => ourPeople(context),
            //   ),
            // ),
            // Card(
            //   elevation: 5,
            //   child: ListTile(
            //     leading: Icon(Icons.assignment),
            //     trailing: Icon(Icons.keyboard_arrow_right),
            //     title: Text(
            //       'qualityPolicy.title'.tr().toString(),
            //     ),
            //     onTap: () => qualityPolicy(context),
            //   ),
            // ),
            // Card(
            //   elevation: 5,
            //   child: ListTile(
            //     leading: Icon(Icons.supervised_user_circle),
            //     trailing: Icon(Icons.keyboard_arrow_right),
            //     title: Text(
            //       'socialResponsibility.title'.tr().toString(),
            //     ),
            //     onTap: () => socialResponsibility(context),
            //   ),
            // ),
            // Card(
            //   elevation: 5,
            //   child: ListTile(
            //     leading: Icon(Icons.group_work),
            //     trailing: Icon(Icons.keyboard_arrow_right),
            //     title: Text(
            //       'sisterConcerns.title'.tr().toString(),
            //     ),
            //     onTap: () => sisterConcerns(context),
            //   ),
            // ),
            Card(
              elevation: 5,
              child: ListTile(
                leading: Icon(Icons.description),
                trailing: Icon(Icons.keyboard_arrow_right),
                title: Text(
                  'termsConditions.title'.tr().toString(),
                ),
                onTap: () => termsAndConditions(context),
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                leading: Icon(Icons.security),
                trailing: Icon(Icons.keyboard_arrow_right),
                title: Text(
                  'privacyPolicy.title'.tr().toString(),
                ),
                onTap: () => privacyPolicy(context),
              ),
            ),
            Card(
              elevation: 5,
              child: ListTile(
                leading: Icon(Icons.share),
                trailing: Icon(Icons.keyboard_arrow_right),
                title: Text('share'.tr().toString()),
                onTap: () async {
                  await FlutterShare.share(
                    title: 'Share Health Line BD Pharma',
                    text: 'Share Health Line BD Pharma with your friends and family',
                    linkUrl: 'https://play.google.com/store/apps/details?id=com.dil.pims',
                    chooserTitle: 'Share Health Line BD Pharma',
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
