import 'dart:convert';
import 'dart:developer';
import 'package:mediinfo/config/CommonConstant.dart';
import 'package:mediinfo/models/country.dart';
import 'package:http/http.dart' as http;
import 'package:mediinfo/models/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../db/db_provider.dart';

class Webservice {
  Future<Token> tokenAuth({Map map}) async {
    // String url =
    //     'http://192.168.0.91:8180/auth-api/oauth/token?grant_type=password&username=admin&password=admin';
    // await http.post(
    //   url,
    //   headers: {
    //     'Content-type': 'application/json',
    //     'Accept': 'application/json',
    //     'authorization': 'Basic YXRpLW1zOmF0aS1wYXNz'
    //   },
    String url = getTokenUrl;
    await http.post(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    ).then((response) {
      if (response.statusCode == 200) {
        String token = Token.fromJson(json.decode(response.body)).accessToken;
        String tokenType = Token.fromJson(json.decode(response.body)).tokenType;
        Token().setToken(token);
        Token().setTokenType(tokenType);
        print('Token: $token');
        return Token.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed auth');
      }
    });
  }

  Future<List<Country>> fetchCountries() async {
    String token = await Token().getToken();
    String tokenType = await Token().getTokenType();
    log('Token: $token');
    log('Token Type: $tokenType');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var langCode = prefs.getString('lang');
    langCode == null ? langCode = 'EN' : langCode = langCode;
    print('Language Code: $langCode');

    String extUrl = 'product/findByLan/$langCode';
    // String url =
    //     "http://192.168.0.91:8085/product-api/product/get-by-lan/$langCode";
    String url = baseUrl + extUrl;
    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': '$tokenType $token',
      },
    );
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      print(body);
      final Iterable json = body;
      return json.map((country) {
        log('::::::::::::::::::::::::::::::::::::::::::::: Inserting Data :::::::::::::::::::::::::::::::::::::::::::::');
        print('Inserting $country');
        DBProvider.db.createEmployee(Country.fromJson(country));
      }).toList();
    } else {
      throw Exception("Unable to perform request!");
    }
  }
}
