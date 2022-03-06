import 'package:flutter/material.dart';
import 'package:health_line_bd/config/sp_utils.dart';
import 'package:health_line_bd/pages/navbar_doctor/Profile/components/visiting_card/doctor_visiting_card.dart';

class VisitingCardPage extends StatefulWidget {
  const VisitingCardPage({Key key}) : super(key: key);

  @override
  _VisitingCardPageState createState() => _VisitingCardPageState();
}

class _VisitingCardPageState extends State<VisitingCardPage> {
  String selectedVisitingCard;
  @override
  void initState() {
    getVistingCardFromSP();
    super.initState();
  }

  getVistingCardFromSP() async {
    String value = await SharedPref().getVisitingCard();
    setState(() {
      selectedVisitingCard = value;
    });
    print('Selected Visiting Card: $selectedVisitingCard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            selectedVisitingCard == 'card1' ? DrVisitingCard1() : Container(),
      ),
    );
  }
}
