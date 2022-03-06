import 'package:dil_app/config/common_const.dart';
import 'package:dil_app/model/client_info_model.dart';
import 'package:dil_app/pages/chart/chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class CustomDialogue extends StatelessWidget {
  final List<ClientInfo> displayClients;
  final int index;
  CustomDialogue({this.displayClients, this.index});

  @override
  Widget build(BuildContext context) {
    String ticketTitle = displayClients[index].cSTTITLES.toString();
    String ticketTitleVal =
        ticketTitle == "Title" ? "No title found!" : ticketTitle;
    String attachment = displayClients[index].tICKETATTACHMENT.toString();
    List<String> images = attachment == '' ? [] : attachment.split(",");
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 10,
      child: Container(
        padding: EdgeInsets.only(
          left: 8,
          right: 8,
          bottom: 8,
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView(
            children: <Widget>[
              Container(
                //padding: EdgeInsets.only(left: 10.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Text(
                          'Details',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(PrimaryColor),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Ticket No         : ',
                          style: TextStyle(
                            color: Color(PrimaryColor),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  '${displayClients[index].tICKETUDID.toString()}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Requested By  : ',
                          style: TextStyle(
                            color: Color(PrimaryColor),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '${ChartPage.userName.toString()}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),

                      RichText(
                        text: TextSpan(
                          text: 'Client Name     : ',
                          style: TextStyle(
                            color: Color(PrimaryColor),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  '${displayClients[index].cLINTNAME.toString()}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Project Name  : ',
                          style: TextStyle(
                            color: Color(PrimaryColor),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  '${displayClients[index].pROJTNAME.toString()}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Request Mode : ',
                          style: TextStyle(
                            color: Color(PrimaryColor),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  '${displayClients[index].tREQMODE.toString()}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 5,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Title                   : ',
                          style: TextStyle(
                            color: Color(PrimaryColor),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '${ticketTitleVal.toString()}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Description       : ',
                        style: TextStyle(
                          color: Color(PrimaryColor),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      // RichText(
                      //   text: TextSpan(
                      //     text: 'Description: ',
                      //     style: TextStyle(
                      //       color: Color(PrimaryColor),
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 15,
                      //     ),
                      //     children: <TextSpan>[
                      //       TextSpan(
                      //         text:
                      //             '${displayClients[index].tICKETDESC.toString()}',
                      //         style: TextStyle(
                      //           color: Colors.black,
                      //           fontWeight: FontWeight.w400,
                      //           fontSize: 14,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Html(
                        data: '${displayClients[index].tICKETDESC.toString()}',
                        defaultTextStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Attatchment     : ',
                        style: TextStyle(
                          color: Color(PrimaryColor),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 8),
                      images.isEmpty ? Container(child: Text('No Attachment found!')) : GridView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.6,
                          ),
                          itemCount: images.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              child: Center(
                                child: Image.network('$baseImageUrl${images[index]}',
                      ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: new Text("Ok"),
            backgroundColor: Color(PrimaryColor),
          ),
        ),
      ),
    );
  }
}
