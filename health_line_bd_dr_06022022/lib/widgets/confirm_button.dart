import 'dart:developer';
import 'package:health_line_bd/config/common_const.dart';
import 'package:flutter/material.dart';

class ConfirmButton extends StatefulWidget {
  final Function onTap;
  final String phoneNumber;
  ConfirmButton({@required this.onTap, @required this.phoneNumber});
  @override
  _ConfirmButtonState createState() => _ConfirmButtonState();
}

class _ConfirmButtonState extends State<ConfirmButton>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        String patttern =
            r'^(?:\+?88)?01[3-9]\d{8}$'; //validation all BD Mobile Operator
        RegExp regExp = new RegExp(patttern);
        regExp.hasMatch(widget.phoneNumber)
            // widget.phoneNumber != ''
            ? controller.forward()
            : ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Please Enter Valid Phone Number!'),
                ),
              );
      },
      onTapUp: (_) {
        if (controller.status == AnimationStatus.forward) {
          controller.reverse();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  height: 170,
                  width: 170,
                  child: CircularProgressIndicator(
                    strokeWidth: 6,
                    value: 1.0,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[400]),
                  ),
                ),
                Container(
                  height: 170,
                  width: 170,
                  child: CircularProgressIndicator(
                    strokeWidth: 6,
                    value: controller.value,
                    valueColor: controller.value == 1.0
                        ? AlwaysStoppedAnimation<Color>(Colors.green)
                        : AlwaysStoppedAnimation<Color>(
                            Color(PrimaryColor).withOpacity(0.7)),
                  ),
                ),
                //Icon(Icons.add)
                controller.value == 1.0
                    ? CircleAvatar(
                        radius: 70,
                        backgroundImage:
                            AssetImage('assets/images/received.jpg'),
                      )
                    :
                    // Image.asset(
                    //     'assets/images/send.jpg',
                    //     // fit: BoxFit.cover,
                    //     height: 150,
                    //     width: 150,
                    //   ),
                    CircleAvatar(
                        radius: 70,
                        backgroundImage: AssetImage('assets/images/send.jpg'),
                      ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              controller.value == 1.0
                  ? 'OTP sent'
                  : 'Tap and hold to varify OTP',
              style: TextStyle(
                fontSize: 22,
                // fontWeight: FontWeight.bold,
                color: controller.value == 1.0 ? Colors.green : Colors.black,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        controller.value == 1.0
            ? () {
                log('OTP sent');
                //Navigator.pop(context);
                widget.onTap();
              }()
            : log('OTP not sent');
      },
    );
  }
}
