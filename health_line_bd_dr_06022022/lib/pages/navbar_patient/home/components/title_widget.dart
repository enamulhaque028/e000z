import 'package:flutter/material.dart';
// import 'package:health_line_bd/config/common_const.dart';

//Homepage Title Widget
class TitleWidget extends StatelessWidget {
  final String title;
  const TitleWidget({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        // color: Color(0xFFe0dcfa),
        padding: const EdgeInsets.only(left: 12.0, top: 4, bottom: 8.0),
        child: Text(
          title,
          style: TextStyle(
            // color: Colors.black54,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

//Prescription Body Item Title Widget
class PresBodyItemTitle extends StatelessWidget {
  final String itemTitle;
  const PresBodyItemTitle({
    Key key,
    @required this.itemTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Color(0xFFf7fcff),
        child: Text(
          '$itemTitle',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Colors.teal[500],
          ),
        ),
      ),
    );
  }
}

//Prescription Body Item Description Widget left side
class PresBodyItemDesc extends StatelessWidget {
  final String itemDesc;
  const PresBodyItemDesc({
    Key key,
    @required this.itemDesc,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      child: Card(
        elevation: 0.5,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 2,
            horizontal: 3,
          ),
          child: Text(
            '$itemDesc',
            style: TextStyle(
              color: Colors.black45,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

//prescription body Medicine description

class MedicineDesWidget extends StatelessWidget {
  final String medicineName;
  final String medication;

  const MedicineDesWidget(
      {Key key, @required this.medicineName, @required this.medication})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Card(
        elevation: 0.5,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 2,
            horizontal: 3,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$medicineName',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.60),
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              Text(
                '$medication',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Refer to a doctor view

class ReferDoctorTile extends StatelessWidget {
  final String refereeName,
      designation,
      degree,
      bmdcNo,
      bdhlNo,
      refChamber,
      note;
  const ReferDoctorTile({
    Key key,
    @required this.refereeName,
    @required this.designation,
    @required this.degree,
    @required this.bmdcNo,
    @required this.bdhlNo,
    @required this.refChamber,
    @required this.note,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$refereeName',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: Colors.grey,
          ),
        ),
        Text(
          '$designation',
          style: TextStyle(
            fontSize: 14,
            // fontWeight: FontWeight.w800,
            color: Colors.grey,
          ),
        ),
        Text(
          '$degree',
          style: TextStyle(
            fontSize: 14,
            // fontWeight: FontWeight.w800,
            color: Colors.grey,
          ),
        ),
        Text(
          '$bmdcNo',
          style: TextStyle(
            fontSize: 14,
            // fontWeight: FontWeight.w800,
            color: Colors.grey,
          ),
        ),
        Text(
          '$bdhlNo',
          style: TextStyle(
            fontSize: 14,
            // fontWeight: FontWeight.w800,
            color: Colors.grey,
          ),
        ),
        Text(
          '$refChamber',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: Colors.grey,
          ),
        ),
        Text(
          '$note',
          style: TextStyle(
            fontSize: 14,
            color: Colors.red,
          ),
        ),
        SizedBox(height: 5)
      ],
    );
  }
}
