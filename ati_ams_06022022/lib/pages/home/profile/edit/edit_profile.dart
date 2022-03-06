import 'dart:developer';
import 'package:ati_ams/config/common_const.dart';
import 'package:ati_ams/services/update_info_service.dart';
import 'package:ati_ams/widgets/custom_progress.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../home_page.dart';
import 'widgets/image_picker.dart';
import 'widgets/text_field.dart';

class EditProfileDialog extends StatefulWidget {
  final String defaultName;
  const EditProfileDialog({
    Key key,
    @required this.defaultName,
  }) : super(key: key);

  @override
  _EditProfileDialogState createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  TextEditingController nameController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _autoValidate = false;
  bool isApiCallProcess = false;

  @override
  void initState() {
    nameController.text = widget.defaultName;
    super.initState();
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
                  nameController: nameController,
                  labeltext: 'Enter name',
                  icon: Icons.person,
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
                SharedPreferences prefs = await SharedPreferences.getInstance();
                if (_formKey.currentState.validate()) {
                  print('Profile Image: $profileImage');
                  print('Signature Image: $signatureImage');
                  log(nameController.text);
                  setState(() {
                    isApiCallProcess = true;
                  });
                  UpdateInfoService()
                      .studentInfoUpdate(
                    name: nameController.text,
                    profileImgPath: profileImage,
                    signatureImgPath: signatureImage,
                  )
                      .then((value) {
                    if (value['success'].toString() == 'true') {
                      setState(() {
                        isApiCallProcess = false;
                      });
                      // Phoenix.rebirth(context);
                      String studentName = value['data']['studentInfo']
                              ['students_name']
                          .toString();
                      String imageUrl = imageBaseUrl +
                          value['data']['student_image']['students_image']
                              .toString();
                      String signatureUrl = imageBaseUrl +
                          value['data']['students_signature']
                                  ['students_signature']
                              .toString();
                      prefs.setString('studentName', studentName);
                      prefs.setString('imageUrl', imageUrl);
                      prefs.setString('signatureUrl', signatureUrl);
                      CoolAlert.show(
                          context: context,
                          // width: 350,
                          type: CoolAlertType.success,
                          text: "Update profile successful!",
                          onConfirmBtnTap: () async {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext ctx) => HomePage()),
                              (Route<dynamic> route) => false,
                            );
                          });
                    } else {
                      setState(() {
                        isApiCallProcess = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Update failed! Please try again'),
                      ));
                    }
                  });
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
