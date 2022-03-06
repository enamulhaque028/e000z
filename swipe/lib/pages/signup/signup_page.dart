import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swipe/config/presentation/app_color.dart';
import 'package:swipe/pages/login/login_page.dart';
import 'package:swipe/services/registration_service.dart';
import 'package:swipe/widgets/ProgressHUD.dart';
import 'package:swipe/widgets/app_title.dart';
import 'package:swipe/widgets/custom_text_button.dart';
import 'package:swipe/widgets/selection_field_rounded.dart';
import 'package:swipe/widgets/textfield_rounded.dart';
import 'components/country_list_dialog.dart';
import 'components/gender_list_dialog.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController confirmPasswordController = new TextEditingController();
  bool isVisibleNextPage = false;
  String selectedCountry = 'Select your country';
  String countryCode = '';
  String gender = 'Gender';
  String birthDayText = 'Date of Birth';
  bool isApiCallProcess = false;
  RegistrationService registrationService = new RegistrationService();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.kBackground,
      body: ProgressHUD(
        inAsyncCall: isApiCallProcess,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.3,
                  child: Center(
                    child: AppTitle(),
                  ),
                ),
                !isVisibleNextPage
                    ? Column(children: [
                        TextFieldRounded(
                          placeholderText: 'Name',
                          textEditingController: nameController,
                          icon: Icons.person_outline,
                        ),
                        TextFieldRounded(
                          placeholderText: 'Your Email',
                          textEditingController: emailController,
                          icon: Icons.email_outlined,
                        ),
                        TextFieldRounded(
                          placeholderText: 'Password',
                          textEditingController: passwordController,
                          icon: Icons.lock_outline_sharp,
                        ),
                        TextFieldRounded(
                          placeholderText: 'Confirm Password',
                          textEditingController: confirmPasswordController,
                          icon: Icons.lock_outline_sharp,
                        ),
                        SizedBox(height: 12),
                        CustomTextButton(
                          title: 'SIGN UP',
                          onTapBtn: () {
                            if (nameController.text.isEmpty || emailController.text.isEmpty || passwordController.text.isEmpty || confirmPasswordController.text.isEmpty) {
                              CoolAlert.show(
                                context: context,
                                type: CoolAlertType.warning,
                                text: 'Fill all the fields!',
                              );
                            } else {
                              if (passwordController.text.length < 6) {
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.warning,
                                  text:
                                      'Password should be at least 6 characters!',
                                );
                              } else if (passwordController.text !=
                                  confirmPasswordController.text) {
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.warning,
                                  text: 'Password hasn\'t matched!',
                                );                                
                              } else {
                                setState(() {
                                  isVisibleNextPage = true;
                                });
                              }
                            }
                          },
                        ),
                        SizedBox(height: 12),
                      ])
                    : Column(
                        children: [
                          SelectionFieldRounded(
                            placeholderText: selectedCountry,
                            iconPath: 'assets/images/earth.png',
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: AppColor.kBackground,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15.0),
                                      topRight: Radius.circular(15.0)),
                                ),
                                builder: (context) {
                                  return CountryListDialog(
                                    onTapChangedCountry: (name, code) {
                                      setState(() {
                                        selectedCountry = name;
                                        countryCode = code;
                                      });
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                              );
                            },
                          ),
                          SelectionFieldRounded(
                            placeholderText: gender,
                            iconPath: 'assets/images/gender.png',
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: AppColor.kBackground,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15.0),
                                      topRight: Radius.circular(15.0)),
                                ),
                                builder: (context) {
                                  return GenderListDialog(
                                    onTapChangeGender: (genderVal) {
                                      setState(() {
                                        gender = genderVal;
                                      });
                                      print(gender);
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                              );
                            },
                          ),
                          SelectionFieldRounded(
                            placeholderText: birthDayText,
                            iconPath: 'assets/images/calender.png',
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now().subtract(Duration(days: 365*18)),
                                firstDate: DateTime(1930, 1),
                                lastDate: DateTime.now().subtract(Duration(days: 365*18)),
                              ).then((pickedDate) {
                                String formattedDate = DateFormat('MM/dd/yyyy').format(pickedDate!);
                                setState(() {
                                  birthDayText = formattedDate;
                                });
                                print(birthDayText);
                              });
                            },
                          ),
                          SizedBox(height: 16),
                          SizedBox(
                            height: 60,
                            width: 70,
                            child: CustomTextButton(
                              showArrow: true,
                              title: '',
                              onTapBtn: () {
                                if (selectedCountry == 'Select your country' || gender == 'Gender' || birthDayText == 'Date of Birth') {
                                  CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.warning,
                                    text: 'Fill all the fields!',
                                  );
                                } else {
                                  setState(() {
                                    isApiCallProcess = true;
                                  });
                                  registrationService.userRegistration(
                                    name: nameController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    gender: gender,
                                    birthday: birthDayText,
                                    country: selectedCountry,
                                    countryCode: countryCode,
                                  ).then((value) {
                                    if (registrationService.statusCode == 201) {
                                      setState(() {
                                        isApiCallProcess = false;
                                      });
                                      Navigator.of(context).pop();
                                      CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.success,
                                        text: 'Registration successful!',
                                      );
                                    } else {
                                      setState(() {
                                        isApiCallProcess = false;
                                      });
                                      CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.error,
                                          text: value['message']);
                                    }
                                  });
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 12),
                        ],
                      ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.1),
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Already have an account? ',
                            style: TextStyle(
                              color: AppColor.primaryTextColor,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: 'Login',
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
