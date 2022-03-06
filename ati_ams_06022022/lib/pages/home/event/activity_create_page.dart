import 'package:ati_ams/config/common_const.dart';
import 'package:ati_ams/model/activity_model.dart';
import 'package:ati_ams/pages/home/event/create_event/create_event_dialog.dart';
import 'package:ati_ams/services/activity_service.dart';
import 'package:ati_ams/services/check_class_attendance_service.dart';
import 'package:ati_ams/widgets/custom_progress.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'view/activity_tile.dart';

class ActivityCreatePage extends StatefulWidget {
  const ActivityCreatePage({Key key}) : super(key: key);

  @override
  _ActivityCreatePageState createState() => _ActivityCreatePageState();
}

class _ActivityCreatePageState extends State<ActivityCreatePage> {
  var isLoading = true;
  bool isApiCallProcess = false;
  ActivityModel activityData = new ActivityModel();

  @override
  void initState() {
    ActivityService().fetchActivityData().then((data) {
      setState(() {
        activityData = data;
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeaf4ff),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : activityData.data.isEmpty
              ? Center(
                  child: Text('No activity found!'),
                )
              : ProgressHUD(
                  inAsyncCall: isApiCallProcess,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    shrinkWrap: true,
                    itemCount: activityData.data.length,
                    itemBuilder: (context, index) {
                      var activityInfo = activityData.data[index];
                      String eventStartDate = DateFormat('dd-MM-yyyy')
                          .format(activityInfo.date)
                          .toString();
                      return ActivityTile(
                        topicName: activityInfo.topicName.toString(),
                        activityName: activityInfo.activityName.toString(),
                        authorizedBy: activityInfo.activityAuthorize.toString(),
                        departmentName: activityInfo.deptName.toString(),
                        date: eventStartDate,
                        duration:
                            '${activityInfo.durationStartTime.toString()} - ${activityInfo.durationEndTime.toString()}',
                        comment: activityInfo.feedbackComments.toString(),
                        hasGivenAttendance:
                            activityInfo.attendanceStatus.toString() == '1'
                                ? true
                                : false,
                      );
                    },
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            isApiCallProcess = true;
          });
          CheckClassAttendanceService().checkBlock().then((value) {
            if (value['data']['block_status'].toString() == '0') {
              setState(() {
                isApiCallProcess = false;
              });
              CoolAlert.show(
                  context: context,
                  // width: 350,
                  type: CoolAlertType.warning,
                  text: 'You are not in block!');
            } else {
              setState(() {
                isApiCallProcess = false;
              });
              showDialog(
                context: context,
                builder: (BuildContext context) => CreateEventDialog(
                  refreshData: () {
                    isLoading = true;
                    ActivityService().fetchActivityData().then((data) {
                      setState(() {
                        activityData = data;
                        isLoading = false;
                      });
                    });
                  },
                ),
              );
            }
          });
        },
        backgroundColor: cViolet,
        child: Icon(Icons.add),
      ),
    );
  }
}
