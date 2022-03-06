import 'package:dil_app/config/common_const.dart';
import 'package:flutter/material.dart';
import 'radio_group_widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Setings'),
        brightness: Brightness.dark,
        backgroundColor: Color(PrimaryColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'WelCome!\n\nATI S&M will help you to manage your ticketing history',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(PrimaryColor),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: width * 0.25),
                child: RadioGroup(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
