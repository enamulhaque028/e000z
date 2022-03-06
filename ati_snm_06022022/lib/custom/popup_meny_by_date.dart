import 'package:dil_app/api/db/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:dil_app/model/client_info_model.dart';

class PopupMenuByDate extends StatelessWidget {
  const PopupMenuByDate({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return PopupMenuButton(
      icon: Icon(Icons.settings),
      onSelected: (choiceValue) {
        // ignore: deprecated_member_use
        Widget cancelButton = FlatButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop('dialog');
          },
        );
        if (choiceValue == 1) {
          AlertDialog alert = AlertDialog(
            title: Text("Summary of today"),
            content: FutureBuilder<List<CountStatusByDate>>(
                future: DBProvider().getTicketStatusByDate('0 days'),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data.length != 0) {
                    return Container(
                      height: height * 0.3,
                      width: width * 0.6,
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          // String tStatus =
                          //     snapshot.data[index].tICKSTATUS.toString();
                          // String tStatusVal =
                          //     tStatus == "null" ? "Unnamed" : tStatus;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  '${snapshot.data[index].tICKSTATUS.toString()}'),
                              SizedBox(
                                height: 20,
                              ),
                              Text('${snapshot.data[index].count.toString()}'),
                            ],
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("Oops!");
                  }
                  return Center(child: Text('No data found!'));
                }),
            actions: [
              cancelButton,
              //continueButton,
            ],
          );
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Container(
                padding: EdgeInsets.only(
                  top: 130,
                  bottom: 130,
                ),
                child: alert,
              );
            },
          );
        } else if (choiceValue == 2) {
          AlertDialog alert = AlertDialog(
            title: Text("Summary of yesterday"),
            content: FutureBuilder<List<CountStatusByDate>>(
                future: DBProvider().getTicketStatusByDate('-1 days'),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data.length != 0) {
                    return Container(
                      height: height * 0.3,
                      width: width * 0.6,
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          // String tStatus =
                          //     snapshot.data[index].tICKSTATUS.toString();
                          // String tStatusVal =
                          //     tStatus == "null" ? "Unnamed" : tStatus;
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  '${snapshot.data[index].tICKSTATUS.toString()}'),
                              SizedBox(
                                height: 20,
                              ),
                              Text('${snapshot.data[index].count.toString()}'),
                            ],
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("Oops!");
                  }
                  return Center(child: Text('No data found!'));
                }),
            actions: [
              cancelButton,
              //continueButton,
            ],
          );
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Container(
                padding: EdgeInsets.only(
                  top: 130,
                  bottom: 130,
                ),
                child: alert,
              );
            },
          );
        } else if (choiceValue == 3) {
          AlertDialog alert = AlertDialog(
            title: Text("Summary of last 7 days"),
            content: FutureBuilder<List<CountStatusByDate>>(
                future: DBProvider().getTicketStatusByDate('-7 days'),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data.length != 0) {
                    return Container(
                      height: height * 0.3,
                      width: width * 0.6,
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  '${snapshot.data[index].tICKSTATUS.toString()}'),
                              SizedBox(
                                height: 20,
                              ),
                              Text('${snapshot.data[index].count.toString()}'),
                            ],
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("Oops!");
                  }
                  return Center(child: Text('No data found!'));
                }),
            actions: [
              cancelButton,
              //continueButton,
            ],
          );
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Container(
                padding: EdgeInsets.only(
                  top: 130,
                  bottom: 130,
                ),
                child: alert,
              );
            },
          );
        } else if (choiceValue == 4) {
          AlertDialog alert = AlertDialog(
            title: Text("Summary of last 30 days"),
            content: FutureBuilder<List<CountStatusByDate>>(
                future: DBProvider().getTicketStatusByDate('-30 days'),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data.length != 0) {
                    return Container(
                      height: height * 0.3,
                      width: width * 0.6,
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  '${snapshot.data[index].tICKSTATUS.toString()}'),
                              SizedBox(
                                height: 20,
                              ),
                              Text('${snapshot.data[index].count.toString()}'),
                            ],
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("Oops!");
                  }
                  return Center(child: Text('No data found!'));
                }),
            actions: [
              cancelButton,
              //continueButton,
            ],
          );
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Container(
                padding: EdgeInsets.only(
                  top: 130,
                  bottom: 130,
                ),
                child: alert,
              );
            },
          );
        } else if (choiceValue == 5) {
          AlertDialog alert = AlertDialog(
            title: Text(
              "Summary of last 3 months",
              style: TextStyle(fontSize: 19),
            ),
            content: FutureBuilder<List<CountStatusByDate>>(
                future: DBProvider().getTicketStatusByDate('-3 months'),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data.length != 0) {
                    return Container(
                      height: height * 0.3,
                      width: width * 0.6,
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  '${snapshot.data[index].tICKSTATUS.toString()}'),
                              SizedBox(
                                height: 20,
                              ),
                              Text('${snapshot.data[index].count.toString()}'),
                            ],
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("Oops!");
                  }
                  return Center(child: Text('No data found!'));
                }),
            actions: [
              cancelButton,
              //continueButton,
            ],
          );
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Container(
                padding: EdgeInsets.only(
                  top: 130,
                  bottom: 130,
                ),
                child: alert,
              );
            },
          );
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem(
          value: 1,
          child: Text("Today"),
        ),
        PopupMenuItem(
          value: 2,
          child: Text("Yesterday"),
        ),
        PopupMenuItem(
          value: 3,
          child: Text("Last 7 Days"),
        ),
        PopupMenuItem(
          value: 4,
          child: Text("Last 30 Days"),
        ),
        PopupMenuItem(value: 5, child: Text("Last 3 Months"))
      ],
    );
  }
}
