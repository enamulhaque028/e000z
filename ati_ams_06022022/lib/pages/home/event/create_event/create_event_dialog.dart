import 'dart:developer';
import 'package:ati_ams/config/common_const.dart';
import 'package:ati_ams/model/create_event_dropdown_model.dart';
import 'package:ati_ams/pages/home/event/create_event/drop_down/activity_dropdown.dart';
import 'package:ati_ams/pages/home/event/create_event/drop_down/topic_dropdown.dart';
import 'package:ati_ams/pages/home/profile/edit/widgets/text_field.dart';
import 'package:ati_ams/services/check_activity.dart';
import 'package:ati_ams/services/create_activity_service.dart';
import 'package:ati_ams/services/create_event_dropdown_service.dart';
import 'package:ati_ams/widgets/custom_progress.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'drop_down/authorizer_dropdown.dart';

class CreateEventDialog extends StatefulWidget {
  final VoidCallback refreshData;

  const CreateEventDialog({
    Key key,
    @required this.refreshData,
  }) : super(key: key);
  @override
  _CreateEventDialogState createState() => _CreateEventDialogState();
}

class _CreateEventDialogState extends State<CreateEventDialog> {
  // TextEditingController commentController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();
  TextEditingController startTimeController = new TextEditingController();
  TextEditingController endTimeController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _autoValidate = false;
  bool isApiCallProcess = false;

  CreateEventDropdownModel dropdownDataAll = CreateEventDropdownModel();
  bool isLoading = true;

  @override
  void initState() {
    CreateEventDropdownService().fetchDropdownData().then((value) {
      setState(() {
        dropdownDataAll = value;
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      inAsyncCall: isApiCallProcess,
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : AlertDialog(
              // title: new Text('Warning'),
              content: Form(
                key: _formKey,
                // ignore: deprecated_member_use
                autovalidate: _autoValidate,
                child: SingleChildScrollView(
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          Text(
                            'Create Event',
                            style: TextStyle(
                              color: cViolet,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.cancel,
                              size: 26,
                              color: cViolet,
                            ),
                          ),
                        ],
                      ),
                      dropdownDataAll.data.topic.isEmpty
                          ? Container()
                          : TopicDropdown(
                              topic: dropdownDataAll.data.topic,
                            ),
                      dropdownDataAll.data.activityInfo.isEmpty
                          ? Container()
                          : ActivityDropdown(
                              authorizer: dropdownDataAll.data.activityInfo),
                      dropdownDataAll.data.teacherList.isEmpty
                          ? Container()
                          : AuthorizerDropdown(
                              authorizer: dropdownDataAll.data.teacherList,
                            ),
                      CustomtextField(
                        nameController: dateController,
                        labeltext: 'Enter Date',
                        icon: Icons.calendar_today,
                        readOnly: true,
                        onTapCalendar: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2025, 12),
                          ).then((pickedDate) {
                            String formattedDate = DateFormat('dd-MM-yyyy')
                                .format(pickedDate)
                                .toString();
                            dateController.text = formattedDate.toString();
                          });
                        },
                      ),
                      CustomtextField(
                        nameController: startTimeController,
                        labeltext: 'Duration From',
                        icon: Icons.timelapse,
                        readOnly: true,
                        onTapCalendar: () async {
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          ).then((pickedTime) {
                            startTimeController.text =
                                pickedTime.format(context);
                          });
                        },
                      ),
                      CustomtextField(
                        nameController: endTimeController,
                        labeltext: 'Duration To',
                        icon: Icons.timelapse,
                        readOnly: true,
                        onTapCalendar: () async {
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          ).then((pickedTime) {
                            endTimeController.text = pickedTime.format(context);
                          });
                        },
                      ),
                      // CustomtextField(
                      //   nameController: commentController,
                      //   labeltext: 'Comments',
                      //   icon: Icons.comment,
                      //   onTapCalendar: () {},
                      // ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                IconButton(
                    icon: Icon(
                      Icons.send,
                      size: 28,
                      color: cViolet,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        // log(commentController.text);
                        log(dateController.text);
                        log(startTimeController.text);
                        log(endTimeController.text);
                        setState(() {
                          isApiCallProcess = true;
                        });
                        CheckActivity()
                            .checkStudentActivity(
                                activityId: ActivityDropdown.selectedvalue,
                                activityDate: dateController.text)
                            .then((value) {
                          if (value['data']['activity_atten_status'] > 0) {
                            setState(() {
                              isApiCallProcess = false;
                            });
                            CoolAlert.show(
                                context: context,
                                // width: 350,
                                type: CoolAlertType.warning,
                                text:
                                    'This Activity has already been created today!');
                          } else {
                            CreateEventService()
                                .createEvent(
                                    activityId: ActivityDropdown.selectedvalue,
                                    topicId: TopicDropdown.selectedvalue,
                                    authorizerId:
                                        AuthorizerDropdown.selectedvalue,
                                    date: dateController.text,
                                    startTime: startTimeController.text,
                                    endTime: endTimeController.text)
                                .then((value) {
                              if (value['success'].toString() == 'true') {
                                setState(() {
                                  isApiCallProcess = false;
                                });
                                // Phoenix.rebirth(context);
                                Navigator.of(context).pop();
                                CoolAlert.show(
                                  context: context,
                                  // width: 350,
                                  type: CoolAlertType.success,
                                  text: "Create event successful!",
                                  // onConfirmBtnTap: () async {
                                  //   // Navigator.of(context).pop();
                                  //   // Navigator.pushAndRemoveUntil(
                                  //   //   context,
                                  //   //   MaterialPageRoute(
                                  //   //       builder: (BuildContext ctx) => HomePage()),
                                  //   //   (Route<dynamic> route) => false,
                                  //   // );
                                  // },
                                );
                                widget.refreshData();
                              } else {
                                setState(() {
                                  isApiCallProcess = false;
                                });
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      'Event creation failed! Please try again'),
                                ));
                              }
                            });
                          }
                        });
                        _formKey.currentState.save();
                      } else {
                        setState(() {
                          _autoValidate = true;
                        });
                      }
                    })
              ],
            ),
    );
  }
}
