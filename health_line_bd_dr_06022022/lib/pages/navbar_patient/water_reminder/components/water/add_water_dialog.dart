import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_line_bd/config/common_const.dart';

class AddWaterDialog extends StatefulWidget {
  final Function(String) onTapChanged;
  final String totalGlassofWaterTaken;

  const AddWaterDialog(
      {Key key,
      @required this.onTapChanged,
      @required this.totalGlassofWaterTaken})
      : super(key: key);

  @override
  _AddWaterDialogState createState() => _AddWaterDialogState();
}

class _AddWaterDialogState extends State<AddWaterDialog> {
  int glassOfWater = 1;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 12, bottom: 12, left: 16),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    FontAwesomeIcons.water,
                    // size: 20,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width - 60,
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'How many glass of water have you taken?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 8),
            Container(
              width: 240,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: cViolet,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Row(
                children: [
                  Text(
                    'Total Glass of water taken: ',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${widget.totalGlassofWaterTaken}',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 130,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: cViolet,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              if (glassOfWater >= 2)
                                setState(() {
                                  glassOfWater--;
                                });
                            },
                            child: Icon(Icons.remove),
                          ),
                          Stack(
                            children: [
                              Image.asset(
                                'assets/images/water_glass.png',
                                height: 45,
                              ),
                              Positioned(
                                  top: 15,
                                  left: 18,
                                  child: Text(glassOfWater.toString())),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                glassOfWater++;
                              });
                            },
                            child: Icon(Icons.add),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: SizedBox(
                      width: 80,
                      height: 40,
                      child: InkWell(
                        onTap: () {
                          var drunkWater = glassOfWater / 4;
                          widget.onTapChanged(drunkWater.toString());
                        },
                        child: Container(
                          height: 48,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                                Color.fromRGBO(26, 201, 253, 1),
                                Color.fromRGBO(29, 105, 241, 1)
                              ],
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Add',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
