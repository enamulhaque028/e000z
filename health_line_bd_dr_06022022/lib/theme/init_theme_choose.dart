import 'package:flutter/material.dart';
import 'package:health_line_bd/pages/login/decision_login_page.dart';
import 'theme_chooser_dialog.dart';

class InitThemeChoose extends StatelessWidget {
  const InitThemeChoose({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/images/color_picker.png',
                  height: 300,
                ),
                Positioned(
                  top: 135,
                  left: 110,
                  child: InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return ThemeChooserDialog();
                          });
                    },
                    child: Text(
                      'Choose your \nfavorite color',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: 100,
              height: 40,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DecisionLogin(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Next'),
                    // SizedBox(width: 5),
                    Icon(Icons.play_circle_outline),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF333333),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // <-- Radius
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
