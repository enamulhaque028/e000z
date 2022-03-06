import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:health_line_bd/model/lis/profile_model.dart';

class BackView extends StatelessWidget {
  final PReturnmsg profileInfo;
  const BackView({Key key, @required this.profileInfo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    String profileImage =
        profileInfo.sorgndrtxt.toString().toLowerCase() == 'male'
            ? 'assets/images/male.png'
            : 'assets/images/female.png';
    return Stack(
      children: <Widget>[
        Container(
          height: 260,
          width: width,
          child: Card(
            semanticContainer: true,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image.asset(
              'assets/images/background1.jpg',
              fit: BoxFit.fill,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            margin: EdgeInsets.all(20),
          ),
        ),
        Container(
          height: 220,
          width: width,
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.black38,
          ),
          //color: Colors.black26,
        ),
        // Positioned(
        //   top: 20,
        //   left: 20,
        //   child: Container(
        //     height: 42,
        //     child: Image.asset('assets/images/meditop1.png'),
        //   ),
        // ),
        Positioned(
          top: 20,
          right: 20,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 30,
              backgroundImage: profileInfo.photoLoca.toString() == ''
                  ? AssetImage(profileImage)
                  : NetworkImage(
                      profileInfo.photoLoca.toString(),
                    ),
            ),
          ),
        ),
        profileInfo.patientNm.toString() == ''
            ? Container()
            : Positioned(
                top: 80,
                left: 20,
                child: Container(
                  padding: EdgeInsets.only(left: 8.0),
                  child: RichText(
                    text: TextSpan(
                      text: 'Name: ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: profileInfo.patientNm.toString(),
                          style: TextStyle(
                            color: Colors.yellow[200],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        profileInfo.patientNm.toString() == ''
            ? Container()
            : Positioned(
                top: 105,
                left: 20,
                child: Container(
                  padding: EdgeInsets.only(left: 8.0),
                  child: RichText(
                    text: TextSpan(
                      text: 'Phone No. : ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: profileInfo.pmobileNo.toString(),
                          style: TextStyle(
                            color: Colors.yellow[200],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        profileInfo.patientNm.toString() == ''
            ? Container()
            : Positioned(
                top: 130,
                left: 20,
                child: Container(
                  padding: EdgeInsets.only(left: 8.0),
                  child: RichText(
                    text: TextSpan(
                      text: 'Email: ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: profileInfo.ptemailNo.toString(),
                          style: TextStyle(
                            color: Colors.yellow[200],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        profileInfo.patientNm.toString() == ''
            ? Container()
            : Positioned(
                top: 155,
                left: 20,
                child: Container(
                  padding: EdgeInsets.only(left: 8.0),
                  child: RichText(
                    text: TextSpan(
                      text: 'Date of Birth: ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: profileInfo.calcptDob.toString(),
                          style: TextStyle(
                            color: Colors.yellow[200],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        profileInfo.patientNm.toString() == ''
            ? Container()
            : Positioned(
                top: 180,
                left: 20,
                child: Container(
                  padding: EdgeInsets.only(left: 8.0),
                  child: RichText(
                    text: TextSpan(
                      text: 'Blood Group: ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: profileInfo.bldgrpTxt.toString(),
                          style: TextStyle(
                            color: Colors.yellow[200],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
        Positioned(
          bottom: 30,
          right: 30,
          child: Container(
            height: 50,
            child: Image.asset('assets/images/barcode.jpg'),
          ),
        ),
      ],
    );
  }
}
