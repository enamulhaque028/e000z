import 'package:ati_ams/config/common_const.dart';
import 'package:ati_ams/pages/home/event/event_page.dart';
import 'package:flutter/material.dart';

import 'activity_create_page.dart';

class EventTabBarPage extends StatefulWidget {
  const EventTabBarPage({Key key}) : super(key: key);

  @override
  _EventTabBarPageState createState() => _EventTabBarPageState();
}

class _EventTabBarPageState extends State<EventTabBarPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Color(0xffeaf4ff),
        appBar: AppBar(
          brightness: Brightness.dark,
          toolbarHeight: 50,
          backgroundColor: Color(PrimaryColor),
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.all(5.0),
            indicatorColor: Colors.transparent,
            tabs: [
              Tab(
                text: "Event",
                // icon: Icon(Icons.favorite),
              ),
              Tab(
                text: "Activity",
                // icon: Icon(Icons.list_alt),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            EventPage(),
            ActivityCreatePage(),
          ],
        ),
      ),
    );
  }
}
