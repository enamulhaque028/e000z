import 'package:flutter/material.dart';
import 'package:health_line_bd/model/weather_model.dart';
import 'package:health_line_bd/services/lis/weather_service.dart';

class WeatherSuggestionTile extends StatefulWidget {
  @override
  _WeatherSuggestionTileState createState() => _WeatherSuggestionTileState();
}

class _WeatherSuggestionTileState extends State<WeatherSuggestionTile> {
  WeatherModel weatherData = new WeatherModel();
  bool isLoading = true;

  @override
  void initState() {
    WeatherService().fetchLocationData().then((value) {
      WeatherService()
          .fetchWeatherData(value.lat.toString(), value.lon.toString())
          .then((data) {
        setState(() {
          weatherData = data;
          isLoading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String temperature = isLoading
        ? ''
        : double.parse((weatherData.main.temp - 273.15).toStringAsFixed(2))
            .toString();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Weather',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 18,
        ),
        isLoading
            ? Center(
                child: Image.asset(
                  'assets/images/loader.gif',
                  height: 100,
                ),
              )
            : Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 37, 90, 210),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.network(
                      'https://raw.githubusercontent.com/noobcoder17/drinkable/master/assets/icons/02.png',
                      width: 40,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 140,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          temperature + " \u2103",
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 22,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                              ),
                              children: [
                                TextSpan(
                                    text: 'It\'s ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w300)),
                                TextSpan(
                                    text: weatherData.weather[0].main,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700)),
                                TextSpan(
                                    text: ' today!',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w300)),
                              ]),
                        ),
                        SizedBox(
                          height: 11,
                        ),
                        Text(
                          'Don\'t forget to take the water bottle with you.',
                          style: TextStyle(
                            height: 1.5,
                            color: Colors.black.withOpacity(0.6),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ],
    );
  }
}
