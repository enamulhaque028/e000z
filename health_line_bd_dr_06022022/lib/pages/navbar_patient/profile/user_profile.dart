import 'package:flutter/material.dart';
import 'package:health_line_bd/config/common_const.dart';
import 'dart:ui';
import 'package:health_line_bd/model/lis/profile_model.dart';
import 'package:health_line_bd/services/lis/profile_service.dart';
import 'package:health_line_bd/widgets/timeline_widget.dart';
import 'components/flip_card/flip_card.dart';
import 'components/user_info_tile.dart';

class UserProfile extends StatefulWidget {
  final bool isIdFromAccount;
  final String pId;

  const UserProfile(
      {Key key, @required this.isIdFromAccount, @required this.pId})
      : super(key: key);
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  TextEditingController _nameController = TextEditingController();
  bool isEditable = false;
  Profile profileData = new Profile();
  var isLoading = true;

  @override
  void initState() {
    ProfileService()
        .fetchProfileData(widget.isIdFromAccount, widget.pId)
        .then((data) {
      setState(() {
        profileData = data;
        isLoading = false;
      });
    });
    super.initState();
    _nameController.text =
        "MD. Enamul Haque"; // Setting the initial value for the field.
  }

  @override
  Widget build(BuildContext context) {
    // double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        brightness: Brightness.dark,
        centerTitle: true,
        title: Text(
          'Patient Profile',
          //style: TextStyle(fontSize: 19),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(cViolet),
              ),
            )
          : Container(
              // padding: EdgeInsets.only(
              //   top: statusBarHeight,
              //   //left: 20,
              // ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FlipCard(
                      profileInfo: profileData.pReturnmsg[0],
                    ),
                    // SizedBox(
                    //   height: 15,
                    // ),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: profileData.pReturnmsg.isEmpty
                          ? Center(
                              child: Text('No data found!'),
                            )
                          : Column(
                              children: [
                                Row(
                                  children: [
                                    CustomTimeLine(height: 50),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Expanded(
                                        flex: 15,
                                        child: !isEditable
                                            ? Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Name',
                                                    style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    // _nameController.text,
                                                    profileData
                                                        .pReturnmsg[0].patientNm
                                                        .toString(),
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                  Divider(
                                                    thickness: 1.0,
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                ],
                                              )
                                            : TextFormField(
                                                controller: _nameController,
                                                textInputAction:
                                                    TextInputAction.done,
                                                onFieldSubmitted: (value) {
                                                  print('Name Changed!');
                                                  setState(() {
                                                    isEditable = false;
                                                    _nameController.text =
                                                        value;
                                                  });
                                                })),
                                    // IconButton(
                                    //     icon: Icon(
                                    //       FontAwesomeIcons.edit,
                                    //       size: 15,
                                    //     ),
                                    //     onPressed: () {
                                    //       setState(() {
                                    //         isEditable = true;
                                    //       });
                                    //     })
                                  ],
                                ),
                                // UserInfoTile(
                                //   title: 'Force Name',
                                //   info: 'Bangladesh Army',
                                // ),
                                // UserInfoTile(
                                //   title: 'Rank',
                                //   info: 'Major General',
                                // ),
                                // UserInfoTile(
                                //   title: 'Working Unit',
                                //   info: 'Dhaka',
                                // ),
                                UserInfoTile(
                                  title: 'Nationality',
                                  info: profileData.pReturnmsg[0].nationalty
                                      .toString(),
                                ),
                                UserInfoTile(
                                  title: 'Date of Birth',
                                  info: profileData.pReturnmsg[0].calcptDob
                                      .toString(),
                                ),
                                UserInfoTile(
                                  title: 'Religion',
                                  info: profileData.pReturnmsg[0].relgnName
                                      .toString(),
                                ),
                                UserInfoTile(
                                  title: 'Gender',
                                  info: profileData.pReturnmsg[0].sorgndrtxt
                                      .toString(),
                                ),
                                UserInfoTile(
                                  title: 'Blood Group',
                                  info: profileData.pReturnmsg[0].bldgrpTxt
                                      .toString(),
                                ),
                                UserInfoTile(
                                  title: 'Maritial Status',
                                  info: profileData.pReturnmsg[0].mstusName
                                      .toString(),
                                ),
                                UserInfoTile(
                                  title: 'Phone',
                                  info: profileData.pReturnmsg[0].pmobileNo
                                      .toString(),
                                ),
                                UserInfoTile(
                                  title: 'Email',
                                  info: profileData.pReturnmsg[0].ptemailNo
                                      .toString(),
                                ),
                                UserInfoTile(
                                  title: 'National ID',
                                  info: profileData.pReturnmsg[0].nationalid
                                      .toString(),
                                ),
                                UserInfoTile(
                                  title: 'Present Address',
                                  info: profileData.pReturnmsg[0].ptAddress
                                      .toString(),
                                ),
                                UserInfoTile(
                                  title: 'Patient Status',
                                  info: profileData.pReturnmsg[0].patStatus
                                      .toString(),
                                ),
                              ],
                            ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
