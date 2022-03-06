import 'package:flutter/material.dart';
import 'package:health_line_bd/pages/navbar_patient/home/components/prescription_body_tile.dart';
import 'package:health_line_bd/pages/navbar_patient/home/components/prescription_footer_tile.dart';
import 'package:health_line_bd/pages/navbar_patient/home/components/prescription_header_tile.dart';

class PrescriptionPage extends StatelessWidget {
  const PrescriptionPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          PrescriptionHeaderTile(
            drName: 'Dr. Mousumi Sanyal',
            gender: 'Female',
            bloodGroup: 'AB+',
            age: '12 Year, 3 Month, 8 Day',
            date: '2021-10-11',
            designation: 'MBBS, FCPS',
            speciality: 'Vascular Surgery',
            bmdcNo: 'BMDC: A 1123',
            bdhlNo: 'BDHL000041',
          ),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Divider(
                    thickness: 1.3,
                    color: Colors.black26,
                  ),
                ),
                PrescriptionBodyTile(),
              ],
            ),
          ),
          PrescriptionFooterTile(
            signatureUrl: 'assets/images/sign.png',
          )
        ],
      ),
    );
  }
}
