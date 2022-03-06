import 'dart:convert';
import 'dart:developer';
import 'package:health_line_bd/model/location_model.dart';
import 'package:health_line_bd/model/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  ///Get location data using http://ip-api.com/json

  Future<LocationModel> fetchLocationData() async {
    Uri url = Uri.parse('http://ip-api.com/json');

    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    // log(response.body);
    // log(body);
    if (response.statusCode == 200) {
      log(response.body);
      // log('Location data retrived successful!!!');
      return locationModelFromJson(response.body);
    } else {
      log('Location data retrived failed!!!');
      // log(response.statusCode.toString());
      return jsonDecode(response.body);
    }
  }

  Future<WeatherModel> fetchWeatherData(String lat, String long) async {
    // String extUrl = 'doctor/get-all/EN';
    String apiKey1 = 'ae0acb60e8db4952e081c2fb470a1b23';
    String apiKey2 = 'bc12083e70d2d22298c2df1cec7101d9';
    Uri url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey2');

    final response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );
    // log(response.body);
    log(url.toString());
    if (response.statusCode == 200) {
      log(response.body);
      // log('Weather data retrived successful!!!');
      return weatherModelFromJson(response.body);
    } else {
      log('Weather data retrived failed!!!');
      // log(response.statusCode.toString());
      return jsonDecode(response.body);
    }
  }
}
