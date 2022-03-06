import 'package:flutter/material.dart';
import 'package:cool_nav/cool_nav.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_line_bd/pages/navbar_patient/accounts/accounts_list_page.dart';
import 'package:health_line_bd/pages/navbar_patient/profile/user_profile.dart';
import 'package:health_line_bd/pages/navbar_patient/report/patient_report_page.dart.dart';
import 'package:health_line_bd/pages/navbar_patient/settings/settings_page.dart';
import 'package:health_line_bd/pages/navbar_patient/step_counter/step_counter.dart';
import 'package:health_line_bd/pages/navbar_patient/water_reminder/water_reminder_page.dart';
import 'home/home_page.dart';

class BottomNavBarPatient extends StatefulWidget {
  BottomNavBarPatient({Key key}) : super(key: key);

  @override
  _BottomNavBarPatientState createState() => _BottomNavBarPatientState();
}

class _BottomNavBarPatientState extends State<BottomNavBarPatient> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  List<Widget> pages = [
    HomePage(),
    // AllDoctorsPage(),
    PatientReportPage(),
    UserProfile(isIdFromAccount: false, pId: ''),
    AccountsListPage(),
    StepCounterPage(),
    WaterReminderPage(),
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
              name: 'Home',
              selectedIcon: Icons.home,
              unselectedIcon: Icons.home_outlined,
              selectedBackgroundColor: Colors.deepPurpleAccent[200],
              unselectedBackgroundColor: Colors.deepPurpleAccent[100],
            ),
            FlipBoxNavigationBarItem(
              name: 'Report',
              selectedIcon: Icons.menu_book,
              unselectedIcon: Icons.menu_book_outlined,
              selectedBackgroundColor: Colors.indigoAccent[200],
              unselectedBackgroundColor: Colors.indigoAccent[100],
            ),
            FlipBoxNavigationBarItem(
              name: 'Profile',
              selectedIcon: Icons.person,
              unselectedIcon: Icons.person_outline_outlined,
              selectedBackgroundColor: Colors.greenAccent[200],
              unselectedBackgroundColor: Colors.greenAccent[100],
            ),
            FlipBoxNavigationBarItem(
              name: 'Accounts',
              selectedIcon: Icons.account_box,
              unselectedIcon: Icons.account_box_outlined,
              selectedBackgroundColor: Colors.grey[200],
              unselectedBackgroundColor: Colors.grey[100],
            ),
            FlipBoxNavigationBarItem(
              name: 'Step',
              selectedIcon: Icons.directions_walk,
              unselectedIcon: Icons.directions_walk_outlined,
              selectedBackgroundColor: Colors.redAccent[200],
              unselectedBackgroundColor: Colors.redAccent[100],
            ),
            FlipBoxNavigationBarItem(
              name: 'Water',
              selectedIcon: FontAwesomeIcons.water,
              unselectedIcon: FontAwesomeIcons.water,
              selectedBackgroundColor: Colors.cyan,
              unselectedBackgroundColor: Colors.cyan[200],
            ),
            FlipBoxNavigationBarItem(
              name: 'Settings',
              selectedIcon: Icons.settings,
              unselectedIcon: Icons.settings,
              selectedBackgroundColor: Colors.orangeAccent[200],
              unselectedBackgroundColor: Colors.orangeAccent[100],
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
