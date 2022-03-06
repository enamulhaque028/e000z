import 'package:flutter/material.dart';
import 'title_widget.dart';

class PrescriptionBodyTile extends StatelessWidget {
  const PrescriptionBodyTile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 4.0, right: 4.0, top: 8.0),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //left container part
                SizedBox(
                  width: width * 0.35,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PresBodyItemTitle(itemTitle: 'Chief Complaint:'),
                          //use for loop if lisview.builder is not working
                          // for (int i = 0; i < 3; i++)
                          //   PresBodyItemDesc(
                          //       itemDesc: 'ABC test cc 7 Months'),
                          PresBodyItemDesc(itemDesc: 'ABC test cc 7 Months'),
                          // Divider(
                          //   thickness: 0.6,
                          // )

                          SizedBox(height: 8),
                          PresBodyItemTitle(itemTitle: 'Family History:'),
                          PresBodyItemDesc(itemDesc: 'family h'),
                          PresBodyItemDesc(itemDesc: 'family 2'),
                          PresBodyItemDesc(itemDesc: 'family 5'),

                          SizedBox(height: 8),
                          PresBodyItemTitle(itemTitle: 'Previous History:'),
                          PresBodyItemDesc(itemDesc: 'Heart Block'),
                          PresBodyItemDesc(itemDesc: 'test prep history'),
                          PresBodyItemDesc(itemDesc: 'anklr pain'),

                          SizedBox(height: 8),
                          PresBodyItemTitle(
                              itemTitle: 'Provisional diagnosis:'),
                          PresBodyItemDesc(itemDesc: 'Heart Block'),
                          PresBodyItemDesc(itemDesc: 'headache and fever'),
                          PresBodyItemDesc(itemDesc: 'test proven diao'),
                          PresBodyItemDesc(itemDesc: 'test abc'),
                          PresBodyItemDesc(
                              itemDesc: 'headache and fever 5 Day'),

                          SizedBox(height: 8),
                          PresBodyItemTitle(itemTitle: 'Notes:'),
                          PresBodyItemDesc(itemDesc: 's'),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  // height: width * 2,
                  child: VerticalDivider(
                    thickness: 1.3,
                    color: Colors.black26,
                  ),
                ),
                //right container part
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/rx.png',
                        height: 30,
                      ),

                      //body right container

                      SizedBox(height: 8),
                      PresBodyItemTitle(itemTitle: 'Medicine:'),
                      for (int i = 0; i < 5; i++)
                        MedicineDesWidget(
                          medicineName:
                              'Powder For Suspension - Anaflex ( 125 mg/5ml )',
                          medication: '১+০+১ 4 Days',
                        ),

                      SizedBox(height: 8),
                      PresBodyItemTitle(itemTitle: 'Advice:'),
                      PresBodyItemDesc(itemDesc: 'need to take lots of water'),

                      SizedBox(height: 8),
                      PresBodyItemTitle(itemTitle: 'Investigation:'),
                      PresBodyItemDesc(itemDesc: '1 Unit Whole Blood w'),
                      PresBodyItemDesc(
                          itemDesc: '1 hour After 50 gm Glucose test ins'),

                      SizedBox(height: 8),
                      PresBodyItemTitle(itemTitle: 'Refer to a doctor:'),
                      ReferDoctorTile(
                        refereeName: 'Md. Quamruzzaman',
                        designation: 'Cardiology',
                        degree: 'FCPS',
                        bmdcNo: 'BMDC Reg No: 4420',
                        bdhlNo: 'Code: BDHL000003',
                        refChamber: 'Ref Cham: online Consultation Center',
                        note: 'Note: test note',
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
