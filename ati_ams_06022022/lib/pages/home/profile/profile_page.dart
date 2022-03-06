import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'edit/widgets/image_picker.dart';
import 'view/profile_view.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map apiResp = {};
  bool isLoading = true;
  String imageUrl = '';
  String signatureUrl = '';
  String name = '';
  @override
  void initState() {
    getRespFromSP().then((data) {
      setState(() {
        apiResp = data['data']['user_info'];
        isLoading = false;
      });
    });
    super.initState();
  }

  Future getRespFromSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    apiResp = json.decode(prefs.getString('apiresp'));
    imageUrl = prefs.getString('imageUrl');
    signatureUrl = prefs.getString('signatureUrl');
    name = prefs.getString('studentName');
    return apiResp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeaf4ff),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : InkWell(
              onTap: () {
                log(signatureUrl);
              },
              child: ProfileTile(
                imageUrl: (apiResp['students_image'].toString() == '' &&
                        PickImages.profileImgPath == '')
                    ? ''
                    : imageUrl,
                signatureUrl: (apiResp['students_signature'].toString() == '' &&
                        PickImages.signatureImgPath == '')
                    ? ''
                    : signatureUrl,
                name: name.toString(),
                department: 'Dept. of ${apiResp['DEPARTMENT'].toString()}',
                id: apiResp['stu_id'].toString(),
                session: apiResp['SESSION_YEAR'].toString(),
                batchNo: apiResp['BATCH'].toString(),
                courseType: apiResp['COURSE_TYPE'].toString(),
                courseName: apiResp['COURSE_NAME'].toString(),
                gender: apiResp['GENDER'].toString(),
                dateOfBirth: apiResp['date_of_birth'].toString(),
              ),
            ),
    );
  }
}


// ProfileTile(
//         imageUrl: 'https://enamulhaque028.github.io/profile/img/profile.jpg',
//         name: 'MD Enamul Haque',
//         department: 'Dept. of Cardiology',
//         id: '01-MSOG-220002',
//         session: '2022',
//         batchNo: '1st',
//         courseType: 'MS',
//         courseName: 'Obstetrics & Gynecology',
//         gender: 'Male',
//         dateOfBirth: '8-Oct-1996',
//       ),