import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'summary_page_view.dart';

class SummaryPage extends StatefulWidget {
  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  String title;
  String days;
  bool isLoading = true;
  @override
  void initState() {
    getRespFromSP().then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  Future getRespFromSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    title = prefs.getString('title').toString();
    days = prefs.getString('days').toString();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: isLoading
          ? Center(child: CircularProgressIndicator(),)
          : SummaryView(days: days.toString()),
    );
  }
}
