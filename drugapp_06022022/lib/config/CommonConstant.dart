import 'package:flutter/material.dart';

const PrimaryColor = 0xFF9d0c0c;

Color primaryTextColor = Color(0xFF414C6B);
Color secondaryTextColor = Color(0xFFE4979E);
Color titleTextColor = Colors.white;
Color contentTextColor = Color(0xff868686);
Color navigationColor = Color(0xFF6751B5);
Color gradientStartColor = Color(0xFF0050AC);
Color gradientEndColor = Color(0xFF9354B9);
Color cViolet = Color(0xFF34017e);

/*-----------------------------------------------------Connection-----------------------------------------------------*/
String getTokenUrl =
    'http://ati-ms:ati-pass@192.168.0.73:9199/auth-api/oauth/token?grant_type=password&username=admin&password=admin';

String localUrl = 'http://192.168.0.73:8082/product-api/';
String liveUrl = '';

String baseUrl = localUrl;
/*-----------------------------------------------------Connection-----------------------------------------------------*/
