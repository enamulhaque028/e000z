import 'dart:developer';
import 'package:ati_ams/model/history/class_history_model.dart';
import 'package:ati_ams/pages/home/history/view/history_view.dart';
import 'package:ati_ams/services/history_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ClassHistory extends StatefulWidget {
  const ClassHistory({Key key}) : super(key: key);

  @override
  _ClassHistoryState createState() => _ClassHistoryState();
}

class _ClassHistoryState extends State<ClassHistory> {
  var currentDate = DateTime.now();
  String startDate = DateFormat('dd/MM/yyyy').format(DateTime.now()).toString();
  String endDate = DateFormat('dd/MM/yyyy').format(DateTime.now()).toString();
  bool _expanded = false;
  String selectionText = 'Select date range to see history';
  bool isDateSelected = false;
  bool isLoading = false;
  ClassHistoryModel classHistoryData = new ClassHistoryModel();
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
                      attendanceType: "C",
                      startDate: startDate,
                      endDate: endDate,
                    )
                        .then((value) {
                      setState(() {
                        classHistoryData = value;
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
                  : classHistoryData.data.isEmpty
                      ? Center(
                          child: Text('No history found!'),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.only(top: 8.0),
                          itemCount: classHistoryData.data.length,
                          itemBuilder: (context, index) {
                            var classHistoryInfo = classHistoryData.data[index];
                            String classStartDate = DateFormat('dd-MM-yyyy')
                                .format(classHistoryInfo.classStartDate)
                                .toString();
                            String classStartTime = DateFormat.jm()
                                .format(classHistoryInfo.classStartTime)
                                .toString();
                            String classEndTime = DateFormat.jm()
                                .format(classHistoryInfo.classEndTime)
                                .toString();
                            bool hasGivenAttendance =
                                classHistoryInfo.attendanceStatus.toString() ==
                                        '1'
                                    ? true
                                    : false;
                            return HistoryView(
                              hasGivenAttendance: hasGivenAttendance,
                              info1: classHistoryInfo.courseName.toString(),
                              info2: classHistoryInfo.topicName.toString(),
                              info3: classStartDate,
                              info4: '$classStartTime - $classEndTime',
                              info5: '',
                            );
                          },
                        ),
        ),
      ],
    );
  }
}
