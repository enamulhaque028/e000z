import 'package:ati_ams/config/common_const.dart';
import 'package:flutter/material.dart';
import '../../../../widgets/item_view.dart';

class ActivityTile extends StatelessWidget {
  final String topicName;
  final String activityName;
  final String authorizedBy;
  final String departmentName;
  final String date;
  final String duration;
  final String comment;
  final bool hasGivenAttendance;

  ActivityTile({
    @required this.topicName,
    @required this.activityName,
    @required this.authorizedBy,
    @required this.departmentName,
    @required this.date,
    @required this.duration,
    @required this.comment,
    @required this.hasGivenAttendance,
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
        child: Container(
          padding: EdgeInsets.only(
            left: 16.0,
            top: 8.0,
            bottom: 8.0,
          ),
          width: MediaQuery.of(context).size.width - 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      topicName,
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
                      title: activityName,
                      icon: Icons.topic,
                      iconColor: Colors.purple,
                    ),
                    ItemView(
                      title: 'Authorized by ${authorizedBy.toUpperCase()}',
                      icon: Icons.person,
                      iconColor: Colors.blue,
                    ),
                    ItemView(
                      title: departmentName,
                      icon: Icons.subject,
                      iconColor: Colors.red,
                    ),
                    ItemView(
                      title: date,
                      icon: Icons.calendar_today,
                      iconColor: Colors.green,
                    ),
                    // SelectAuthorizedBy(),
                    ItemView(
                      title: duration,
                      icon: Icons.timelapse,
                      iconColor: cViolet,
                    ),
                    comment == 'null'
                        ? Container()
                        : ItemView(
                            title: comment,
                            icon: Icons.comment,
                            iconColor: cViolet,
                          ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: hasGivenAttendance
                    ? Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                      )
                    : Icon(
                        Icons.pending,
                        color: Colors.red,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
