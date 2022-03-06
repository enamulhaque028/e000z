import 'package:flutter/material.dart';
import 'package:cool_nav/cool_nav.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_line_bd/pages/navbar_doctor/Profile/doctor_profile.dart';
import 'package:health_line_bd/pages/navbar_patient/settings/settings_page.dart';
import 'package:health_line_bd/pages/navbar_patient/water_reminder/water_reminder_page.dart';

class BottomNavBarDoctor extends StatefulWidget {
  BottomNavBarDoctor({Key key}) : super(key: key);

  @override
  _BottomNavBarDoctorState createState() => _BottomNavBarDoctorState();
}

class _BottomNavBarDoctorState extends State<BottomNavBarDoctor> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  List<Widget> pages = [
    DoctorProfilePage(),
    WaterReminderPage(),
    SettingsPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Example'),
        // ),
        body: Center(
          child: pages[currentIndex],
        ),
        bottomNavigationBar: FlipBoxNavigationBar(
          currentIndex: currentIndex,
          verticalPadding: 20.0,
          items: <FlipBoxNavigationBarItem>[
            FlipBoxNavigationBarItem(
              name: 'Profile',
              selectedIcon: Icons.directions_walk,
              unselectedIcon: Icons.directions_walk_outlined,
              selectedBackgroundColor: Colors.greenAccent[200],
              unselectedBackgroundColor: Colors.greenAccent[100],
            ),
            FlipBoxNavigationBarItem(
              name: 'Dashboard',
              selectedIcon: FontAwesomeIcons.water,
              unselectedIcon: FontAwesomeIcons.water,
              selectedBackgroundColor: Colors.cyan,
              unselectedBackgroundColor: Colors.cyan[200],
            ),
            FlipBoxNavigationBarItem(
              name: 'Patient List',
              selectedIcon: Icons.settings,
              unselectedIcon: Icons.settings,
              selectedBackgroundColor: Colors.orangeAccent[200],
              unselectedBackgroundColor: Colors.orangeAccent[100],
            ),
            FlipBoxNavigationBarItem(
              name: 'Patient List',
              selectedIcon: Icons.settings,
              unselectedIcon: Icons.settings,
              selectedBackgroundColor: Colors.purpleAccent[200],
              unselectedBackgroundColor: Colors.purpleAccent[100],
            ),
          ],
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ));
  }
}
