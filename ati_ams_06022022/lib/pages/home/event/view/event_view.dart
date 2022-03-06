import 'package:ati_ams/config/common_const.dart';
import 'package:flutter/material.dart';
import '../../../../widgets/item_view.dart';

class EventTile extends StatelessWidget {
  final String name;
  final String topic;
  final String authorizedBy;
  final String activityName;
  final String address;
  final String duration;
  final String attendanceDate;
  final String attendanceTime;
  final Function onTapAttendance;

  EventTile({
    @required this.name,
    @required this.topic,
    @required this.authorizedBy,
    @required this.activityName,
    @required this.address,
    @required this.duration,
    @required this.attendanceDate,
    @required this.attendanceTime,
    @required this.onTapAttendance,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        left: 8.0,
        right: 8.0,
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          // gradient: LinearGradient(
          //   colors: <Color>[
          //     Colors.primaries[Random().nextInt(Colors.primaries.length)],
          //     // Colors.primaries[Random().nextInt(Colors.primaries.length)]
          //     //     .withOpacity(0.1),
          //     // Colors.primaries[Random().nextInt(Colors.primaries.length)],
          //     Colors.blueGrey,
          //   ],
          // ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(10, 10), // changes position of shadow
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  left: 16.0,
                  top: 8.0,
                  bottom: 8.0,
                ),
                width: MediaQuery.of(context).size.width - 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.solid,
                      ),
                    ),
                    // SizedBox(height: 8),
                    // Divider(color: cViolet),
                    ItemView(
                      title: topic,
                      icon: Icons.topic,
                      iconColor: Colors.purple,
                    ),
                    ItemView(
                      title: activityName,
                      icon: Icons.calendar_today,
                      iconColor: Colors.red,
                    ),
                    ItemView(
                      title: 'Authorized by ${authorizedBy.toUpperCase()}',
                      icon: Icons.person,
                      iconColor: Colors.blue,
                    ),
                    ItemView(
                      title: address,
                      icon: Icons.location_on,
                      iconColor: Colors.green,
                    ),
                    // SelectAuthorizedBy(),
                    ItemView(
                      title: duration,
                      icon: Icons.timelapse,
                      iconColor: cViolet,
                    ),
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(right: 8.0),
            //   child: InkWell(
            //     onTap: () {
            //       onTapAttendance();
            //     },
            //     child: Column(
            //       children: [
            //         // Text(attendanceDate),
            //         Icon(
            //           Icons.fingerprint,
            //           size: 70,
            //           color: Colors.green,
            //         ),
            //         // Text(attendanceTime),
            //       ],
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
