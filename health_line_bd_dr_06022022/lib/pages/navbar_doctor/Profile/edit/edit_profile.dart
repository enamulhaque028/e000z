import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:health_line_bd/config/common_const.dart';
import 'package:health_line_bd/config/sp_utils.dart';
import 'package:health_line_bd/pages/navbar_doctor/Profile/edit/widgets/dropdown/dropdown_view.dart';
import 'package:health_line_bd/widgets/custom_progress.dart';
import 'widgets/image_picker.dart';
import 'widgets/text_field.dart';

class EditProfileDialog extends StatefulWidget {
  const EditProfileDialog({
    Key key,
  }) : super(key: key);

  @override
  _EditProfileDialogState createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController degreeController = new TextEditingController();
  TextEditingController regController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _autoValidate = false;
  bool isApiCallProcess = false;

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
        nameController.text = drName;
        emailController.text = drEmail;
        degreeController.text = drDegree;
        regController.text = drRegNo;
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
    return ProgressHUD(
      inAsyncCall: isApiCallProcess,
      child: AlertDialog(
        // title: new Text('Warning'),
        content: Form(
          key: _formKey,
          // ignore: deprecated_member_use
          autovalidate: _autoValidate,
          child: isLoading
              ? Center(
                  child: Image.asset(
                    'assets/images/loader.gif',
                    height: 100,
                  ),
                )
              : SingleChildScrollView(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            Text(
                              'Update profile',
                              style: TextStyle(
                                color: cViolet,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                Icons.cancel,
                                size: 26,
                                color: cViolet,
                              ),
                            ),
                          ],
                        ),
                        CustomtextField(
                          textController: nameController,
                          labeltext: 'Enter name',
                          icon: Icons.person,
                          onTapCalendar: () {},
                        ),
                        CustomtextField(
                          textController: emailController,
                          labeltext: 'Enter email',
                          icon: Icons.email_outlined,
                          onTapCalendar: () {},
                        ),
                        CustomtextField(
                          textController: degreeController,
                          labeltext: 'Enter Degree',
                          icon: Icons.verified_outlined,
                          onTapCalendar: () {},
                        ),
                        CustomtextField(
                          textController: regController,
                          labeltext: 'Enter BMDC REG NO',
                          icon: Icons.format_list_numbered_outlined,
                          onTapCalendar: () {},
                        ),
                        DropDownView(),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Text(
                                'Upload your profile image',
                                style: TextStyle(
                                  color: cViolet,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            PickImages(
                              imageType: 'profile',
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Text(
                                'Upload your signature',
                                style: TextStyle(
                                  color: cViolet,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            PickImages(
                              imageType: 'signature',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.send,
                size: 28,
                color: cViolet,
              ),
              onPressed: () async {
                String profileImage = PickImages.profileImgPath;
                String signatureImage = PickImages.signatureImgPath;
                if (_formKey.currentState.validate()) {
                  print('Profile Image: $profileImage');
                  print('Signature Image: $signatureImage');
                  log(nameController.text);
                  setState(() {
                    isApiCallProcess = true;
                  });
                  // UpdateInfoService()
                  //     .studentInfoUpdate(
                  //   name: nameController.text,
                  //   profileImgPath: profileImage,
                  //   signatureImgPath: signatureImage,
                  // )
                  //     .then((value) {
                  //   if (value['success'].toString() == 'true') {
                  //     setState(() {
                  //       isApiCallProcess = false;
                  //     });
                  //     // Phoenix.rebirth(context);
                  //     String studentName = value['data']['studentInfo']
                  //             ['students_name']
                  //         .toString();
                  //     String imageUrl = imageBaseUrl +
                  //         value['data']['student_image']['students_image']
                  //             .toString();
                  //     String signatureUrl = imageBaseUrl +
                  //         value['data']['students_signature']
                  //                 ['students_signature']
                  //             .toString();
                  //     prefs.setString('studentName', studentName);
                  //     prefs.setString('imageUrl', imageUrl);
                  //     prefs.setString('signatureUrl', signatureUrl);
                  //     CoolAlert.show(
                  //         context: context,
                  //         // width: 350,
                  //         type: CoolAlertType.success,
                  //         text: "Update profile successful!",
                  //     );
                  //   } else {
                  //     setState(() {
                  //       isApiCallProcess = false;
                  //     });
                  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //       content: Text('Update failed! Please try again'),
                  //     ));
                  //   }
                  // });
                  _formKey.currentState.save();
                } else {
                  setState(() {
                    _autoValidate = true;
                  });
                }
              })
        ],
      ),
    );
  }
}
