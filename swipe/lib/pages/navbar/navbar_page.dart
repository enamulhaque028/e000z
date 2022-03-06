import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:swipe/config/presentation/app_color.dart';
import 'package:swipe/pages/navbar/celebrity_list/celebrity_list_page.dart';
import 'package:swipe/pages/navbar/home/home_page.dart';
import 'package:swipe/pages/navbar/home/profile/profile_page.dart';
import 'chat/chat_page.dart';

class NavBarPage extends StatefulWidget {
  @override
  _NavBarPageState createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  int currentPage = 0;

  GlobalKey bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: AppColor.kBackground),
        child: Center(
          child: _getPage(currentPage),
        ),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        tabs: [
          TabData(
            iconData: Icons.home,
            title: "Home",
            // onclick: () {
            //   final FancyBottomNavigationState fState = bottomNavigationKey
            //       .currentState as FancyBottomNavigationState;
            //   fState.setPage(2);
            // },
          ),
          TabData(
            iconData: FontAwesomeIcons.facebookMessenger,
            title: "Chat",
            // onclick: () => Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => NavBarPage(),
            //   ),
            // ),
          ),
          TabData(
            iconData: Icons.person,
            title: "Celebrity List",
          ),
          TabData(
            iconData: Icons.settings,
            title: "Settings",
          ),
        ],
        initialSelection: 0,
        key: bottomNavigationKey,
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
          });
        },
      ),
    );
  }

  _getPage(int page) {
    switch (page) {
      case 0:
        return HomePage();
      case 1:
        return ChatPage();
      case 2:
        return CelebrityListPage();
      default:
        return ProfilePage();
    }
  }
}
