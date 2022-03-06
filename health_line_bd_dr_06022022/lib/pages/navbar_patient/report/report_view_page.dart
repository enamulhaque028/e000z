import 'package:flutter/material.dart';
import 'package:health_line_bd/config/common_const.dart';
import 'package:health_line_bd/model/lis/report_model.dart';
import 'components/report_view.dart';

class ReportViewPage extends StatefulWidget {
  final Report patientInfo;
  final int indexNo;
  final String patientName;
  final String patientNo;
  final String gender;
  final String imageUrl;

  ReportViewPage({
    @required this.patientInfo,
    @required this.indexNo,
    @required this.patientName,
    @required this.patientNo,
    @required this.gender,
    @required this.imageUrl,
  });

  @override
  _ReportViewPageState createState() => _ReportViewPageState();
}

class _ReportViewPageState extends State<ReportViewPage> {
  List<RptDtl> report = [];
  List<RptDtl> displayReport = [];
  var isLoading = true;
  final TextEditingController _controller = TextEditingController();
  bool isSearching = false;
  @override
  void initState() {
    report = widget.patientInfo.pReturnmsg0[widget.indexNo].rptDtl;
    displayReport = report;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: displayReport.isEmpty
          ? Center(
              child: Text('No report found!'),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  padding: EdgeInsets.only(left: 13, right: 16, top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 16.0, bottom: 5.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 18,
                          backgroundImage: widget.imageUrl == ''
                              ? AssetImage(widget.gender == 'male'
                                  ? 'assets/images/male.png'
                                  : 'assets/images/female.png')
                              : NetworkImage(widget.imageUrl),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.patientName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                                color: cViolet,
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '${widget.patientInfo.pReturnmsg0[widget.indexNo].voucherId.toString()} / ${widget.patientInfo.pReturnmsg0[widget.indexNo].voucherDt.toString()}',
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text(
                      //       'Request No :',
                      //       style: TextStyle(
                      //         decoration: TextDecoration.underline,
                      //         decorationThickness: 1.8,
                      //         fontSize: 18,
                      //         fontWeight: FontWeight.bold,
                      //         color: cViolet,
                      //       ),
                      //     ),
                      //     SizedBox(height: 3),
                      //     Text(
                      //       widget.patientInfo.pReturnmsg0[widget.indexNo]
                      //           .voucherId
                      //           .toString(),
                      //       style: TextStyle(fontSize: 15),
                      //     ),
                      //   ],
                      // ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text(
                      //       'Request Date :',
                      //       style: TextStyle(
                      //         decoration: TextDecoration.underline,
                      //         decorationThickness: 1.8,
                      //         fontSize: 18,
                      //         fontWeight: FontWeight.bold,
                      //         color: cViolet,
                      //       ),
                      //     ),
                      //     SizedBox(height: 3),
                      //     Text(
                      //       widget.patientInfo.pReturnmsg0[widget.indexNo]
                      //           .voucherDt
                      //           .toString(),
                      //       style: TextStyle(fontSize: 15),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ListView.builder(
                        itemCount: displayReport.length,
                        itemBuilder: (context, index) {
                          return ReportView(
                            date: displayReport[index].reptDate.toString(),
                            reportTitle:
                                displayReport[index].reportTitle.toString(),
                            id: displayReport[index].testNo.toString(),
                            status: displayReport[index].status.toString(),
                            pdfLink: displayReport[index].reptLink.toString(),
                            department:
                                displayReport[index].department.toString(),
                            deliveryDate:
                                displayReport[index].reptDate.toString(),
                            reportNumber:
                                displayReport[index].reportNo.toString(),
                            instruction:
                                displayReport[index].instruction.toString(),
                            sampleDate:
                                displayReport[index].sampleDate.toString(),
                            reqId: widget.patientInfo
                                .pReturnmsg0[widget.indexNo].invReqId
                                .toString(),
                            testNo: displayReport[index].testNo.toString(),
                          );
                        }),
                  ),
                ),
              ],
            ),
    );
  }

  buildAppBar() {
    return AppBar(
      brightness: Brightness.dark,
      centerTitle: true,
      title: !isSearching
          ? Text(
              'Report Details',
              //style: TextStyle(fontSize: 19),
            )
          : TextField(
              controller: _controller,
              // onSubmitted: (value) {
              //   if (value.isNotEmpty) {
              //     _controller.clear();
              //   }
              // },
              onChanged: (text) async {
                text = text.toLowerCase();

                setState(() {
                  displayReport = report.where((value) {
                    var reportTitle = value.reportTitle.toLowerCase();
                    var testId = value.testNo.toString().toLowerCase();
                    var deliveryDate =
                        value.deliveryDate.toString().toLowerCase();
                    var department = value.department.toString().toLowerCase();
                    var reportNo = value.reportNo.toString().toLowerCase();
                    return reportTitle.contains(text) ||
                        testId.contains(text) ||
                        deliveryDate.contains(text) ||
                        department.contains(text) ||
                        reportNo.contains(text);
                  }).toList();
                });
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search Report Here",
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
      actions: <Widget>[
        Container(
          child: isSearching
              ? IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () async {
                    _controller.text = "";
                    setState(() {
                      this.isSearching = false;
                      displayReport = report;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      this.isSearching = true;
                    });
                  },
                ),
        ),
      ],
    );
  }
}
