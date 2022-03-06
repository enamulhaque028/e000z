// import 'package:flutter/material.dart';
// import 'package:health_line_bd/config/common_const.dart';

// class VisitingCardChooserDialog extends StatefulWidget {
//   @override
//   _VisitingCardChooserDialogState createState() =>
//       _VisitingCardChooserDialogState();
// }

// class _VisitingCardChooserDialogState extends State<VisitingCardChooserDialog> {
//   bool selectCard1 = false;
//   bool selectCard2 = false;
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: kBackgroundColor,
//       content: Container(
//         height: 150,
//         width: 250,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Choose your visiting card'),
//             SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 InkWell(
//                   onTap: () {
//                     setState(() {
//                       selectCard1 = true;
//                       selectCard2 = false;
//                     });
//                   },
//                   child: CircleAvatar(
//                     radius: 30,
//                     backgroundColor:
//                         selectCard1 ? Colors.green : Colors.transparent,
//                     child: CircleAvatar(
//                       radius: 25,
//                       backgroundImage: NetworkImage(
//                           'https://images.creativemarket.com/0.1.0/ps/4334228/1500/1125/m1/fpnw/wm0/01_screenshot-.jpg?1524336486&s=4c37fa2c8248e20ea8a8d4b5cd4f7e8c'),
//                     ),
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     setState(() {
//                       selectCard1 = false;
//                       selectCard2 = true;
//                     });
//                   },
//                   child: CircleAvatar(
//                     radius: 30,
//                     backgroundColor:
//                         selectCard2 ? Colors.green : Colors.transparent,
//                     child: CircleAvatar(
//                       radius: 25,
//                       backgroundImage: NetworkImage(
//                           'https://images.creativemarket.com/0.1.0/ps/4334228/1500/1125/m1/fpnw/wm0/01_screenshot-.jpg?1524336486&s=4c37fa2c8248e20ea8a8d4b5cd4f7e8c'),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:health_line_bd/config/common_const.dart';
import 'package:health_line_bd/config/sp_utils.dart';
import 'package:health_line_bd/pages/navbar_doctor/Profile/components/visiting_card/front_visiting_card_view.dart';
import 'package:health_line_bd/pages/navbar_doctor/settings/visiting_card/components/data.dart';
import 'package:health_line_bd/pages/navbar_doctor/settings/visiting_card/components/model.dart';

import 'components/visiting_card_item_tile.dart';

class VisitingCardChooserDialog extends StatefulWidget {
  @override
  _VisitingCardChooserDialogState createState() =>
      _VisitingCardChooserDialogState();
}

class _VisitingCardChooserDialogState extends State<VisitingCardChooserDialog> {
  List<VisitingCardModel> data = getVisitingcardData();
  int selectedIndex;
  bool selectBlue = false;
  bool selectRed = false;
  bool selectOrange = false;
  Color visitingCardColor = Colors.blue;

  getVistingCardColorFromSP() async {
    String value = await SharedPref().getVisitingCardColor();
    if (value == 'red') {
      setState(() {
        visitingCardColor = Colors.red;
      });
    } else if (value == 'orange') {
      setState(() {
        visitingCardColor = Colors.orange;
      });
    } else {
      setState(() {
        visitingCardColor = Colors.blue;
      });
    }
    print('Visiting Card Color: $value');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kBackgroundColor,
      content: Container(
        height: selectedIndex == null ? 230 : 330,
        width: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select your visiting card',
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            Container(
              height: 190,
              decoration: BoxDecoration(
                border: Border.all(color: cViolet),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: 8),
                    GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: (3 / 2),
                      ),
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                            SharedPref().setVisitingCard(data[index].spValue);
                          },
                          child: VisitingCardItemTile(
                            imageUrl: data[index].imageUrl,
                            color: selectedIndex == index
                                ? Colors.green
                                : Colors.transparent,
                          ),
                        );
                      },
                    ),
                    // SizedBox(height: 12),
                    if (selectedIndex != null)
                      FittedBox(
                        child: Transform.scale(
                            alignment: Alignment.topCenter,
                            scale: 0.6,
                            child: FrontVisitingCardView(
                                blockColor: visitingCardColor)),
                      ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),
            if (selectedIndex != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Choose your color',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: cViolet),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectBlue = true;
                              selectRed = false;
                              selectOrange = false;
                            });
                            SharedPref().setVisitingCardColor('blue');
                            getVistingCardColorFromSP();
                          },
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor:
                                selectBlue ? Colors.green : Colors.transparent,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.blue,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectRed = true;
                              selectBlue = false;
                              selectOrange = false;
                            });
                            SharedPref().setVisitingCardColor('red');
                            getVistingCardColorFromSP();
                          },
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor:
                                selectRed ? Colors.green : Colors.transparent,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectOrange = true;
                              selectRed = false;
                              selectBlue = false;
                            });
                            SharedPref().setVisitingCardColor('orange');
                            getVistingCardColorFromSP();
                          },
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: selectOrange
                                ? Colors.green
                                : Colors.transparent,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.orange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
