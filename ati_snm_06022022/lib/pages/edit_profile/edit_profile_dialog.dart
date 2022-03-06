import 'dart:developer';
import 'package:dil_app/config/common_const.dart';
import 'package:dil_app/custom/pick_single_image.dart';
import 'package:dil_app/custom/text_field.dart';
import 'package:dil_app/pages/login/custom_progress/ProgressHUD.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String name = '';
  String email = '';
  @override
  void initState() {
    getRespFromSP().then((value) {
      setState(() {
        isLoading = false;
        nameController.text = name;
        emailController.text = email;
      });
    });
    super.initState();
  }

  Future getRespFromSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('userName');
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
          child: SingleChildScrollView(
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
                      PickSingleImages(imageType: 'profile'),
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
                String profileImage = PickSingleImages.profileImgPath;
                if (_formKey.currentState.validate()) {
                  print('Profile Image: $profileImage');
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
