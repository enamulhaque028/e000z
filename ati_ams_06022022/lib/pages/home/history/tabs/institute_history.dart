import 'dart:developer';

import 'package:ati_ams/model/history/institute-history_model.dart';
import 'package:ati_ams/pages/home/history/view/history_view.dart';
import 'package:ati_ams/services/history_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class InstituteHistory extends StatefulWidget {
  const InstituteHistory({Key key}) : super(key: key);

  @override
  _InstituteHistoryState createState() => _InstituteHistoryState();
}

class _InstituteHistoryState extends State<InstituteHistory> {
  var currentDate = DateTime.now();
  String startDate = DateFormat('dd/MM/yyyy').format(DateTime.now()).toString();
  String endDate = DateFormat('dd/MM/yyyy').format(DateTime.now()).toString();
  bool _expanded = false;
  String selectionText = 'Select date range to see history';
  bool isDateSelected = false;
  bool isLoading = false;
  InstituteHistoryModel instituteHistoryData = new InstituteHistoryModel();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          color: Colors.green,
          child: ExpansionPanelList(
            animationDuration: Duration(milliseconds: 1500),
            children: [
              ExpansionPanel(
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    title: Text(
                      selectionText,
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                },
                body: SfDateRangePicker(
                  selectionMode: DateRangePickerSelectionMode.range,
                  view: DateRangePickerView.month,
                  // minDate: minDate,
                  maxDate: currentDate,
                  showActionButtons: true,
                  onCancel: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'Selection Cancelled',
                      ),
                      duration: Duration(milliseconds: 500),
                    ));
                  },
                  onSelectionChanged:
                      (DateRangePickerSelectionChangedArgs args) {
                    setState(() {
                      startDate = DateFormat('dd-MM-yyyy')
                          .format(args.value.startDate)
                          .toString();
                      endDate = DateFormat('dd-MM-yyyy')
                          .format(args.value.endDate ?? args.value.startDate)
                          .toString();
                    });
                  },
                  onSubmit: (value) {
                    setState(() {
                      _expanded = false;
                      selectionText = '$startDate to $endDate';
                      isDateSelected = true;
                      isLoading = true;
                    });
                    print(value);
                    log('Start Date: $startDate, End Date: $endDate');
                    HistoryService()
                        .fetchHistoryData(
                      attendanceType: "I",
                      startDate: startDate,
                      endDate: endDate,
                    )
                        .then((value) {
                      setState(() {
                        instituteHistoryData = value;
                        isLoading = false;
                      });
                    });
                  },
                ),
                isExpanded: _expanded,
                canTapOnHeader: true,
              ),
            ],
            dividerColor: Colors.grey,
            expansionCallback: (panelIndex, isExpanded) {
              _expanded = !_expanded;
              setState(() {});
            },
          ),
        ),
        Expanded(
          child: !isDateSelected
              ? Center(
                  child: Text('No date has been selected!'),
                )
              : isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.only(top: 8.0),
                      itemCount: instituteHistoryData.data.length,
                      itemBuilder: (context, index) {
                        var instituteHistoryInfo =
                            instituteHistoryData.data[index];
                        String classStartDate = DateFormat('dd-MM-yyyy')
                            .format(instituteHistoryInfo.date)
                            .toString();
                        String institute = instituteHistoryInfo.inistitute
                                    .toString() ==
                                '1'
                            ? 'BIRDEM 1'
                            : instituteHistoryInfo.inistitute.toString() == '2'
                                ? 'BIRDEM 2'
                                : 'institute not found!';
                        bool hasGivenAttendance =
                            instituteHistoryInfo.attendanceStatus.toString() ==
                                    '1'
                                ? true
                                : false;
                        return HistoryView(
                          hasGivenAttendance: hasGivenAttendance,
                          info1: institute,
                          info2: instituteHistoryInfo.deptName.toString(),
                          info3: classStartDate,
                          info4:
                              '${instituteHistoryInfo.submissionTime.toString()} (In time)',
                          info5:
                              '${instituteHistoryInfo.submissionEndTime.toString()}',
                        );
                      },
                    ),
        ),
      ],
    );
  }
}
