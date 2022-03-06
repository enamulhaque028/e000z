import 'package:dil_app/config/common_const.dart';
import 'package:dil_app/pages/chart/chart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RadioGroup extends StatefulWidget {
  final int idVal;
  const RadioGroup({Key key, this.idVal}) : super(key: key);

  @override
  _RadioGroupState createState() => _RadioGroupState();
}

class _RadioGroupState extends State<RadioGroup> {
  // Default Radio Button Selected Item When App Starts.
  String radioButtonItem = 'Today';

  // Group Value for Radio Button.
  int id = 1;

  @override
  void initState() {
    getRespFromSP();
    super.initState();
  }

  Future getRespFromSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      id = prefs.getInt('id').toString() == 'null' ? 5 : prefs.getInt('id');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Text('Selected Radio Item = ' + '$radioButtonItem',
        //     style: TextStyle(fontSize: 21)),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Radio(
                  value: 1,
                  groupValue: id,
                  onChanged: (val) {
                    setState(() {
                      radioButtonItem = 'Today';
                      id = 1;
                    });
                  },
                ),
                Text(
                  'Today',
                  style: new TextStyle(fontSize: 17.0),
                ),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: 2,
                  groupValue: id,
                  onChanged: (val) {
                    setState(() {
                      radioButtonItem = 'Yesterday';
                      id = 2;
                    });
                  },
                ),
                Text(
                  'Yesterday',
                  style: new TextStyle(
                    fontSize: 17.0,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: 3,
                  groupValue: id,
                  onChanged: (val) {
                    setState(() {
                      radioButtonItem = 'Last 7 days';
                      id = 3;
                    });
                  },
                ),
                Text(
                  'Last 7 days',
                  style: new TextStyle(fontSize: 17.0),
                ),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: 4,
                  groupValue: id,
                  onChanged: (val) {
                    setState(() {
                      radioButtonItem = 'Last 30 days';
                      id = 4;
                    });
                  },
                ),
                Text(
                  'Last 30 days',
                  style: new TextStyle(fontSize: 17.0),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Radio(
                  value: 5,
                  groupValue: id,
                  onChanged: (val) {
                    setState(() {
                      radioButtonItem = 'Last 3 months';
                      id = 5;
                    });
                  },
                ),
                Text(
                  'Last 3 months',
                  style: new TextStyle(
                    fontSize: 17.0,
                  ),
                ),
              ],
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Row(
            children: [
              TextButton(
                child: Text("Close"),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Color(PrimaryColor),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(width: 24),
              TextButton(
                child: Text("Save"),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.green,
                ),
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  if (id == 1) {
                    prefs.setString('title', radioButtonItem);
                    prefs.setString('days', '0 days');
                    prefs.setInt('id', 1);
                  } else if (id == 2) {
                    prefs.setString('title', radioButtonItem);
                    prefs.setString('days', '-1 days');
                    prefs.setInt('id', 2);
                  } else if (id == 3) {
                    prefs.setString('title', radioButtonItem);
                    prefs.setString('days', '-7 days');
                    prefs.setInt('id', 3);
                  } else if (id == 4) {
                    prefs.setString('title', radioButtonItem);
                    prefs.setString('days', '-30 days');
                    prefs.setInt('id', 4);
                  } else if (id == 5) {
                    prefs.setString('title', radioButtonItem);
                    prefs.setString('days', '-3 months');
                    prefs.setInt('id', 5);
                  }
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChartPage(),
                    ),
                    (route) => false
                  );
                },
              )
            ],
          ),
        )
      ],
    );
  }
}
