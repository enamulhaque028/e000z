import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cron/cron.dart';
import 'package:health_line_bd/config/fcm_utils.dart';

Future<void> fireAlarm() async {
  print(':::::::::::::::::::::Fire Alarm Fired!!!:::::::::::::::::::::');
  // String notificationTitle = await SharedPref().getTitle();
  // String notificationDescription = await SharedPref().getDescription();
  String medInstruction = '1+1+1';
  List<String> threeTimesMedSchedule = [
    '00 07 * * *',
    '00 15 * * *',
    '00 23 * * *',
  ];
  List<String> twoTimesMedSchedule = [
    '00 07 * * *',
    '00 23 * * *',
  ];
  List<String> oneTimeMedSchedule = [
    '00 07 * * *',
  ];

  List<String> medSchedule = medInstruction == '1+1+1'
      ? threeTimesMedSchedule
      : medInstruction == '1+1'
          ? twoTimesMedSchedule
          : oneTimeMedSchedule;
  final cron = Cron();

  for (int i = 0; i < medSchedule.length; i++) {
    cron.schedule(Schedule.parse(medSchedule[i]), () async {
      flutterLocalNotificationsPlugin.show(
        0,
        'Medicine remainder',
        'Don\'t forget to take your medicine now!!!',
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channel.description,
            importance: Importance.high,
            color: Colors.blue,
            playSound: true,
            icon: '@mipmap/ic_launcher',
          ),
        ),
      );
    });
  }
}
