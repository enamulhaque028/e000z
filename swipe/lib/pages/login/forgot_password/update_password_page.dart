import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';
import 'package:swipe/pages/login/login_page.dart';
import 'package:swipe/services/password/update_password_service.dart';
import 'package:swipe/widgets/ProgressHUD.dart';
import 'package:swipe/widgets/custom_text_button.dart';
import 'package:swipe/widgets/textfield_rounded.dart';

class UpdatePasswordPage extends StatefulWidget {
  final String token;
  const UpdatePasswordPage({Key? key, required this.token}) : super(key: key);

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final TextEditingController newPassController = new TextEditingController();
  final TextEditingController confirmPassPassController =
      new TextEditingController();
  UpdatePasswordService updatePasswordService = new UpdatePasswordService();
  bool isApiCallProcess = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kBackground,
      body: ProgressHUD(
        inAsyncCall: isApiCallProcess,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/set_pass.png',
                    height: 150,
                    width: 150,
                  ),
                  SizedBox(height: 32),
                  TextFieldRounded(
                    placeholderText: 'New Password',
                    textEditingController: newPassController,
                    icon: Icons.lock_outline_sharp,
                  ),
                  SizedBox(height: 8),
                  TextFieldRounded(
                    placeholderText: 'Confirm Password',
                    textEditingController: confirmPassPassController,
                    icon: Icons.lock_outline_sharp,
                  ),
                  SizedBox(height: 8),
                  CustomTextButton(
                    title: 'UPDATE',
                    onTapBtn: () {
                      if (newPassController.text.isEmpty ||
                          confirmPassPassController.text.isEmpty) {
                        CoolAlert.show(
                          context: context,
                          type: CoolAlertType.warning,
                          text: 'Enter new password and confirm password!',
                        );
                      } else if (newPassController.text !=
                          confirmPassPassController.text) {
                        CoolAlert.show(
                          context: context,
                          type: CoolAlertType.warning,
                          text: 'Password hasn\'t matched!',
                        );
                      } else {
                        setState(() {
                          isApiCallProcess = true;
                        });
                        updatePasswordService
                            .updateCode(
                                password: confirmPassPassController.text,
                                token: widget.token)
                            .then((value) {
                          if (updatePasswordService.statusCode == 200) {
                            setState(() {
                              isApiCallProcess = false;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.success,
                              text: value['message'],
                            );
                          } else {
                            setState(() {
                              isApiCallProcess = false;
                            });
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.error,
                              text: value['message'],
                            );
                          }
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
