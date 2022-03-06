import 'package:flutter/material.dart';
import 'package:mediinfo/config/CommonConstant.dart';
import 'package:easy_localization/easy_localization.dart';

privacyPolicy(BuildContext context) {
  showDialog(
    context: context,
    useRootNavigator: false,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 10,
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView(
            children: <Widget>[
              //SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10.0,
                      right: 10.0,
                    ),
                    child: Image.asset(
                      'assests/images/drug.png',
                      height: 40,
                      width: 40,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'appName'.tr().toString(),
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(PrimaryColor),
                          ),
                        ),
                        Text(
                          'version'.tr().toString(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(PrimaryColor),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'developer'.tr().toString(),
                          style: TextStyle(
                            fontSize: 12,
                            //color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            color: Color(PrimaryColor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Container(
                //padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'privacyPolicy.title'.tr().toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(PrimaryColor),
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      'privacyPolicy.desc'.tr().toString(),
                    ),
                    Text(
                      'privacyPolicy.pTitle1'.tr().toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(PrimaryColor),
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      'privacyPolicy.pTitle1Desc1'.tr().toString(),
                    ),
                    Text(
                      'privacyPolicy.pTitle1Desc2'.tr().toString(),
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      'privacyPolicy.pTitle2'.tr().toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(PrimaryColor),
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      'privacyPolicy.pTitle2Desc'.tr().toString(),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'privacyPolicy.pTitle3'.tr().toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(PrimaryColor),
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      'privacyPolicy.pTitle3Desc'.tr().toString(),
                    ),
                    Text(
                      'privacyPolicy.pTitle4'.tr().toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(PrimaryColor),
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      'privacyPolicy.pTitle4Desc'.tr().toString(),
                    ),
                    Text(
                      'privacyPolicy.pTitle5'.tr().toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(PrimaryColor),
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      'privacyPolicy.pTitle5Desc'.tr().toString(),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'privacyPolicy.pTitle6'.tr().toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(PrimaryColor),
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      'privacyPolicy.pTitle6Desc'.tr().toString(),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'privacyPolicy.pTitle7'.tr().toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(PrimaryColor),
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      'privacyPolicy.pTitle7Desc'.tr().toString(),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'privacyPolicy.pTitle8'.tr().toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(PrimaryColor),
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      'privacyPolicy.pTitle8Desc'.tr().toString(),
                    ),
                    Text(
                      'privacyPolicy.pTitle9'.tr().toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(PrimaryColor),
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      'privacyPolicy.pTitle9Desc'.tr().toString(),
                    ),
                    Text(
                      'privacyPolicy.email'.tr().toString(),
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 70.0),
                      child: Text(
                        'privacyPolicy.copyright'.tr().toString(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Add your onPressed code here!
              Navigator.of(context).pop();
            },
            // label: Text('Ok'),
            child: new Text("Ok"),
            backgroundColor: Color(PrimaryColor),
          ),
        ),
      ),
    ),
  );
}
