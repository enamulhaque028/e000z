import 'package:flutter/material.dart';
import 'package:health_line_bd/config/sp_utils.dart';
import 'package:health_line_bd/pages/navbar_doctor/Profile/components/visiting_card/back_visiting_card_view.dart';
import 'package:health_line_bd/pages/navbar_doctor/Profile/components/visiting_card/front_visiting_card_view.dart';

class DrVisitingCard1 extends StatefulWidget {
  DrVisitingCard1State createState() => new DrVisitingCard1State();
}

class DrVisitingCard1State extends State<DrVisitingCard1>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _frontScale;
  Animation<double> _backScale;
  Color visitingCardColor;

  @override
  void initState() {
    getVistingCardColorFromSP();
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _frontScale = new Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(new CurvedAnimation(
      parent: _controller,
      curve: new Interval(0.0, 0.5, curve: Curves.easeIn),
    ));
    _backScale = new CurvedAnimation(
      parent: _controller,
      curve: new Interval(0.5, 1.0, curve: Curves.easeOut),
    );
  }

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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (_controller.isCompleted || _controller.velocity > 0)
              _controller.reverse();
            else
              _controller.forward();
          });
        },
        child: new Stack(
          children: <Widget>[
            new AnimatedBuilder(
              child: FrontVisitingCardView(
                blockColor: visitingCardColor,
              ),
              animation: _frontScale,
              builder: (BuildContext context, Widget child) {
                final Matrix4 transform = new Matrix4.identity()
                  ..scale(1.0, _frontScale.value, 1.0);
                return new Transform(
                  transform: transform,
                  alignment: FractionalOffset.center,
                  child: child,
                );
              },
            ),
            new AnimatedBuilder(
              child: BackVisitingCardView(
                blockColor: visitingCardColor,
              ),
              animation: _backScale,
              builder: (BuildContext context, Widget child) {
                final Matrix4 transform = new Matrix4.identity()
                  ..scale(1.0, _backScale.value, 1.0);
                return new Transform(
                  transform: transform,
                  alignment: FractionalOffset.center,
                  child: child,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
