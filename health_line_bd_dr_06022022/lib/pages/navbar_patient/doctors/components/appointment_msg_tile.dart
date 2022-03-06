import 'package:flutter/material.dart';
import 'package:health_line_bd/config/common_const.dart';

class AppointmentMsgTile extends StatelessWidget {
  final String appointmentMsg;

  const AppointmentMsgTile({
    Key key,
    @required this.appointmentMsg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: cViolet),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Center(
          child: Text(
            appointmentMsg,
            style: TextStyle(
              color: Colors.red,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
