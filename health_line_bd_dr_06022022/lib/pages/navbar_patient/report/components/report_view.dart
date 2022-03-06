import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_line_bd/config/common_const.dart';

import 'pdf_viewer/pdf_viewer.dart';

class ReportView extends StatefulWidget {
  final String date;
  final String reportTitle;
  final String id;
  final String status;
  final String pdfLink;
  final String department;
  final String deliveryDate;
  final String reportNumber;
  final String instruction;
  final String sampleDate;
  final String reqId;
  final String testNo;

  ReportView({
    @required this.date,
    @required this.reportTitle,
    @required this.id,
    @required this.status,
    @required this.pdfLink,
    @required this.department,
    @required this.deliveryDate,
    @required this.reportNumber,
    @required this.instruction,
    @required this.sampleDate,
    @required this.reqId,
    @required this.testNo,
  });

  @override
  _ReportViewState createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var textColor = Colors.black;
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 2),
          // height: 150,
          width: width,
          child: Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              padding: EdgeInsets.only(top: 16, left: 16, right: 10),
              decoration: BoxDecoration(
                // color: cSky,
                borderRadius: BorderRadius.circular(15.0),
                gradient: LinearGradient(
                  colors: <Color>[
                    Colors.white,
                    Colors.white38,
                    Colors.primaries[Random().nextInt(Colors.primaries.length)],
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.reportNumber == ''
                      ? Container()
                      : RichText(
                          text: TextSpan(
                              text: 'Report No     : ',
                              style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                              ),
                              children: [
                                TextSpan(
                                  text: widget.reportNumber,
                                  style: TextStyle(
                                      color: textColor,
                                      fontWeight: FontWeight.w300),
                                ),
                              ]),
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          widget.reportTitle,
                          style: TextStyle(
                            color: textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      (widget.status == '7' || widget.status == '8')
                          ? ButtonTheme(
                              height: 30,
                              // ignore: deprecated_member_use
                              child: RaisedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PdfReader(
                                        pdfLink: widget.pdfLink,
                                        reqId: widget.reqId,
                                        testNo: widget.testNo,
                                      ),
                                    ),
                                  );
                                },
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'View',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    Icon(
                                      FontAwesomeIcons.filePdf,
                                      color: cRed,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container()
                      // ButtonTheme(
                      //     height: 30,
                      //     // ignore: deprecated_member_use
                      //     child: RaisedButton(
                      //       onPressed: () {},
                      //       color: Colors.white54,
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(20)),
                      //       child: Text(
                      //         'Pending',
                      //         style: TextStyle(
                      //           color: Colors.white,
                      //           fontWeight: FontWeight.w300,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                    ],
                  ),
                  // SizedBox(
                  //   height: 5,
                  // ),
                  widget.department == ''
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: RichText(
                            textScaleFactor: 1.02,
                            text: TextSpan(
                                text: 'Department : ',
                                style: TextStyle(
                                  letterSpacing: 0.4,
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text: widget.department,
                                    style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ]),
                          ),
                        ),
                  widget.sampleDate == ''
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: RichText(
                            textScaleFactor: 1.02,
                            text: TextSpan(
                                text: 'Sample Date : ',
                                style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text: widget.sampleDate,
                                    style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.w300),
                                  ),
                                ]),
                          ),
                        ),
                  widget.deliveryDate == ''
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 7.0),
                          child: RichText(
                            text: TextSpan(
                                text: 'Delivery Date : ',
                                style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: [
                                  TextSpan(
                                    text: widget.deliveryDate,
                                    style: TextStyle(
                                        color: textColor,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14.5),
                                  ),
                                ]),
                          ),
                        ),
                  widget.instruction == ''
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                // padding: EdgeInsets.only(left: 5, right: 5),
                                decoration: new BoxDecoration(
                                  border: Border.symmetric(
                                    horizontal: BorderSide(
                                      width: 2,
                                      color: textColor,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  'Instruction for Patient: ',
                                  style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: Text(
                                  widget.instruction,
                                  style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 15,
          top: -14,
          child: Container(
            padding: EdgeInsets.all(10),
            height: 55,
            width: 135,
            child: Card(
              color: cYellow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  (widget.status == '7' || widget.status == '8')
                      ? widget.date
                      : 'Pending',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
