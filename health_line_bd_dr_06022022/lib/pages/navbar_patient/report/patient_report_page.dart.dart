import 'package:age/age.dart';
import 'package:flutter/material.dart';
import 'package:health_line_bd/config/common_const.dart';
import 'package:health_line_bd/model/lis/report_model.dart';
import 'package:health_line_bd/services/lis/report_service.dart';
import 'package:health_line_bd/widgets/timeline_widget.dart';
import 'components/patient_view.dart';
import 'dart:ui';
import 'report_view_page.dart';

class PatientReportPage extends StatefulWidget {
  @override
  PatientReportPageState createState() => PatientReportPageState();
}

class PatientReportPageState extends State<PatientReportPage> {
  Report patientInfo = new Report();
  var isLoading = true;
  @override
  void initState() {
    PatientService().fetchPatientInfo().then((data) {
      setState(() {
        patientInfo = data;
        isLoading = false;
      });
    });
    super.initState();
  }

  String calculateAge(String dateOfBirth) {
    DateTime birthday = DateTime.parse(dateOfBirth.split('/').reversed.join());
    DateTime today = DateTime.now(); //2020/1/24

    AgeDuration age;

    // Find out your age
    age = Age.dateDifference(
        fromDate: birthday, toDate: today, includeToDate: false);

    return age.years.toString();
  }

  @override
  Widget build(BuildContext context) {
    var data = patientInfo.pReturnmsg0;
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text('Report'),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(cViolet),
              ),
            )
          : patientInfo.pReturnmsg0.isEmpty
              ? Center(
                  child: Text('No data found!'),
                )
              : Column(
                  children: [
                    SizedBox(height: 10),
                    Container(
                      height: 50,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 13.5,
                          ),
                          CustomTimeLine(
                            height: 14,
                            lineColor: cViolet,
                            circleColor: cViolet,
                            enableImage: true,
                            isImageFromApi: data[0].photoLoca.toString() == ''
                                ? false
                                : true,
                            imageUrl: data[0].photoLoca.toString() == ''
                                ? data[0].gender.toString().toLowerCase() ==
                                        'male'
                                    ? 'assets/images/male.png'
                                    : 'assets/images/female.png'
                                : data[0].photoLoca.toString(),
                          ),
                          SizedBox(
                            width: 18.0,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 68,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[0].patientNm.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: cViolet,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '${data[0].patientNo.toString()} / ${calculateAge(data[0].dtofBirth.toString())} yrs',
                                  style: TextStyle(
                                      color: cViolet,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ReportViewPage(
                                      indexNo: index,
                                      patientInfo: patientInfo,
                                      patientName: data[0].patientNm.toString(),
                                      patientNo: data[0].patientNo.toString(),
                                      gender: data[0]
                                          .gender
                                          .toString()
                                          .toLowerCase(),
                                      imageUrl: data[0].photoLoca.toString(),
                                    ),
                                  ),
                                );
                              },
                              child: PatientView(
                                patientName: data[index].patientNm.toString(),
                                reqNo: data[index].voucherId.toString(),
                                // gender: data[index].gender.toString(),
                                visitDate: data[index].voucherDt.toString(),
                                totalReport: data[index].totalReport.toString(),
                                referredBy: data[index].refBy.toString(),
                                pendingReport:
                                    data[index].pendingReport.toString(),
                                collectedSample:
                                    data[index].collectedSample.toString(),
                                totalInstruction:
                                    data[index].totalInstruction.toString(),
                                totalSample: data[index].totalSample.toString(),
                                consultationNo:
                                    data[index].consultNo.toString(),
                                admissionNo: data[index].admsionNo.toString(),
                                index: index,
                                listLength: data.length,
                              ),
                            );
                          }),
                    ),
                  ],
                ),
    );
  }
}
