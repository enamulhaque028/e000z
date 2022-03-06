import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/home/home_page.dart';
import 'pages/login/login_page.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String email = prefs.getString('email');
  String saveUser = prefs.getString('saveUser');
  log("email: $email");
  log("saveUser: $saveUser");
  runApp(
    Phoenix(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AMS',
        home: (saveUser.toString() == 'null' || email.toString() == 'null')
            ? LoginPage()
            : HomePage(),
        // home: HomePage(),
      ),
    ),
  );
}
