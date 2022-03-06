import 'dart:developer';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_line_bd/animation/fade_animation.dart';
import 'package:health_line_bd/config/common_const.dart';
import 'package:health_line_bd/model/lis/login_model.dart';
import 'package:health_line_bd/pages/navbar_doctor/bottom_navbar_doctor.dart';
import 'package:health_line_bd/services/lis/login_api_service.dart';
import 'package:health_line_bd/widgets/custom_button.dart';
import 'package:health_line_bd/widgets/custom_progress.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info/device_info.dart';

class DoctorLoginPage extends StatefulWidget {
  @override
  _DoctorLoginPageState createState() => _DoctorLoginPageState();
}

class _DoctorLoginPageState extends State<DoctorLoginPage> {
  bool hidePassword = true;
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  LoginRequestModel loginRequestModel;
  Color loginColor = cViolet;
  //Color loginColor = Color.fromRGBO(0, 128, 128, 1);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool isChecked = false;
  bool isVisibleRememberMe = false;
  String phoneModel;
  String androidApiLvl;
  String androidVersion;
  String manufacture;
  int versionCode;
  String fcmToken;

  @override
  void initState() {
    super.initState();
    loginRequestModel = new LoginRequestModel();
    getDeviceInfo();
    getAppVersionCode();
  }

  getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    phoneModel = androidInfo.model.toString();
    manufacture = androidInfo.manufacturer.toString();
    androidApiLvl = '${androidInfo.version.sdkInt}';
    androidVersion = '${androidInfo.version.release}';
    log('phoneModel: $phoneModel  androidApiLvl: $androidApiLvl');
  }

  getAppVersionCode() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    versionCode = int.parse(packageInfo.buildNumber);
    print('version code: $versionCode');
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
            decoration: new BoxDecoration(
              image: new DecorationImage(
                  image: AssetImage('assets/images/login.png'),
                  fit: BoxFit.fill),
            ),
          ),
          Positioned(
            right: width * 0.07,
            top: height * 0.05,
            // width: width * 0.22,
            // height: height * 0.25,
            child: FadeAnimation(
              1.7,
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 50,
                backgroundImage: AssetImage('assets/images/logo.png'),
              ),
            ),
          ),
          Positioned(
            left: width * 0.06,
            top: height * 0.92,
            child: FadeAnimation(
                3.7,
                Text(
                  'Developed by',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                )),
          ),
          Positioned(
            left: width * 0.03,
            top: height * 0.85,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height * 0.12,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FadeAnimation(
                          2.5,
                          Container(
                            child: Center(
                              // child: Image.asset(
                              //   'assets/images/meditop.png',
                              //   height: 55,
                              // ),
                              child: Text(
                                'Health Line BD',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                  color: cViolet,
                                ),
                              ),
                            ),
                          ),
                        ),
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
                                            loginRequestModel.mobileNo = input,
                                        validator: (input) => input.length < 11
                                            ? "Enter correct number"
                                            : null,
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
                                        onSaved: (input) =>
                                            loginRequestModel.userPass = input,
                                        validator: (input) => input.length < 3
                                            ? "Password should be at least 3 characters"
                                            : null,
                                        obscureText: hidePassword,
                                        onChanged: (value) {
                                          setState(() {
                                            value.length < 3
                                                ? isVisibleRememberMe = false
                                                : isVisibleRememberMe = true;
                                          });
                                        },
                                        decoration: new InputDecoration(
                                          hintText: "Password",
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                              color:
                                                  loginColor.withOpacity(0.2),
                                            ),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: loginColor),
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
                                            color: loginColor.withOpacity(0.4),
                                            icon: Icon(hidePassword
                                                ? Icons.visibility_off
                                                : Icons.visibility),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 180,
                                  child: CustomButton(
                                    btnText: "Login",
                                    btnColor: loginColor,
                                    onTap: () {
                                      loginRequestModel.androidApiLvl =
                                          int.parse(androidApiLvl);
                                      loginRequestModel.androidVersion =
                                          androidVersion;
                                      loginRequestModel.manufacture =
                                          manufacture;
                                      loginRequestModel.phoneModel = phoneModel;
                                      loginRequestModel.fcmToken = fcmToken;
                                      if (validateAndSave()) {
                                        print(loginRequestModel.toJson());

                                        setState(() {
                                          isApiCallProcess = true;
                                        });

                                        APIService apiService =
                                            new APIService();
                                        apiService
                                            .login(loginRequestModel)
                                            .then((value) async {
                                          if (value['message'].toString() ==
                                              'Login Successful') {
                                            setState(() {
                                              isApiCallProcess = false;
                                            });
                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();

                                            //.......start of comparing version code wih P_MAVERCODE
                                            int pMaverCode = int.parse(
                                                value['objResponse']
                                                        ['userAppVersion']
                                                    .toString());
                                            print('P_MAVERCODE: $pMaverCode');
                                            // int pMaverCode = 40;

                                            if (pMaverCode == 22) {
                                              //use this in upper if condition "versionCode == pMaverCode"
                                              prefs.setString('email',
                                                  'useremail@gmail.com');
                                              Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      BottomNavBarDoctor(),
                                                ),
                                                (route) => false,
                                              );
                                            } else if (pMaverCode >
                                                versionCode) {
                                              CoolAlert.show(
                                                  context: context,
                                                  // width: 350,
                                                  type: CoolAlertType.warning,
                                                  text:
                                                      'Please update the app!');
                                            } else if (pMaverCode <
                                                    versionCode ||
                                                pMaverCode == null) {
                                              CoolAlert.show(
                                                  context: context,
                                                  // width: 350,
                                                  type: CoolAlertType.warning,
                                                  text:
                                                      'maintenance break. Please wait!');
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
                                                text:
                                                    'Invalid email/password or connectivity problem!');
                                          }
                                        });
                                      }
                                    },
                                  ),
                                ),
                                isVisibleRememberMe
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20.0),
                                        child: Row(
                                          children: [
                                            Text('Remember me'),
                                            Checkbox(
                                              value: isChecked,
                                              onChanged: (value) async {
                                                setState(() {
                                                  isChecked = value;
                                                });
                                                SharedPreferences prefs =
                                                    await SharedPreferences
                                                        .getInstance();
                                                isChecked
                                                    ? prefs.setString(
                                                        'saveUser', 'saved')
                                                    : prefs.remove('saveUser');
                                              },
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ),
                        FadeAnimation(
                          3.5,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(''),
                              Container(
                                padding:
                                    EdgeInsets.only(right: 30.0, top: 30.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Need an account?',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: Text('Sign Up'),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.green),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
