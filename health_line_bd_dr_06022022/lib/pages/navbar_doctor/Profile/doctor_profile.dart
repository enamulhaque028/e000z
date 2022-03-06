import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_line_bd/config/sp_utils.dart';
import 'package:health_line_bd/pages/navbar_doctor/Profile/visiting_card_page.dart';
import 'components/components.dart';

class DoctorProfilePage extends StatefulWidget {
  const DoctorProfilePage({Key key}) : super(key: key);

  @override
  _DoctorProfilePageState createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  bool isLoading = true;
  String drName = '';
  String drDept = '';
  String drDegree = '';
  String drPhone = '';
  String drEmail = '';
  String drRegNo = '';
  String drSign = '';
  String drImage = '';
  @override
  void initState() {
    getRespFromSP().then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  Future getRespFromSP() async {
    drName = await SharedPref().getDrName();
    drDept = await SharedPref().getDrDept();
    drDegree = await SharedPref().getDrDegree();
    drPhone = await SharedPref().getDrMobileNo();
    drEmail = await SharedPref().getDrEmail();
    drRegNo = await SharedPref().getDrRegNo();
    drSign = await SharedPref().getDrSignImg();
    drImage = await SharedPref().getDrProfileImg();
  }

  @override
  Widget build(BuildContext context) {
    var topPadding = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: isLoading
          ? Center(
              child: Image.asset(
                'assets/images/loader.gif',
                height: 100,
              ),
            )
          : Center(
              child: Container(
                padding: EdgeInsets.only(top: topPadding),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://i.pinimg.com/originals/0b/6a/20/0b6a20d41f95f4fee448903c9479b288.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16),
                        Text(
                          'Welcome To',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'HealthLine BD',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 24),
                        Wrap(
                          runSpacing: -4,
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          drName.toString(),
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF2ca58d),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          drDegree.toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF727690),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.phone,
                                              color: Color(0xFF43bdde),
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              drPhone.toString(),
                                              style: TextStyle(
                                                color: Color(0xFF9da0b1),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.email_outlined,
                                              color: Color(0xFF43bdde),
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              drEmail.toString(),
                                              style: TextStyle(
                                                color: Color(0xFF9da0b1),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            DoctorProfileCardTile(
                                              shadowColor: Color(0xFF9f79ec),
                                              title: 'Degree',
                                              desc: drDegree.toString(),
                                            ),
                                            DoctorProfileCardTile(
                                              shadowColor: Color(0xFFfeab78),
                                              title: 'Department',
                                              desc: drDept.toString(),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            DoctorProfileCardTile(
                                              shadowColor: Color(0xFF56b3a4),
                                              title: 'BMDC Reg No',
                                              desc: drRegNo,
                                            ),
                                            DoctorSignCardTile(
                                              shadowColor: Colors.red[200],
                                              title: 'Sign',
                                              signImgUrl: drSign,
                                            ),
                                            // DoctorProfileCardTile(
                                            //   shadowColor: Colors.red[200],
                                            //   title: 'Sign',
                                            //   desc: 'signatiure',
                                            // ),
                                          ],
                                        ),
                                        SizedBox(height: 8),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: -50,
                                  right: 30,
                                  child: Container(
                                    padding: EdgeInsets.all(8), // Border width
                                    decoration: BoxDecoration(
                                        color:
                                            Color(0xFFd4eedf).withOpacity(0.7),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: SizedBox.fromSize(
                                        size:
                                            Size.fromRadius(48), // Image radius
                                        child: Image.network(
                                          drImage,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ClipperTimeLine(
                                  height: 15,
                                  lineColor: Colors.white,
                                  circleColor: Colors.tealAccent,
                                ),
                                ClipperTimeLine(
                                  height: 15,
                                  lineColor: Colors.white,
                                  circleColor: Colors.tealAccent,
                                ),
                              ],
                            ),
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        DoctorProfileInfoTile(
                                          iconData: Icons.share,
                                          iconColor: Colors.blue,
                                          title1: 'Share',
                                          title2: 'QR code',
                                          onTap: () async {
                                            var p = await SharedPref()
                                                .getLoginResp();
                                            var e = json.decode(p);
                                            log(e['objResponse']['userEmail']);
                                          },
                                        ),
                                        DoctorProfileInfoTile(
                                          iconData: Icons.copy_rounded,
                                          iconColor: Colors.black,
                                          title1: 'Copy',
                                          title2: 'Profile Link',
                                          onTap: () {},
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        DoctorProfileInfoTile(
                                            iconData: FontAwesomeIcons.idCard,
                                            iconColor: Colors.purple[900],
                                            title1: 'E-visiting',
                                            title2: 'Card',
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      VisitingCardPage(),
                                                ),
                                              );
                                            }),
                                        DoctorProfileInfoTile(
                                          iconData: Icons.info,
                                          iconColor: Colors.grey,
                                          title1: 'Other',
                                          title2: 'Information',
                                          onTap: () {},
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
