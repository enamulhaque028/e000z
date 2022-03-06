import 'package:dil_app/pages/chart/chart.dart';
import 'package:dil_app/pages/login/custom_progress/ProgressHUD.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api/check_update_service.dart';
import 'config/fcm_utils.dart';
import 'pages/login/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp]); //lock device orientation

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // FirebaseCrashlytics.instance.crash();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  print('::::::::::::::::::Email: $email::::::::::::::::::');
  // runApp(
  //   MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     home: email == null ? LoginPage() : MainPage(),
  //   ),
  // );
  runApp(
    MyApp(email: email),
  );
}

class MyApp extends StatefulWidget {
  final String email;
  const MyApp({
    Key key,
    @required this.email,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String pMaverCode = '';
  String versionCode = '';
  @override
  void initState() {
    CheckUpdate().fetchInfo().then((value) {
      setState(() {
        pMaverCode = value['details']['P_MAVERCODE'].toString();
        // pMaverCode = '8';
      });
    }).then((value) {
      getAppVersionCode();
    });
    super.initState();
  }

  Future getAppVersionCode() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      versionCode = packageInfo.buildNumber.toString();
    });
    print('app_version_code: $versionCode');
    print('pMaver_code: $pMaverCode');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: widget.email.toString() == 'null'
          ? LoginPage()
          : pMaverCode == versionCode
          // : pMaverCode == '8'
              ? ChartPage()
              : LoginPage(),
      // home: MyHomePage(),
    );
  }
}
