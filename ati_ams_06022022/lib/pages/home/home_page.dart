import 'package:ati_ams/pages/home/class_attendance/class_attendance_page.dart';
import 'package:ati_ams/pages/home/event/event_tab_bar_page.dart';
import 'package:ati_ams/pages/home/history/history_page.dart';
import 'package:ati_ams/pages/home/profile/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../config/common_const.dart';
import 'dashboard/dashboard_page.dart';
import 'more_options/more_options.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;
    _controller = PersistentTabController(initialIndex: 0);
    List<Widget> _buildScreens() {
      return [
        DashboardPage(),
        ClassAttendancePage(),
        EventTabBarPage(),
        ProfilePage(),
        HistoryPage(),
        Container(),
      ];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.info),
          title: ("Dashboard"),
          activeColorPrimary: Colors.blue,
          activeColorSecondary: Colors.white,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.fingerprint),
          title: ("Class"),
          activeColorPrimary: Colors.blue,
          activeColorSecondary: Colors.white,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.local_activity),
          title: ("Event"),
          activeColorPrimary: Colors.blue,
          activeColorSecondary: Colors.white,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.person),
          title: ("Profile"),
          activeColorPrimary: Colors.blue,
          activeColorSecondary: Colors.white,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(Icons.history),
          title: ("History"),
          activeColorPrimary: Colors.blue,
          activeColorSecondary: Colors.white,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
            icon: Icon(Icons.more_vert),
            title: ("Others"),
            activeColorPrimary: Colors.blue,
            activeColorSecondary: Colors.white,
            inactiveColorPrimary: CupertinoColors.systemGrey,
            onPressed: (ctx) {
              showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0)),
                  ),
                  builder: (context) {
                    return MoreOptions(
                      ctxMoreOption: context,
                    );
                  });
            }),
      ];
    }

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Color(PrimaryColor), // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: false, // Default is true.
      hideNavigationBarWhenKeyboardShows: true,
      popAllScreensOnTapOfSelectedTab: false,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
}
