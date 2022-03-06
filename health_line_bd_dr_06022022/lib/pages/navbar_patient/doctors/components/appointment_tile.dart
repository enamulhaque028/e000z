import 'package:flutter/material.dart';
import 'package:health_line_bd/config/common_const.dart';
import 'package:health_line_bd/model/chamber_model.dart';
import 'package:health_line_bd/widgets/custom_dialog.dart';
import 'package:intl/intl.dart';
import 'booking_tile.dart';

class AppointmentTile extends StatefulWidget {
  final DoctorChamberModel chamberData;
  final String imageUrl;
  const AppointmentTile({
    Key key,
    @required this.chamberData,
    @required this.imageUrl,
  }) : super(key: key);

  @override
  _AppointmentTileState createState() => _AppointmentTileState();
}

class _AppointmentTileState extends State<AppointmentTile> {
  String schedule = 'select schedule';
  List<int> sanitizeDate(DoctorChamberModel chamberData) {
    List<int> dayValue = [];
    List<int> dayIndex = [];
    dayValue.add(chamberData.objResponse.sun);
    dayValue.add(chamberData.objResponse.mon);
    dayValue.add(chamberData.objResponse.tue);
    dayValue.add(chamberData.objResponse.wed);
    dayValue.add(chamberData.objResponse.thu);
    dayValue.add(chamberData.objResponse.fri);
    dayValue.add(chamberData.objResponse.sat);
    print(dayValue.map((e) => e));
    // var val = dayValue.indexWhere((element) => element == 0);
    for (int i = 0; i < dayValue.length; i++) {
      if (dayValue[i] == 0) {
        int cIndx = i == 0 ? 7 : i;
        dayIndex.add(cIndx);
      }
    }
    print(dayIndex);
    return dayIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Appointment Date',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.calendar_today,
                  // color: cViolet,
                ),
                onPressed: () {
                  List<int> filteredList = sanitizeDate(widget.chamberData);
                  showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2025, 12),
                      selectableDayPredicate: (DateTime val) {
                        for (int i = 0; i < filteredList.length; i++) {
                          if (val.weekday == filteredList[i]) return false;
                        }
                        return true;
                      }).then((pickedDate) {
                    String formattedDate =
                        DateFormat('dd-MM-yyyy').format(pickedDate).toString();
                    setState(() {
                      schedule = formattedDate.toString();
                    });
                  });
                },
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 16.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: cViolet),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      schedule,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: schedule == "select schedule"
                            ? Colors.red
                            : Colors.green,
                      ),
                    ),
                    SizedBox(height: 10),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: widget
                            .chamberData.objResponse.drConsultFeeList.length,
                        itemBuilder: (context, index) {
                          var bookingInfo = widget
                              .chamberData.objResponse.drConsultFeeList[index];
                          return BookingTile(
                            consultType: bookingInfo.consultType.toString(),
                            consultFee: bookingInfo.consultFee.toString(),
                            onTapBtn: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomDialogBox(
                                      imageUrl: widget.imageUrl,
                                      title: "Custom Dialog Demo",
                                      descriptions:
                                          "Hii all this is a custom dialog in flutter and  you will be use in your flutter applications",
                                      text: "Yes",
                                    );
                                  });
                            },
                          );
                        }),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
