import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';
import 'package:swipe/pages/login/forgot_password/verification_code_page.dart';
import 'package:swipe/services/password/forgot_password_service.dart';
import 'package:swipe/widgets/ProgressHUD.dart';
import 'package:swipe/widgets/custom_text_button.dart';
import 'package:swipe/widgets/textfield_rounded.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = new TextEditingController();
  bool isApiCallProcess = false;
  ForgotPasswordService forgotPasswordService = new ForgotPasswordService();
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
                    'assets/images/forgot_pass.png',
                    height: 145,
                    width: 145,
                  ),
                  Text(
                    'Forgot Password',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(90, 90, 90, 1),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Text(
                      'Please enter your registered Phone Number to reset your password.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(159, 159, 159, 1),
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  TextFieldRounded(
                    placeholderText: 'Enter Your Email',
                    textEditingController: emailController,
                    icon: Icons.mail_outline,
                    textColor: Color.fromRGBO(224, 224, 224, 1),
                  ),
                  SizedBox(height: 8),
                  CustomTextButton(
                    title: 'SEND CODE',
                    onTapBtn: () {
                      if (emailController.text.isEmpty) {
                        CoolAlert.show(
                          context: context,
                          type: CoolAlertType.warning,
                          text: 'Enter your email!',
                        );
                      } else {
                        setState(() {
                          isApiCallProcess = true;
                        });
                        forgotPasswordService
                            .sendCode(email: emailController.text)
                            .then((value) {
                          if (forgotPasswordService.statusCode == 200) {
                            setState(() {
                              isApiCallProcess = false;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VerificationCodePage(
                                  email: emailController.text,
                                ),
                              ),
                            );
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.success,
                              text: value['message'].toString(),
                            );
                          } else {
                            setState(() {
                              isApiCallProcess = false;
                            });
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.error,
                              text: value['message'].toString(),
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
