import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TermsConditions extends StatefulWidget {
  const TermsConditions({
    Key key,
  }) : super(key: key);

  @override
  _TermsConditionsState createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Agree"),
      onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('policy', 'showed');
        Navigator.pop(context);
      },
    );
    return AlertDialog(
      title: Text("Terms and conditions"),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Welcome to ATI AMS! \n\nThese terms and conditions outline the rules and regulations for the use of ATI AMS. \n\nBy accessing this App we assume you accept these terms and conditions. Do not continue to use ATI AMS if you do not agree to take all of the terms and conditions stated on this page.",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Information collected through our App',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'We collect information regarding your geolocation, mobile device, when you use our App. If you are using our App, we may also collect information about the phone network associated with your mobile device, your mobile device’s operating system or platform, the type of mobile device you use, your mobile device’s unique device ID and information about the features of our App you accessed. This information is primarily needed to maintain the security and operation of our App, for troubleshooting and for our internal analytics and reporting purposes. \n\nDo not continue to use This App if you do not agree to take all of the terms and conditions.',
            ),
            Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value;
                    });
                  },
                ),
                Text('I agree to continue'),
              ],
            ),
          ],
        ),
      ),
      actions: [
        cancelButton,
        isChecked ? continueButton : Container(),
      ],
    );
  }
}
