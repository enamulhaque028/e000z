import 'package:flutter/material.dart';
import 'package:health_line_bd/animation/splash_animation/animation_screen.dart';
import 'package:health_line_bd/pages/navbar_doctor/bottom_navbar_doctor.dart';
import 'package:health_line_bd/pages/navbar_patient/bottom_navbar_patient.dart';
import 'package:health_line_bd/widgets/custom_slider.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({
    Key key,
    @required this.email,
    @required this.saveUser,
  }) : super(key: key);
  final String email;
  final String saveUser;
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values); //disable full screen
    return Material(
      child: Stack(
        children: <Widget>[
          // (saveUser.toString() == 'null' || email.toString() == 'null')
          //     // (saveUser.toString() == 'null' || email.toString() == 'null')
          //     ? CustomSlider()
          //     : BottomNavBarDoctor(),
          CustomSlider(),
          IgnorePointer(
            child: AnimationScreen(color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
