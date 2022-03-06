import 'dart:developer';

import 'package:ati_ams/model/history/event_history_model.dart';
import 'package:ati_ams/pages/home/history/view/history_view.dart';
import 'package:ati_ams/services/history_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class EventsHistory extends StatefulWidget {
  const EventsHistory({Key key}) : super(key: key);

  @override
  _EventsHistoryState createState() => _EventsHistoryState();
}

class _EventsHistoryState extends State<EventsHistory> {
  var currentDate = DateTime.now();
  String startDate = DateFormat('dd/MM/yyyy').format(DateTime.now()).toString();
  String endDate = DateFormat('dd/MM/yyyy').format(DateTime.now()).toString();
  bool _expanded = false;
  String selectionText = 'Select date range to see history';
  bool isDateSelected = false;
  bool isLoading = false;
  EventHistoryModel eventHistoryData = new EventHistoryModel();
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
                      attendanceType: "A",
                      startDate: startDate,
                      endDate: endDate,
                    )
                        .then((value) {
                      setState(() {
                        eventHistoryData = value;
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
                  : eventHistoryData.data.isEmpty
                      ? Center(
                          child: Text('No history found!'),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.only(top: 8.0),
                          itemCount: eventHistoryData.data.length,
                          itemBuilder: (context, index) {
                            var eventHistoryInfo = eventHistoryData.data[index];
                            String eventStartDate = DateFormat('dd/MM/yyyy')
                                .format(eventHistoryInfo.start)
                                .toString();
                            String eventEndDate = DateFormat('dd/MM/yyyy')
                                .format(eventHistoryInfo.end)
                                .toString();
                            bool hasGivenAttendance =
                                eventHistoryInfo.attendanceStatus.toString() ==
                                        '1'
                                    ? true
                                    : false;
                            return HistoryView(
                              hasGivenAttendance: hasGivenAttendance,
                              info1: eventHistoryInfo.title.toString(),
                              info2:
                                  'Authorized by ${eventHistoryInfo.activityAuthorize.toString()}',
                              info3: eventHistoryInfo.deptName.toString(),
                              info4: '$eventStartDate - $eventEndDate',
                              info5: '',
                            );
                          },
                        ),
        ),
      ],
    );
  }
}
