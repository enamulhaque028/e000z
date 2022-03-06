import 'package:flutter/material.dart';
import 'package:mediinfo/config/CommonConstant.dart';
import 'package:easy_localization/easy_localization.dart';

missionAndVision(BuildContext context) {
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
                      top: 20,
                      bottom: 10.0,
                      right: 5.0,
                    ),
                    child: Image.asset(
                      'assests/images/drug.png',
                      height: 40,
                      width: 40,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      "missionVision.title".tr().toString().toUpperCase(),
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(PrimaryColor),
                        fontWeight: FontWeight.bold,
                      ),
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
                      "missionVision.desc".tr().toString(),
                    ),
                    Text(
                      "missionVision.pTitle1".tr().toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Color(PrimaryColor),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "missionVision.pTitle1Desc".tr().toString(),
                    ),
                    Text(
                      "missionVision.pTitle2".tr().toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Color(PrimaryColor),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "missionVision.pTitle2Desc".tr().toString(),
                    ),
                    Text(
                      "missionVision.pTitle3".tr().toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Color(PrimaryColor),
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 70.0),
                      child: Text(
                        "missionVision.pTitle3Desc".tr().toString(),
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
