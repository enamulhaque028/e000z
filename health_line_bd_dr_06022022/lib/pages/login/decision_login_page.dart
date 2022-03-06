import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_line_bd/animation/animate_widget.dart';
import 'package:health_line_bd/pages/login/doctor/doctor_login_page.dart';
import 'package:health_line_bd/pages/navbar_doctor/bottom_navbar_doctor.dart';
import 'package:health_line_bd/widgets/clipping_class.dart';
import 'package:health_line_bd/widgets/custom_ads_dialog.dart';
import 'dart:ui';
import 'package:health_line_bd/widgets/decision_card.dart';
import '../../widgets/play_youtube_video.dart';
import 'patient/patient_login_page.dart';

class DecisionLogin extends StatefulWidget {
  @override
  _DecisionLoginState createState() => _DecisionLoginState();
}

class _DecisionLoginState extends State<DecisionLogin> {
  @override
  void initState() {
    Future.delayed(
        Duration(seconds: 6),
        () => showDialog(
            context: context,
            builder: (context) {
              return CustomAdsDialog();
            }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //change status bar properties
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      // statusBarColor: Colors.red,
      statusBarBrightness: Brightness.dark,
    ));
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // Future.delayed(Duration(seconds: 6), () => showDialogAds(context));
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 2.0),
            child: ClipPath(
              clipper: ClippingClass(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: height * 0.65,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage("assets/images/doc.png"),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: width * 0.08,
            top: height * 0.08,
            // width: width * 0.22,
            // height: height * 0.25,
            child: AnimateWidget(
              beginSize: 70.0,
              endSize: 100.0,
              child: Image.asset('assets/images/logo.png'),
            ),
          ),
          Opacity(
            opacity: 0.2,
            child: Container(
              decoration: new BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.transparent, Colors.transparent],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: height * 0.04,
            left: width * 0.15,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.end,
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // AnimateWidget(
                //   child: SizedBox(
                //     height: 30,
                //   ),
                // ),
                DecisionCard(
                  title: 'Login As Patient',
                  fontSize: 22,
                  imagePath: 'assets/images/patient.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return PatientLoginPage();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                DecisionCard(
                  title: 'Login As Doctor',
                  fontSize: 22,
                  imagePath: 'assets/images/doctor.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorLoginPage(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                DecisionCard(
                  title: 'কিভাবে Patient একাউন্ট খুলতে হয়',
                  fontSize: 16,
                  imagePath: 'assets/images/youtube_icon.png',
                  onTap: () {
                    playYoutubeVideo(
                      context: context,
                      videoId: '60HfuEi_VyE',
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
