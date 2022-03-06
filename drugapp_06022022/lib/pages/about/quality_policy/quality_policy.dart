import 'package:flutter/material.dart';
import 'package:mediinfo/config/CommonConstant.dart';
import 'package:easy_localization/easy_localization.dart';

qualityPolicy(BuildContext context) {
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
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
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
                    padding: const EdgeInsets.only(top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'qualityPolicy.title'.tr().toString().toUpperCase(),
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(PrimaryColor),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'qualityPolicy.revision'.tr().toString(),
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(PrimaryColor),
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          'qualityPolicy.date'.tr().toString(),
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(PrimaryColor),
                            fontWeight: FontWeight.w300,
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 70.0),
                      child: Text(
                        'qualityPolicy.desc'.tr().toString(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: new Text("Ok"),
            backgroundColor: Color(PrimaryColor),
          ),
        ),
      ),
    ),
  );
}
