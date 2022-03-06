import 'dart:developer';
import 'package:ati_ams/animation/fade_animation.dart';
import 'package:ati_ams/config/common_const.dart';
import 'package:ati_ams/model/login_model.dart';
import 'package:ati_ams/pages/home/home_page.dart';
import 'package:ati_ams/services/login_api_service.dart';
import 'package:ati_ams/widgets/custom_button.dart';
import 'package:ati_ams/widgets/custom_progress.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info/device_info.dart';
import 'package:url_launcher/url_launcher.dart';

import 'terms_conditons.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePassword = true;
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  LoginRequestModel loginRequestModel;
  Color loginColor = loginpColor;
  //Color loginColor = Color.fromRGBO(0, 128, 128, 1);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isChecked = false;
  bool isVisibleRememberMe = false;
  String email;
  String policy;
  String phoneModel;
  String osVersion;
  int versionCode;
  bool isLoadingPolicy = true;

  @override
  void initState() {
    super.initState();
    loginRequestModel = new LoginRequestModel();
    getDeviceInfo();
    getSharedPreferenceKey().then((value) {
      policy.toString() == 'null'
          ? Future.delayed(
              Duration.zero,
              () => showDialog(
                context: context,
                builder: (context) => TermsConditions(),
              ),
            )
          : Container();
    });
    getAppVersionCode();
  }

  getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    phoneModel = androidInfo.model.toString();
    osVersion =
        '${androidInfo.version.sdkInt} (${androidInfo.version.release})';
    log('phoneModel: $phoneModel  osVersion: $osVersion');
  }

  getAppVersionCode() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    versionCode = int.parse(packageInfo.buildNumber);
    print('version code: $versionCode');
  }

  Future getSharedPreferenceKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email').toString();
    setState(() {
      policy = prefs.getString('policy');
      isLoadingPolicy = false;
    });
    print('email: $email, policy: $policy');
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  Widget _uiSetup(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      // statusBarColor: Colors.red,
      statusBarBrightness: Brightness.dark,
    ));
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            height: height * 0.52,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: AssetImage('assets/images/login_bg.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: FadeAnimation(
              2.5,
              Container(
                child: Center(
                  // child: Image.asset(
                  //   'assets/images/meditop.png',
                  //   height: 55,
                  // ),
                  child: Text(
                    'Academic Management System',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: width * 0.05,
            // top: height * 0.08,
            width: width * 0.28,
            height: height * 0.25,
            child: FadeAnimation(
              1.7,
              // Container(
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //       // colorFilter:
              //       //     ColorFilter.mode(Colors.white, BlendMode.color),
              //       image: NetworkImage(
              //         'https://i1.rgstatic.net/ii/institution.image/AS%3A473976406319114%401490016189836_l',
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                child: CircleAvatar(
                  // radius: 100,
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 107,
                      height: 102,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: width * 0.05,
            top: height * 0.87,
            child: FadeAnimation(
                3.7,
                Text(
                  'Developed and\nMaintenanced by',
                  textAlign: TextAlign.justify,
                  style:
                      TextStyle(color: loginColor, fontWeight: FontWeight.w500),
                )),
          ),
          Positioned(
            left: width * 0.03,
            top: height * 0.82,
            width: width * 0.30,
            height: height * 0.25,
            child: FadeAnimation(
              3.7,
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/ati.png'),
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: SingleChildScrollView(
              child: Container(
                height: height,
                padding: EdgeInsets.only(bottom: height * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: height * 0.12,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 70.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FadeAnimation(
                            2.7,
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 30.0,
                                  right: 30.0,
                                  top: 10.0,
                                  bottom: 20.0),
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: loginColor.withOpacity(0.3),
                                      blurRadius: 20.0,
                                      offset: Offset(0, 10),
                                    )
                                  ],
                                ),
                                child: Form(
                                  key: globalFormKey,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(7.0),
                                        decoration: BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.grey[100],
                                            ),
                                          ),
                                        ),
                                        child: new TextFormField(
                                          scrollPadding:
                                              EdgeInsets.all(height * 0.26),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          onSaved: (input) =>
                                              loginRequestModel.email = input,
                                          validator: (input) => input.isEmpty? "Enter username" : null,
                                          decoration: new InputDecoration(
                                            hintText: "Username",
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color:
                                                    loginColor.withOpacity(0.0),
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: loginColor,
                                              ),
                                            ),
                                            prefixIcon: Icon(
                                              Icons.email,
                                              color: loginColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(7.0),
                                        child: new TextFormField(
                                          scrollPadding:
                                              EdgeInsets.all(height * 0.41),
                                          //style: TextStyle(color: loginColor),
                                          keyboardType: TextInputType.text,
                                          onSaved: (input) => loginRequestModel.password = input,
                                          validator: (input) => input.length < 4 ? "Password should be at least 4 characters" : null,
                                          obscureText: hidePassword,
                                          onChanged: (value) {
                                            setState(() {
                                              value.length < 4
                                                  ? isVisibleRememberMe = false
                                                  : isVisibleRememberMe = true;
                                            });
                                          },
                                          decoration: new InputDecoration(
                                            hintText: "Password",
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: loginColor.withOpacity(0.2),
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: loginColor),
                                            ),
                                            prefixIcon: Icon(
                                              Icons.lock,
                                              color: loginColor,
                                            ),
                                            suffixIcon: IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  hidePassword = !hidePassword;
                                                });
                                              },
                                              color:
                                                  loginColor.withOpacity(0.4),
                                              icon: Icon(hidePassword ? Icons.visibility_off : Icons.visibility),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          FadeAnimation(
                            3.0,
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 180,
                                    child: CustomButton(
                                      btnText: "Login",
                                      btnColor: loginColor,
                                      onTap: () {
                                        loginRequestModel.appVersionCode = versionCode;
                                        loginRequestModel.deviceModel = phoneModel;
                                        loginRequestModel.osVersion = osVersion;
                                        if (validateAndSave()) {
                                          // print(loginRequestModel.toJson());

                                          setState(() {
                                            isApiCallProcess = true;
                                          });

                                          APIService apiService = new APIService();
                                          apiService.login(loginRequestModel).then((value) async {
                                            if (value.toString().isNotEmpty && value != null && value['success'].toString() == 'true') {
                                              setState(() {
                                                isApiCallProcess = false;
                                              });

                                              SharedPreferences prefs = await SharedPreferences.getInstance();
                                              int pMaverCode = int.parse(value['data']['maver_code'].toString());
                                              // int pMaverCode = 2;
                                              // String stuId = value['data']['user_info']['stu_id'].toString();
                                              String studentId = value['data']['user_info']['student_id'].toString();
                                              String studentName = value['data']['user_info']['students_name'].toString();
                                              String imageUrl = imageBaseUrl + value['data']['student_image']['image_location'].toString();
                                              String signatureUrl = imageBaseUrl + value['data']['students_signature']['signature_location'].toString();
                                              String departmentId = value['data']['user_info']['department'].toString();
                                              String courseType = value['data']['user_info']['course_type'].toString();
                                              String courseNameId = value['data']['user_info']['course_name'].toString();
                                              print('p_maver_code: $pMaverCode');

                                              if (pMaverCode == versionCode) {
                                                //use this in upper if condition "versionCode == pMaverCode"
                                                prefs.setString('email', 'useremail@gmail.com');
                                                prefs.setString('studentId', studentId);
                                                //studentName and imageUrl value will be replaced when edit
                                                prefs.setString('studentName', studentName);
                                                prefs.setString('imageUrl', imageUrl);
                                                prefs.setString('signatureUrl',signatureUrl);
                                                //below values will be sent in the body of calss attendance and events service
                                                prefs.setString('departmentId', departmentId);
                                                prefs.setString('courseType', courseType);
                                                prefs.setString('courseNameId', courseNameId);
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(builder:(BuildContext ctx) =>HomePage()),
                                                );
                                              } else if (pMaverCode > versionCode) {
                                                CoolAlert.show(
                                                    context: context,
                                                    // width: 350,
                                                    type: CoolAlertType.warning,
                                                    text:'Please update the app!');
                                              } else if (pMaverCode < versionCode || pMaverCode == null) {
                                                CoolAlert.show(
                                                    context: context,
                                                    // width: 350,
                                                    type: CoolAlertType.warning,
                                                    text: 'maintenance break. Please wait!');
                                              }
                                              //.......end of comparing version code wih P_MAVERCODE

                                            } else {
                                              setState(() {
                                                isApiCallProcess = false;
                                              });
                                              CoolAlert.show(
                                                  context: context,
                                                  // width: 350,
                                                  type: CoolAlertType.error,
                                                  text: 'Invalid email/password or connectivity problem!');
                                            }
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                  isVisibleRememberMe
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              right: 20.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text('Remember me'),
                                                  Checkbox(
                                                    value: isChecked,
                                                    onChanged: (value) async {
                                                      setState(() {
                                                        isChecked = value;
                                                      });
                                                      SharedPreferences prefs = await SharedPreferences.getInstance();
                                                      isChecked ? prefs.setString('saveUser', 'saved') : prefs.remove('saveUser');
                                                    },
                                                  ),
                                                ],
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  const url ='https://www.atilimited.net/';
                                                  if (await canLaunch(url)) {
                                                    await launch(url);
                                                  } else {
                                                    throw 'Could not launch $url';
                                                  }
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'https://www.atilimited.net/',
                                                    textAlign: TextAlign.justify,
                                                    style: TextStyle( color: cViolet, fontWeight: FontWeight.w500),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
