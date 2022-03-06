import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:swipe/config/presentation/app_color.dart';
import 'package:swipe/services/password/verify_password_service.dart';
import 'package:swipe/widgets/ProgressHUD.dart';
import 'package:swipe/widgets/custom_text_button.dart';
import 'update_password_page.dart';

class VerificationCodePage extends StatefulWidget {
  final String email;
  const VerificationCodePage({Key? key, required this.email}) : super(key: key);

  @override
  State<VerificationCodePage> createState() => _VerificationCodePageState();
}

class _VerificationCodePageState extends State<VerificationCodePage> {
  String verificationCode = '';
  bool isApiCallProcess = false;
  VerifyPasswordService verifyPasswordService = new VerifyPasswordService();
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
                    'assets/images/verification.png',
                    height: 145,
                    width: 145,
                  ),
                  Text(
                    'Verification Code',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(90, 90, 90, 1),
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                'Please enter the 4-digit code send to you at ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(159, 159, 159, 1),
                            ),
                          ),
                          TextSpan(
                            text: widget.email,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  PinCodeTextField(
                    length: 4,
                    obscureText: false,
                    appContext: context,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(25),
                      fieldHeight: 50,
                      fieldWidth: 80,
                      borderWidth: 1,
                      activeFillColor: Colors.white,
                      inactiveColor: Colors.grey.withOpacity(0.5),
                      inactiveFillColor: AppColor.kBackground,
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    // backgroundColor: Colors.blue.shade50,
                    enableActiveFill: true,
                    // errorAnimationController: errorController,
                    // controller: textEditingController,
                    onCompleted: (pin) {
                      print(':::::::$pin::::::');
                      setState(() {
                        verificationCode = pin;
                      });
                    },
                    onChanged: (value) {
                      // print(value);
                      // setState(() {
                      //   currentText = value;
                      // });
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                  ),
                  SizedBox(height: 8),
                  CustomTextButton(
                    title: 'Verify',
                    onTapBtn: () {
                      if (verificationCode == '') {
                        CoolAlert.show(
                          context: context,
                          type: CoolAlertType.warning,
                          text: 'Enter verification code!',
                        );
                      } else {
                        setState(() {
                          isApiCallProcess = true;
                        });
                        verifyPasswordService
                            .verifyCode(
                                email: widget.email, code: verificationCode)
                            .then((value) {
                          if (verifyPasswordService.statusCode == 200) {
                            setState(() {
                              isApiCallProcess = false;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdatePasswordPage(
                                  token: value['token'],
                                ),
                              ),
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
