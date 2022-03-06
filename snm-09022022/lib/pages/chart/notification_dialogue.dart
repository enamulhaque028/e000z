import 'package:dil_app/api/db/notification_provider.dart';
import 'package:dil_app/config/common_const.dart';
import 'package:dil_app/model/notification_model.dart';
import 'package:flutter/material.dart';

class NotificationDialogue extends StatefulWidget {
  @override
  _NotificationDialogueState createState() => _NotificationDialogueState();
}

class _NotificationDialogueState extends State<NotificationDialogue> {
  NotificationDBProvider dbProvider = NotificationDBProvider();
  List<NotificationData> displayNotification = [];
  var isLoading = true;

  @override
  void initState() {
    dbProvider.getNotificationData().then((data) {
      setState(() {
        displayNotification = data;
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : displayNotification.isEmpty
                    ? Center(
                        child: Image.asset('assets/images/no_records.png'),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: displayNotification.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Card(
                              elevation: 5.0,
                              child: Row(
                                children: [
                                  Container(
                                    width: width * (1 / 10),
                                    child: Icon(
                                      Icons.message,
                                      color: cViolet,
                                    ),
                                  ),
                                  Container(
                                    width: width * (9 / 10) - 104,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 5.0),
                                        Text(
                                          displayNotification[index].title,
                                          style: TextStyle(
                                            color: cViolet,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Text(
                                            displayNotification[index].body,
                                            textAlign: TextAlign.justify,
                                          ),
                                        ),
                                        SizedBox(height: 10.0),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Text(
                                                displayNotification[index].date,
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8.0),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     // Add your onPressed code here!
        //     Navigator.of(context).pop();
        //   },
        //   // label: Text('Ok'),
        //   child: new Text("Ok"),
        //   backgroundColor: Color(PrimaryColor),
        // ),
      ),
    );
  }
}
