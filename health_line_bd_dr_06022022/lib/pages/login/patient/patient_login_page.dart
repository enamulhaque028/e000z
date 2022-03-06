import 'dart:developer';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_line_bd/animation/fade_animation.dart';
import 'package:health_line_bd/config/common_const.dart';
import 'package:health_line_bd/model/lis/login_model.dart';
import 'package:health_line_bd/pages/navbar_patient/bottom_navbar_patient.dart';
import 'package:health_line_bd/services/lis/login_api_service.dart';
import 'package:health_line_bd/widgets/custom_button.dart';
import 'package:health_line_bd/widgets/custom_progress.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info/device_info.dart';

class PatientLoginPage extends StatefulWidget {
  @override
  _PatientLoginPageState createState() => _PatientLoginPageState();
}

class _PatientLoginPageState extends State<PatientLoginPage> {
  bool hidePassword = true;
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  LoginRequestModelLIS loginRequestModel;
  Color loginColor = cViolet;
  //Color loginColor = Color.fromRGBO(0, 128, 128, 1);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool hasFingerPrint;
  bool isChecked = false;
  bool isVisibleRememberMe = false;
  String email;
  String otp;
  String workPlace;
  String phoneModel;
  String osVersion;
  int versionCode;
  String fcmToken;

  @override
  void initState() {
    super.initState();
    loginRequestModel = new LoginRequestModelLIS();
    getDeviceInfo();
    getSharedPreferenceKey();
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

  getSharedPreferenceKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email').toString();
    otp = prefs.getString('otp').toString();
    workPlace = prefs.getString('workPlace').toString();
    print('email: $email otp: $otp, workplace: $workPlace');
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
            //left: width * 0.09,
            top: height * 0.08,
            child: Container(
              padding: EdgeInsets.only(left: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   'CMH',
                  //   style: TextStyle(
                  //     fontSize: 40,
                  //     color: cViolet,
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      workPlace.toString() == 'null'
                          ? ''
                          : workPlace.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        color: cViolet.withOpacity(0.6),
                      ),
                    ),
                  ),
                ],
              ),
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
                                            loginRequestModel.email = input,
                                        validator: (input) => input.length < 4
                                            ? "Enter correct ID"
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
                                            loginRequestModel.password = input,
                                        validator: (input) => input.length < 4
                                            ? "Password should be at least 4 characters"
                                            : null,
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
                                      loginRequestModel.appVersionCode =
                                          versionCode;
                                      loginRequestModel.deviceModel =
                                          phoneModel;
                                      loginRequestModel.osVersion = osVersion;
                                      loginRequestModel.fcmToken = fcmToken;
                                      if (validateAndSave()) {
                                        print(loginRequestModel.toJson());

                                        setState(() {
                                          isApiCallProcess = true;
                                        });

                                        APIService apiService =
                                            new APIService();
                                        apiService
                                            .lisLogin(loginRequestModel)
                                            .then((value) async {
                                          if (value.toString().isNotEmpty &&
                                              value != null &&
                                              value['P_RETURNMSG0']
                                                      .toString() ==
                                                  'true') {
                                            setState(() {
                                              isApiCallProcess = false;
                                            });
                                            // print(value['DETAILS'][0]
                                            //         ['appversioncode']
                                            //     .toString());
                                            //String userPhoto = value['user_photo'];
                                            // String userCode = value['details']
                                            //         ['SAUSERS_ID']
                                            //     .toString();
                                            // String clientsId = value['details']
                                            //         ['CLIENTS_ID']
                                            //     .toString();
                                            // String userName = value['details']
                                            //         ['USRS_FNAME']
                                            //     .toString();
                                            String workPlace =
                                                value['P_RETURNMSG3'][0]
                                                        ['workplace']
                                                    .toString();
                                            String mobileNo =
                                                value['P_RETURNMSG1'][0]
                                                        ['pmobile_no']
                                                    .toString();
                                            String patientId =
                                                value['P_RETURNMSG1'][0]
                                                        ['patient_id']
                                                    .toString();
                                            String parentId =
                                                value['P_RETURNMSG1'][0]
                                                        ['patient_id']
                                                    .toString();

                                            SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();
                                            prefs.setString(
                                                'workPlace', workPlace);
                                            prefs.setString(
                                                'mobileNo', mobileNo);
                                            prefs.setString(
                                                'patientId', patientId);
                                            prefs.setString(
                                                'parentId', parentId);
                                            // prefs.setString(
                                            //     'userCode', userCode);
                                            // prefs.setString(
                                            //     'clientsId', clientsId);
                                            // prefs.setString(
                                            //     'userName', userName);

                                            //.......start of comparing version code wih P_MAVERCODE

                                            int pMaverCode = int.parse(
                                                value['P_RETURNMSG3'][0]
                                                        ['p_maver_code']
                                                    .toString());
                                            print('P_MAVERCODE: $pMaverCode');
                                            // int pMaverCode = 40;

                                            if (pMaverCode == 12) {
                                              //use this in upper if condition "versionCode == pMaverCode"
                                              prefs.setString('email',
                                                  'useremail@gmail.com');
                                              Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      BottomNavBarPatient(),
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
                        (email.toString() == 'null' || otp.toString() == 'null')
                            ? FadeAnimation(
                                3.5,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(''),
                                    Container(
                                      padding: EdgeInsets.only(
                                          right: 30.0, top: 30.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            'Need an account?',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              // //resetting dropdown selection value
                                              // SelectGender.mySelection = null;
                                              // SelectMaritialStatus.mySelection =
                                              //     null;
                                              // SelectBloodGroup.mySelection =
                                              //     null;
                                              // SelectRank.mySelection = null;
                                              // SelectReligion.mySelection = null;
                                              // SelectWorkplace.mySelection =
                                              //     null;
                                              // SelectCountry.mySelection = null;
                                              // SelectServiceType.mySelection =
                                              //     null;
                                              // // PickImages.base64Image = '';
                                              // // SelectDepartment.dropdownValue =
                                              // //     null;
                                              // ServiceRadioButton.groupValue =
                                              //     -1;
                                              // DefenseRadioButton.groupValue =
                                              //     -1;
                                              // nameFromOcr.value = 'Hi';
                                              // nidFromOcr.value = 'Hi';
                                              // dobFromOcr.value = 'Hi';
                                              // ImageUploadService
                                              //     .fileDownloadUrl = '';
                                              // ImageUploadService
                                              //     .nidDownloadUrl = '';
                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //     builder: (context) =>
                                              //         // OTPVerification(
                                              //         //     navigateWidget:
                                              //         //         RegistrationPage()),
                                              //         RegistrationPage(),
                                              //   ),
                                              // );
                                            },
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
                              )
                            : Container(),
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
