import 'package:ati_ams/config/common_const.dart';
import 'package:ati_ams/pages/home/history/tabs/class_history.dart';
import 'package:ati_ams/pages/home/history/tabs/events_history.dart';
import 'package:ati_ams/pages/home/history/tabs/institute_history.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
                text: "Institute",
                // icon: Icon(Icons.favorite),
              ),
              Tab(
                text: "Class",
                // icon: Icon(Icons.list_alt),
              ),
              Tab(
                text: "Events",
                // icon: Icon(Icons.list_alt),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            InstituteHistory(),
            ClassHistory(),
            EventsHistory(),
          ],
        ),
      ),
    );
  }
}
