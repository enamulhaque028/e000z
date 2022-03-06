// import 'package:dil_app/api/email_service.dart';
import 'dart:developer';
import 'package:cool_alert/cool_alert.dart';
import 'package:dil_app/api/account_service.dart';
import 'package:dil_app/config/common_const.dart';
import 'package:dil_app/pages/account/view/textfield.dart';
import 'package:dil_app/pages/chart/chart.dart';
import 'package:dil_app/pages/login/Animation/FadeAnimation.dart';
import 'package:dil_app/pages/login/custom_progress/ProgressHUD.dart';
import 'package:dil_app/pages/ticketing/help/submit_issue/image_picker/image_picker.dart';
import 'package:dil_app/pages/ticketing/help/submit_issue/select_client/select_client.dart';
import 'package:dil_app/pages/ticketing/help/submit_issue/select_project/select_project.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  Map ticketListdropdown;
  bool _loading = true;
  bool isApiCallProcess = false;
  bool _autoValidate = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _mobileNoController = new TextEditingController();
  TextEditingController _deptNameController = new TextEditingController();
  TextEditingController _designationNameController =
      new TextEditingController();

  serviceMethod() async {
    String extUrl = 'ticket-lookup';
    Uri url = Uri.parse(baseUrl + extUrl);
    //var url = "http://203.130.133.166/ATI-ERP2/ticket-lookup";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var saUserID = prefs.getString('saUserID');
    var employeeId = prefs.getString('employeeId') == "null"
        ? ""
        : prefs.getString('employeeId');
    var acpInfoID = prefs.getString('acpInfoID') == "null"
        ? ""
        : prefs.getString('acpInfoID');

    Map data = {
      "SAUSERS_ID": saUserID,
      "EMPLOYE_ID": employeeId,
      "ACPINFO_ID": acpInfoID,
    };
    var body = json.encode(data);
    final response = await http.post(url, body: body);
    final responseJson = json.decode(response.body);
    print(responseJson);
    print(response.statusCode);

    if (response.statusCode == 200) {
      setState(() {
        _loading = false;
        ticketListdropdown = json.decode(response.body)[0];
        //_selectProjectInfo = ticketListdropdown['clientInfos'][0];
        log('length of clientInfos list: ${ticketListdropdown['clientInfos'].length.toString()}');
        log('CLIENTS_ID[0]: ${ticketListdropdown['clientInfos'][0]['CLIENTS_ID'].toString()}');
      });
    } else {
      setState(() {
        _loading = false;
      });
      throw Exception('Failed to load internet');
    }
  }

  @override
  void initState() {
    PickImages.base64ImageList = [];
    super.initState();
    serviceMethod();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request for Account'),
        brightness: Brightness.dark,
        backgroundColor: Color(PrimaryColor),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(left: 10, right: 10),
        color: Colors.white,
        child: _loading && ticketListdropdown == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ticketListdropdown == null
                ? ListTile(
                    title: Text('Internet not available or Nothing found !'),
                  )
                : ProgressHUD(
                    inAsyncCall: isApiCallProcess,
                    opacity: 0.3,
                    child: Scaffold(
                      key: scaffoldKey,
                      body: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          // ignore: deprecated_member_use
                          autovalidate: _autoValidate,
                          child: Container(
                            decoration: BoxDecoration(
                                //color: Colors.transparent,
                                ),
                            margin: EdgeInsets.only(
                              bottom: 30,
                            ),
                            padding: EdgeInsets.only(
                              top: 10,
                              //left: 10,
                              bottom: 30,
                            ),
                            child: Column(
                              children: <Widget>[
                                //checking length of clients. if there is 1 client, dropdown is not shown otherwise not shown
                                ticketListdropdown['clientInfos'].length > 1
                                    ? FadeAnimation(
                                        1.2,
                                        SelectClient(
                                          clientListdropdown:
                                              ticketListdropdown,
                                        ),
                                      )
                                    : Container(), //end checking of clients length
                                ticketListdropdown['projectInfos'].length > 1
                                    ? FadeAnimation(
                                        1.7,
                                        SelectProject(
                                          projectListdropdown:
                                              ticketListdropdown,
                                        ),
                                      )
                                    : SelectedProjectView(
                                        projectName:
                                            ticketListdropdown['projectInfos']
                                                    [0]['PROJT_NAME']
                                                .toString(),
                                      ),
                                FadeAnimation(
                                  2.4,
                                  TextFieldWidget(
                                    textFieldController: _nameController,
                                    labelText: 'Enter Name',
                                  ),
                                ),
                                FadeAnimation(
                                  2.6,
                                  TextFieldWidget(
                                    textFieldController: _emailController,
                                    labelText: 'Enter Email',
                                  ),
                                ),
                                FadeAnimation(
                                  2.8,
                                  TextFieldWidget(
                                    textFieldController: _mobileNoController,
                                    labelText: 'Enter Mobile Number',
                                  ),
                                ),
                                FadeAnimation(
                                  3.0,
                                  TextFieldWidget(
                                    textFieldController: _deptNameController,
                                    labelText: 'Enter Department',
                                  ),
                                ),
                                FadeAnimation(
                                  3.2,
                                  TextFieldWidget(
                                    textFieldController:
                                        _designationNameController,
                                    labelText: 'Enter Designation',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      floatingActionButton: FloatingActionButton(
                        child: Icon(Icons.send),
                        backgroundColor: Color(PrimaryColor),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              isApiCallProcess = true;
                            });
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            String userCode =
                                prefs.getString('userCode').toString();
                            String clientName =
                                ticketListdropdown['clientInfos'].length > 1
                                    ? SelectClient.mySelection['CLINT_NAME']
                                        .toString()
                                    : ticketListdropdown['clientInfos'][0]
                                            ['CLINT_NAME']
                                        .toString();
                            String clientID =
                                ticketListdropdown['clientInfos'].length > 1
                                    ? SelectClient.mySelection['CLIENTS_ID']
                                        .toString()
                                    : ticketListdropdown['clientInfos'][0]
                                            ['CLIENTS_ID']
                                        .toString();
                            String projectName =
                                ticketListdropdown['projectInfos'].length > 1
                                    ? SelectProject.mySelection['PROJT_NAME']
                                        .toString()
                                    : ticketListdropdown['projectInfos'][0]
                                            ['PROJT_NAME']
                                        .toString();
                            String projectID =
                                ticketListdropdown['projectInfos'].length > 1
                                    ? SelectProject.mySelection['PROJECT_ID']
                                        .toString()
                                    : ticketListdropdown['projectInfos'][0]
                                            ['PROJECT_ID']
                                        .toString();
                            setState(() {
                              AccountService()
                                  .createAccount(
                                userCode: userCode,
                                clientName: clientName,
                                clientID: clientID,
                                projectName: projectName,
                                projectID: projectID,
                                name: _nameController.text,
                                email: _emailController.text,
                                mobileNo: _mobileNoController.text,
                                deptName: _deptNameController.text,
                                designationName:
                                    _designationNameController.text,
                              )
                                  .then((value) async {
                                if (value['success'].toString() == 'true') {
                                  setState(() {
                                    isApiCallProcess = false;
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChartPage()));
                                  CoolAlert.show(
                                    context: context,
                                    // width: 350,
                                    type: CoolAlertType.success,
                                    text: "Request Submitted successfully",
                                  );
                                  // String cticketId = value.ticketId;
                                  // print(cticketId);
                                  // sendEmail(cticketId.toString()); //send email
                                } else {
                                  setState(() {
                                    isApiCallProcess = false;
                                  });
                                  final snackBar = SnackBar(
                                    content: Text(
                                        'Connectivity problem! Try again...'),
                                  );
                                  scaffoldKey.currentState
                                      // ignore: deprecated_member_use
                                      .showSnackBar(snackBar);
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                }
                              });
                            });
                            _formKey.currentState.save();
                          } else {
                            setState(() {
                              _autoValidate = true;
                            });
                          }
                        },
                      ),
                    ),
                  ),
      ),
    );
  }
}
