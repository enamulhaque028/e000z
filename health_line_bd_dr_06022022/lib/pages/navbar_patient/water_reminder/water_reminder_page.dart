import 'package:flutter/material.dart';
import 'package:health_line_bd/pages/navbar_patient/water_reminder/components/water/add_water_dialog.dart';
import 'package:health_line_bd/services/db/db_provider.dart';
import 'components/water/goad_and_drink.dart';
import 'components/weather/weather_suggestion.dart';

class WaterReminderPage extends StatefulWidget {
  @override
  _WaterReminderPageState createState() => _WaterReminderPageState();
}

class _WaterReminderPageState extends State<WaterReminderPage> {
  double goal = 0.0; // litre
  double waterDrunk = 0.0; // litre
  double weight = 64; // kg
  int age = 27;
  int ageRangeValue = 0; // [age<30] => 40; [age=[30-55]] => 35; [age>55] => 30
  DBProvider dbProvider = DBProvider();

  int calculateAgeRange() {
    if (age < 30) {
      setState(() {
        ageRangeValue = 40;
      });
    } else if (age > 55) {
      setState(() {
        ageRangeValue = 30;
      });
    } else {
      setState(() {
        ageRangeValue = 35;
      });
    }
    print('Age Range Value: $ageRangeValue');
    return ageRangeValue;
  }

  void calculateWaterGoal() {
    setState(() {
      goal = (weight * 2.20462 * ageRangeValue * 0.0295735) / (2.2 * 28.3);
    });

    dbProvider.getTotalWaterDrunk().then((value) {
      setState(() {
        waterDrunk = double.parse(value);
      });
    });

    //insert goal to db
    // dbProvider.addToWaterReminderData(
    //   goal.toString(),
    //   '0',
    //   DateTime.now().toIso8601String(),
    // );
  }

  @override
  void initState() {
    calculateAgeRange();
    calculateWaterGoal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              GoalAndDrinkWaterTile(
                goal: goal,
                waterDrunk: waterDrunk,
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 20),
                child: WeatherSuggestionTile(),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 3,
        backgroundColor: Color.fromARGB(255, 0, 60, 192),
        child: Icon(
          Icons.add,
          size: 30,
        ),
        onPressed: () async {
          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
            ),
            builder: (context) {
              return AddWaterDialog(
                totalGlassofWaterTaken: (waterDrunk * 4).toStringAsFixed(0),
                onTapChanged: (value) {
                  dbProvider
                      .addToWaterReminderData(
                    goal.toString(),
                    value,
                    DateTime.now().toIso8601String(),
                  )
                      .then((value) {
                    dbProvider.getTotalWaterDrunk().then((value) {
                      setState(() {
                        waterDrunk = double.parse(value);
                      });
                    });
                  });
                  Navigator.of(context).pop();
                },
              );
            },
          );
        },
      ),
    );
  }
}
