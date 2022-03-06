// import 'package:dil_app/api/client_info_service.dart';
// import 'package:dil_app/api/db/db_provider.dart';
import 'dart:developer';
import 'package:cool_alert/cool_alert.dart';
import 'package:dil_app/api/db/notification_provider.dart';
import 'package:dil_app/api/login_api_service.dart';
import 'package:dil_app/config/fcm_utils.dart';
import 'package:dil_app/config/sp_utils.dart';
import 'package:dil_app/model/login_model.dart';
import 'package:dil_app/pages/chart/chart.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Animation/FadeAnimation.dart';
import 'custom_progress/ProgressHUD.dart';
import 'package:store_redirect/store_redirect.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePassword = true;
  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  LoginRequestModel loginRequestModel;
  Color loginColor = Color.fromRGBO(157, 12, 12, 1);
  //Color loginColor = Color.fromRGBO(0, 128, 128, 1);
  final scaffoldKey = GlobalKey<ScaffoldState>();
  String fcmToken = '';
  String fcmTitle = '';
  @override
  void initState() {
    super.initState();
    loginRequestModel = new LoginRequestModel();
    getFirebaseToken();
    foregroundMode();
    backgroundMode();
  }

  getFirebaseToken() async {
    fcmToken = await FirebaseMessaging.instance.getToken();
    log('Token: $fcmToken');
  }

  NotificationDBProvider dbProvider = NotificationDBProvider();

  String getNotificationDate() {
    DateTime now = DateTime.now();
    String notificationDate = now.day.toString() +
        "-" +
        now.month.toString() +
        "-" +
        now.year.toString() +
        " " +
        now.hour.toString() +
        ":" +
        now.minute.toString();
    return notificationDate;
  }

  foregroundMode() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        log(notification.title);
        log(message.from);
        setState(() {
          fcmTitle = notification.title;
        });
        dbProvider.addToNotificationData(
            notification.title, notification.body, getNotificationDate());
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body)],
                  ),
                ),
              );
            });
      }
    });
  }

  //works when app is in background mode and user taps on the notification
  backgroundMode() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        log(notification.body);
        setState(() {
          fcmTitle = notification.title;
        });
        dbProvider.addToNotificationData(
            notification.title, notification.body, getNotificationDate());
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body)],
                  ),
                ),
              );
            });
      }
    });
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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: height * 0.52,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: width * 0.09,
                      width: width * 0.22,
                      height: height * 0.32,
                      child: FadeAnimation(
                        1.2,
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/light-1.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: width * 0.39,
                      width: width * 0.22,
                      height: height * 0.25,
                      child: FadeAnimation(
                        1.5,
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/light-2.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 40,
                      top: 40,
                      width: 80,
                      height: height * 0.25,
                      child: FadeAnimation(
                        1.7,
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/clock.png'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: FadeAnimation(
                        1.9,
                        Container(
                          margin: EdgeInsets.only(top: 100),
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    FadeAnimation(
                        2.5,
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(157, 12, 12, .2),
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
                                  padding: EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey[100],
                                      ),
                                    ),
                                  ),
                                  child: new TextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    onSaved: (input) =>
                                        loginRequestModel.email = input,
                                    // validator: (input) => !input.contains('@')
                                    //     ? "Email Id should be valid"
                                    //     : null,
                                    decoration: new InputDecoration(
                                      hintText: "Email Address",
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: loginColor.withOpacity(0.0),
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
                                  padding: EdgeInsets.all(8.0),
                                  child: new TextFormField(
                                    //style: TextStyle(color: loginColor),
                                    keyboardType: TextInputType.text,
                                    onSaved: (input) =>
                                        loginRequestModel.password = input,
                                    validator: (input) => input.length < 3
                                        ? "Password should be at least 6 characters"
                                        : null,
                                    obscureText: hidePassword,
                                    decoration: new InputDecoration(
                                      hintText: "Password",
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: loginColor.withOpacity(0.2),
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
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    FadeAnimation(
                      2.9,
                      InkWell(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                Color.fromRGBO(157, 12, 12, 1),
                                Color.fromRGBO(157, 12, 12, .6),
                              ],
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          loginRequestModel.fcmRegId = fcmToken;
                          if (validateAndSave()) {
                            print(loginRequestModel.toJson());

                            setState(() {
                              isApiCallProcess = true;
                            });

                            APIService apiService = new APIService();
                            apiService
                                .login(loginRequestModel)
                                .then((value) async {
                              if (value.toString().isNotEmpty &&
                                  value != null) {
                                setState(() {
                                  isApiCallProcess = false;
                                });
                                //String userPhoto = value['user_photo'];
                                String userCode =
                                    value['details']['SAUSERS_ID'].toString();
                                String clientsId =
                                    value['details']['CLIENTS_ID'].toString();
                                String userName =
                                    value['details']['USRS_FNAME'].toString();

                                String companyId =
                                    value['details']['COMPANY_ID'].toString();
                                String cBranchId =
                                    value['details']['CBRANCH_ID'].toString();
                                String cobUnitId =
                                    value['details']['COBUNIT_ID'].toString();
                                String ptgUnitId =
                                    value['details']['PTGUNIT_ID'].toString();
                                //print(LoginPage.userCode);

                                String saUserID =
                                    value['details']['SAUSERS_ID'].toString();
                                String employeeId =
                                    value['details']['EMPLOYE_ID'].toString();
                                String acpInfoID =
                                    value['details']['ACPINFO_ID'].toString();
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setString('userCode', userCode);
                                prefs.setString('clientsId', clientsId);
                                prefs.setString('userName', userName);

                                prefs.setString('saUserID', saUserID);
                                prefs.setString('employeeId', employeeId);
                                prefs.setString('acpInfoID', acpInfoID);
                                //prefs.setString('userPhoto', userPhoto);

                                SharedPref().setCompanyId(companyId);
                                SharedPref().setCBranchId(cBranchId);
                                SharedPref().setCobUnitId(cobUnitId);
                                SharedPref().setPtgUnitId(ptgUnitId);

                                //........start of comparing version code wih P_MAVERCODE........
                                PackageInfo packageInfo =
                                    await PackageInfo.fromPlatform();
                                int versionCode =
                                    int.parse(packageInfo.buildNumber);
                                print('version code: $versionCode');
                                int pMaverCode = int.parse(
                                    value['user_details']['P_MAVERCODE']);
                                print('P_MAVERCODE: $pMaverCode');

                                if (pMaverCode == versionCode) {
                                  //use this in upper if condition "versionCode == pMaverCode"
                                  prefs.setString(
                                      'email', 'useremail@gmail.com');
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext ctx) =>
                                          ChartPage(),
                                    ),
                                  );
                                } else if (pMaverCode > versionCode) {
                                  CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.warning,
                                      text: 'Please update the app!',
                                      confirmBtnText: 'Update',
                                      showCancelBtn: true,
                                      onConfirmBtnTap: () {
                                        StoreRedirect.redirect(
                                            androidAppId: "com.ati.snm");
                                      });
                                } else if (pMaverCode < versionCode ||
                                    pMaverCode == null) {
                                  CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.warning,
                                    text: 'maintenance break. Please wait!',
                                  );
                                }
                                //.......end of comparing version code wih P_MAVERCODE........
                              } else {
                                setState(() {
                                  isApiCallProcess = false;
                                });
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.warning,
                                  text:
                                      'Invalid email/password or connectivity problem!',
                                );
                              }
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
