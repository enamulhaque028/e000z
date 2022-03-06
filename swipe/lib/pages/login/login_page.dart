import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';
// import 'package:swipe/pages/login/facebook_login/facebook_login.dart';
import 'package:swipe/pages/login/forgot_password/forgot_password_page.dart';
import 'package:swipe/pages/navbar/navbar_page.dart';
import 'package:swipe/pages/signup/signup_page.dart';
import 'package:swipe/services/login_service.dart';
import 'package:swipe/widgets/ProgressHUD.dart';
import 'package:swipe/widgets/app_title.dart';
import 'package:swipe/widgets/custom_icon_button.dart';
import 'package:swipe/widgets/custom_text_button.dart';
import 'package:swipe/widgets/textfield_rounded.dart';
import 'google_login/utils/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  bool isApiCallProcess = false;
  LoginService loginService = new LoginService();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.kBackground,
      body: ProgressHUD(
        inAsyncCall: isApiCallProcess,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: height * 0.25,
                    child: Center(
                      child: AppTitle(),
                    ),
                  ),
                  Column(
                    children: [
                      TextFieldRounded(
                        placeholderText: 'Your Email',
                        textEditingController: emailController,
                        icon: Icons.mail_outline,
                      ),
                      TextFieldRounded(
                        placeholderText: 'Password',
                        textEditingController: passwordController,
                        obscureText: true,
                        icon: Icons.lock_outline_sharp,
                      ),
                      SizedBox(height: 12),
                      CustomTextButton(
                        title: 'LOGIN',
                        onTapBtn: () {
                          if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.warning,
                              text: 'Fill all the fields!',
                            );
                          } else if (passwordController.text.length < 6) {
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.warning,
                              text: 'Password should be at least 6 characters!',
                            );
                          } else {
                            setState(() {
                              isApiCallProcess = true;
                            });
                            loginService.userLogin(
                              email: emailController.text,
                              password: passwordController.text,
                            ).then((value) {
                              if (loginService.statusCode == 200) {
                                setState(() {
                                  isApiCallProcess = false;
                                });
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NavBarPage(),
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
                      SizedBox(height: 12),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: AppColor.borderColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "OR",
                              style: TextStyle(
                                color: AppColor.primaryTextColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 1,
                              color: AppColor.borderColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      CustomIconButton(
                        title: 'LOGIN WITH FACEBOOK',
                        assetImgIcon: 'assets/images/fb_icon.png',
                        onTapBtn: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => FacebookLoginPage(),
                          //   ),
                          // );
                        },
                      ),
                      SizedBox(height: 16),
                      CustomIconButton(
                        title: 'LOGIN WITH GOOGLE    ',
                        assetImgIcon: 'assets/images/google_icon.png',
                        onTapBtn: () async {
                          bool res = await AuthProvider().loginWithGoogle();
                          if (!res) print("error logging in with google");
                        },
                      ),
                      SizedBox(height: 32),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgotPasswordPage(),
                                ),
                              );
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Colors.blue[800],
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignupPage(),
                                ),
                              );
                            },
                            child: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Don\'t have an account? ',
                                    style: TextStyle(
                                      color: AppColor.primaryTextColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Signup',
                                    style: TextStyle(
                                      color: Colors.blue[800],
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
