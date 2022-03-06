import 'dart:developer';
import 'package:dil_app/api/client_info_service.dart';
import 'package:dil_app/api/db/db_provider.dart';
import 'package:dil_app/api/db/notification_provider.dart';
import 'package:dil_app/config/common_const.dart';
import 'package:dil_app/config/fcm_utils.dart';
import 'package:dil_app/custom/drawer_menu.dart';
import 'package:dil_app/custom/notification_icon.dart';
import 'package:dil_app/pages/chart/summary_page/summary_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bar_chart/bar_chart_page.dart';
import 'pie_chart/pie_chart_page.dart';

final switchValue = ValueNotifier<bool>(false);

class ChartPage extends StatefulWidget {
  final bool isNetworkCalled;
  static var userName;

  const ChartPage({Key key, this.isNetworkCalled = true}) : super(key: key);
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  bool _isSwitchOn = false;
  String days;
  String title;
  String fcmTitle;
  bool isLoading = true;
  String fcmToken;
  int tabIndex = 0;

  //get username from shared preference
  getRespFromSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userNameValue = prefs.getString('userName');
    ChartPage.userName = userNameValue == 'null' ? 'Not found!' : userNameValue;
    days = prefs.getString('days').toString();
    title = prefs.getString('title').toString();
  }

  getFirebaseToken() async {
    fcmToken = await FirebaseMessaging.instance.getToken();
    log('Token: $fcmToken');
  }

  NotificationDBProvider dbProvider = NotificationDBProvider();

  String getNotificationDate() {
    DateTime now = DateTime.now();
    String notificationDate = now.day.toString() +
        "-" +
        now.month.toString() +
        "-" +
        now.year.toString() +
        " " +
        now.hour.toString() +
        ":" +
        now.minute.toString();
    return notificationDate;
  }

  foregroundMode() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        log(notification.title);
        log(message.from);
        setState(() {
          fcmTitle = notification.title;
        });
        dbProvider.addToNotificationData(
            notification.title, notification.body, getNotificationDate());
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body)],
                  ),
                ),
              );
            });
      }
    });
  }

  //works when app is in background mode and user taps on the notification
  backgroundMode() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        log(notification.body);
        setState(() {
          fcmTitle = notification.title;
        });
        dbProvider.addToNotificationData(
            notification.title, notification.body, getNotificationDate());
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body)],
                  ),
                ),
              );
            });
      }
    });
  }

  @override
  void initState() {
    widget.isNetworkCalled == false ? Container() : DBProvider().initDB().then((_) {
      ClientApiProvider().getAllEmployees();
    });
    getRespFromSP().then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
    getFirebaseToken();
    foregroundMode();
    backgroundMode();
    NotificationDBProvider().initDB();
  }

  @override
  Widget build(BuildContext context) {
    //var width = MediaQuery.of(context).size.width;
    var titleFromSettings = isLoading
        ? ''
        : title.toString() == 'null'
            ? 'Last 3 months'
            : title;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Color(0xFFF7F4FC),
        appBar: AppBar(
          backgroundColor: Color(PrimaryColor),
          brightness: Brightness.dark,
          bottom: TabBar(
            onTap: (val) {
              setState(() {
                tabIndex = val;
              });
            },
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                icon: Icon(FontAwesomeIcons.history),
              ),
              Tab(
                icon: Icon(FontAwesomeIcons.chartPie),
              ),
              Tab(
                icon: Icon(FontAwesomeIcons.solidChartBar),
              ),
              // Tab(
              //   icon: Icon(FontAwesomeIcons.chartLine),
              // ),
            ],
          ),
          // title: _isSwitchOn == false
          //     ? Text('Ticket priority')
          //     : Text('Ticket status'),
          title: tabIndex == 0
              ? Text(
                  'Priority & Status ($titleFromSettings)',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              : Row(
                  children: [
                    Text(
                      'Priority',
                      style: _isSwitchOn == false
                          ? TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[200],
                            )
                          : TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                    ),
                    Text('/'),
                    Text(
                      'Status',
                      style: _isSwitchOn == true
                          ? TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[200],
                            )
                          : TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                    ),
                    Text(' ($titleFromSettings)',
                        style: TextStyle(color: Colors.white, fontSize: 15))
                  ],
                ),
          actions: [
            // PopupMenuByDate(),
            tabIndex == 0
                ? NamedIcon(
                    text: 'Inbox',
                    iconData: Icons.notifications,
                  )
                : Switch(
                    value: _isSwitchOn,
                    onChanged: (val) {
                      setState(() {
                        _isSwitchOn = val;
                      });
                      switchValue.value = val;
                    },
                  ),
          ],
        ),
        body: isLoading
            ? Container()
            : TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  SummaryPage(),
                  PieChartPage(
                    days: days,
                  ),
                  BarChartPage(
                    days: days,
                  ),
                  // LineChartPage(
                  //   days: days,
                  // ),
                ],
              ),
        drawer: DrawerMenu(),
      ),
    );
  }
}
