import 'dart:math';
import 'package:flutter/material.dart';
import 'package:health_line_bd/config/common_const.dart';
import 'package:health_line_bd/model/chamber_model.dart';
import 'package:health_line_bd/services/doctor_chamber_service.dart';
import 'components/appointment_msg_tile.dart';
import 'components/appointment_tile.dart';
import 'components/text_tile.dart';

class DoctorDetailsPage extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String speciality;
  final String degree;
  final String department;
  final String drNo;
  final String currentChember;
  const DoctorDetailsPage({
    Key key,
    @required this.imageUrl,
    @required this.name,
    @required this.speciality,
    @required this.degree,
    @required this.department,
    @required this.drNo,
    @required this.currentChember,
  }) : super(key: key);

  @override
  _DoctorDetailsPageState createState() => _DoctorDetailsPageState();
}

class _DoctorDetailsPageState extends State<DoctorDetailsPage> {
  DoctorChamberModel chamberData = new DoctorChamberModel();
  var isLoading = true;

  @override
  void initState() {
    DoctorChamberService().fetchDoctorChamber(currentChember: widget.currentChember).then((data) {
      setState(() {
        chamberData = data;
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: Container(
                    height: 280,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue, Colors.blue],
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: widget.imageUrl == 'null' ? 45.0 : 30.0),
                        widget.imageUrl == 'null'
                            ? Image.asset(
                                defaultFemaleAssetImg,
                                height: 180,
                                fit: BoxFit.cover,
                              )
                            : ClipOval(
                                child: Image.network(
                                  widget.imageUrl,
                                  height: 180,
                                  width: 180,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF53cbf0),
                      border: Border.all(color: Colors.white60),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    child: IconButton(
                      icon: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white70,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 218,
                  left: 20.0,
                  right: 20.0,
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Column(
                        children: [
                          Text(
                            widget.name,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              // color: Color(0xFF656b92),
                            ),
                          ),
                          SizedBox(height: 8),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(width: 8),
                                TextTile(
                                  title: widget.department,
                                  color: Color(0xFF34dfb5),
                                ),
                                SizedBox(width: 8),
                                TextTile(
                                  title: widget.speciality,
                                  color: Color(0xFFf55a88),
                                ),
                                SizedBox(width: 8),
                                TextTile(
                                  title: widget.degree,
                                  color: Color(0xFFfeab48),
                                ),
                                SizedBox(width: 8),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 8),
              child: isLoading
                  ? Center(
                      child: Image.asset(
                        'assets/images/loader.gif',
                        height: 100,
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, bottom: 16),
                          child: Text(
                            'Schedule',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          height: 100,
                          child: ListView.builder(
                              itemCount: chamberData.objResponse.consultTimeList.length,
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                var chamberInfo = chamberData.objResponse.consultTimeList[index];
                                return ScheduleTile(
                                  dayNo: chamberInfo.consultDayNo.toString(),
                                  schedule: '${chamberInfo.visitStart.toString()} - ${chamberInfo.visitEnd.toString()}',
                                  color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                                );
                              }),
                        ),
                        chamberData.objResponse.needApr.toString() == '0'
                            ? AppointmentTile(
                                chamberData: chamberData,
                                imageUrl: widget.imageUrl,
                              )
                            : AppointmentMsgTile(
                                appointmentMsg:'For appointment, you need an approval!',
                              ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
