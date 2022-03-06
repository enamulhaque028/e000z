import 'package:dil_app/config/common_const.dart';
import 'package:dil_app/pages/ticketing/results/results_page.dart';
import 'package:dil_app/pages/ticketing/ticket_list/ticket_list_page.dart';
import 'package:flutter/material.dart';
import 'closed/closed_page.dart';
import 'help/submit_issue/submit_issue_page.dart';

class ShowTicket extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          // appBar: AppBar(
          //   backgroundColor: Color(PrimaryColor),
          //   title: Text("Title text"),
          // ),
          bottomNavigationBar: menu(),
          body: TabBarView(
            children: [
              // Container(child: Icon(Icons.directions_car)),
              TicketListPage(),
              AddIssue(),
              ResultsPage(),
              ClosedPage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget menu() {
    return Container(
      height: 60,
      color: Color(PrimaryColor),
      child: TabBar(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white70,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(5.0),
        indicatorColor: Color(PrimaryColor),
        tabs: [
          Tab(
            text: "T. List",
            icon: Icon(Icons.assignment),
          ),
          Tab(
            text: "Add New",
            icon: Icon(Icons.add_box),
          ),
          Tab(
            text: "Results",
            icon: Icon(Icons.check_box),
          ),
          Tab(
            text: "Closed",
            icon: Icon(Icons.check),
          ),
        ],
      ),
    );
  }
}
