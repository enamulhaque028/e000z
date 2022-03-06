import 'package:flutter/material.dart';

class TextTile extends StatelessWidget {
  final String title;
  final Color color;
  const TextTile({
    Key key,
    @required this.title,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            '$title',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class ScheduleTile extends StatelessWidget {
  final String dayNo;
  final String schedule;
  final Color color;
  const ScheduleTile({
    Key key,
    @required this.dayNo,
    @required this.schedule,
    @required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String getConsultationDay() {
      String consultationDay = '';
      if (dayNo == '1') {
        consultationDay = 'Sun';
      } else if (dayNo == '2') {
        consultationDay = 'Mon';
      } else if (dayNo == '3') {
        consultationDay = 'Tue';
      } else if (dayNo == '4') {
        consultationDay = 'Wed';
      } else if (dayNo == '5') {
        consultationDay = 'Thu';
      } else if (dayNo == '6') {
        consultationDay = 'Fri';
      } else if (dayNo == '7') {
        consultationDay = 'Sat';
      }
      return consultationDay;
    }

    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 16),
      child: Container(
        // height: 100,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                getConsultationDay(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$schedule',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
