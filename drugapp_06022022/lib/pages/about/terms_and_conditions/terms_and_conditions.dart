import 'package:flutter/material.dart';
import 'package:mediinfo/config/CommonConstant.dart';
import 'package:easy_localization/easy_localization.dart';

termsAndConditions(BuildContext context) {
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
                            color: Color(PrimaryColor),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'developer'.tr().toString(),
                          style: TextStyle(
                            fontSize: 12,
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
                      'termsConditions.title'.tr().toString(),
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
                      'termsConditions.desc1'.tr().toString(),
                    ),
                    Text(
                      'termsConditions.desc2'.tr().toString(),
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      'termsConditions.desc3'.tr().toString(),
                    ),
                    Text(
                      'termsConditions.pTitle1'.tr().toString(),
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
                      'termsConditions.pTitle1Desc'.tr().toString(),
                    ),
                    Text(
                      'termsConditions.pTitle2'.tr().toString(),
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
                      'termsConditions.pTitle2Desc'.tr().toString(),
                    ),
                    Text(
                      'termsConditions.email'.tr().toString(),
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
                        'termsConditions.copyright'.tr().toString(),
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
