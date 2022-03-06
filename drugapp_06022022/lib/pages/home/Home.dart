import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mediinfo/config/CommonConstant.dart';
import 'package:mediinfo/pages/home/most_viewed_products.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mediinfo/services/db/db_provider.dart';
import 'latest_products.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DBProvider dbProvider = DBProvider();
  @override
  void initState() {
    //click events
    String userActivity = 'User is in Home tab';
    String page = 'Home';
    String date = DateTime.now().toString();
    dbProvider.addToClickEvent(userActivity, page, date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final appBar = AppBar(
      brightness: Brightness.dark,
      title: Text(
        'title'.tr().toString(),
        style: TextStyle(fontSize: 19),
        textAlign: TextAlign.center,
      ),
      backgroundColor: Color(PrimaryColor),
    );
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: height / 3,
                width: width,
                child: SizedBox(
                  height: 150.0,
                  width: 300.0,
                  child: Carousel(
                    images: [
                      ExactAssetImage("assests/images/1a.jpg"),
                      ExactAssetImage("assests/images/2.jpg"),
                      ExactAssetImage("assests/images/3.jpg"),
                      ExactAssetImage("assests/images/8.jpg")
                    ],
                  ),
                ),
              ),
              Container(
                height: 260,
                width: width,
                child: Header(),
              ),
              Container(
                height: height / 2.5,
                width: width,
                child: LatestProducts(),
              ),
              Container(
                height: height / 2.5,
                width: width,
                child: MostViewedProducts(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: 25,
              width: width,
              child: Center(
                child:
                    /*Text(
              "DRUG INTERNATIONAL LIMITED",
              style: TextStyle(
                  fontSize: 23, fontWeight: FontWeight.bold, color: Colors.red),
            )*/
                    SizedBox(
                  width: width,
                  child: Center(
                    child: TypewriterAnimatedTextKit(
                        speed: Duration(milliseconds: 500),
                        onTap: () {
                          print("Tap Event");
                        },
                        text: [
                          'name'.tr().toString(),
                          'name'.tr().toString(),
                          'name'.tr().toString(),
                          'name'.tr().toString(),
                        ],
                        textStyle: TextStyle(
                            fontSize: 23.0,
                            fontFamily: "Agne",
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                        alignment: AlignmentDirectional
                            .topStart // or Alignment.topLeft
                        ),
                  ),
                ),
              ),
            ),
            Container(
              height: 15,
              width: width,
              margin: const EdgeInsets.only(top: 5.0),
              child: Center(
                child: Text(
                  'motto'.tr().toString(),
                  style: TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                      color: Colors.red),
                ),
              ),
            ),
            Container(
              height: 200,
              width: width,
              margin: const EdgeInsets.only(left: 10.0, right: 5.0, top: 10.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Text(
                    'homeDesc'.tr().toString(),
                    style: TextStyle(
                      fontSize: 14,
                      //fontWeight: FontWeight.normal,
                      fontWeight: FontWeight.w300,
                      //color: Colors.black54,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
