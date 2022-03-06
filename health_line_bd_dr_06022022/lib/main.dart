import 'dart:developer';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config/fcm_utils.dart';
import 'pages/splash/splash_page.dart';
import 'services/db/db_provider.dart';
import 'theme/theme_values.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  // Start the AlarmManager service.
  await AndroidAlarmManager.initialize();
  runApp(
    EasyLocalization(
      path: "assets/languages",
      saveLocale: true,
      preloaderColor: Colors.blue,
      supportedLocales: [
        Locale('en', 'US'),
        Locale('bn', 'BD'),
      ],
      fallbackLocale: Locale('en', 'US'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String spColorValue = '';
  ThemeData initTheme = lightTheme;

  String email = '';
  String saveUser = '';

  @override
  void initState() {
    DBProvider().initDB();
    getValuesFromSP().then((value) {
      setThemeFromSp();
    });
    super.initState();
  }

  Future getValuesFromSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      spColorValue = prefs.getString('spColorValue').toString();
      email = prefs.getString('email');
      saveUser = prefs.getString('saveUser');
    });
  }

  void setThemeFromSp() {
    log("**************************** main.dart ****************************");
    log("email: $email");
    log("saveUser: $saveUser");
    log("selectedTheme: $spColorValue");
    log("**************************** main.dart ****************************");
    if (spColorValue == 'null') {
      setState(() {
        initTheme = lightTheme;
      });
    } else if (spColorValue == 'lightTheme') {
      setState(() {
        initTheme = lightTheme;
      });
    } else if (spColorValue == 'darkTheme') {
      setState(() {
        initTheme = darkTheme;
      });
    } else if (spColorValue == 'purpleTheme') {
      setState(() {
        initTheme = purpleTheme;
      });
    } else if (spColorValue == 'tealTheme') {
      setState(() {
        initTheme = tealTheme;
      });
    } else if (spColorValue == 'greenTheme') {
      setState(() {
        initTheme = greenTheme;
      });
    } else if (spColorValue == 'greyTheme') {
      setState(() {
        initTheme = greyTheme;
      });
    } else if (spColorValue == 'pinkTheme') {
      setState(() {
        initTheme = pinkTheme;
      });
    } else
      return;
  }

  @override
  Widget build(BuildContext context) {
    // final isPlatformDark =
    //     WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
    // final initTheme = isPlatformDark ? darkTheme : lightTheme;
    return ThemeProvider(
      initTheme: initTheme,
      key: Key('$spColorValue'),
      child: Builder(builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            EasyLocalization.of(context).delegate,
          ],
          supportedLocales: EasyLocalization.of(context).supportedLocales,
          locale: EasyLocalization.of(context).locale,
          title: 'Theme',
          theme: ThemeProvider.of(context),
          home: SplashPage(
            email: email,
            saveUser: saveUser,
          ),
        );
      }),
    );
  }
}
