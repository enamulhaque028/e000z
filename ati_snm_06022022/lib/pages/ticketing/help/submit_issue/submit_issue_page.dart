// import 'package:dil_app/api/email_service.dart';
import 'dart:developer';
import 'package:cool_alert/cool_alert.dart';
import 'package:dil_app/api/ticket_post_service.dart';
import 'package:dil_app/config/common_const.dart';
import 'package:dil_app/pages/chart/chart.dart';
import 'package:dil_app/pages/login/Animation/FadeAnimation.dart';
import 'package:dil_app/pages/login/custom_progress/ProgressHUD.dart';
import 'package:dil_app/pages/ticketing/help/submit_issue/image_picker/image_picker.dart';
import 'package:dil_app/pages/ticketing/help/submit_issue/select_checkbox/select_checkbox.dart';
import 'package:dil_app/pages/ticketing/help/submit_issue/select_project/select_project.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'issue_desc/issue_desc.dart';
import 'select_client/select_client.dart';
import 'select_ticket_priority/select_ticket_priority.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AddIssue extends StatefulWidget {
  @override
  _AddIssueState createState() => _AddIssueState();
}

class _AddIssueState extends State<AddIssue> {
  Map ticketListdropdown;
  bool _loading = true;
  bool isApiCallProcess = false;
  bool _autoValidate = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _issueDescController = new TextEditingController();
  TextEditingController _issueTitleController = new TextEditingController();

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
        title: Text('Add New Ticket'),
        brightness: Brightness.dark,
        backgroundColor: Color(PrimaryColor),
        leading: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ChartPage()));
          },
          child: Icon(Icons.arrow_back),
        ),
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
                ? ListTile(title: Text('Internet not available or Nothing found !'),)
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
                            margin: EdgeInsets.only(bottom: 30,),
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
                                          clientListdropdown: ticketListdropdown,
                                        ),
                                      )
                                    : Container(), //end checking of clients length
                                ticketListdropdown['projectInfos'].length > 1
                                    ? FadeAnimation(
                                        1.7,
                                        SelectProject(
                                          projectListdropdown: ticketListdropdown,
                                        ),
                                      )
                                    : SelectedProjectView(
                                        projectName: ticketListdropdown['projectInfos'][0]['PROJT_NAME'].toString(),
                                      ),
                                FadeAnimation(
                                  2.4,
                                  CheckBoxIssueTitle(
                                    ticketTitleListdropdown: ticketListdropdown,
                                    issueTitleController: _issueTitleController,
                                  ),
                                ),
                                FadeAnimation(
                                  3.8,
                                  IssueDescription(
                                    issueDescController: _issueDescController,
                                  ),
                                ),
                                FadeAnimation(
                                  4.5,
                                  SelectTicketPriority(tPriorityListdropdown: ticketListdropdown),
                                ),
                                FadeAnimation(
                                  5.2,
                                  PickImages(),
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
                            setState(() {
                              createTicket(
                                _issueDescController.text,
                                _issueTitleController.text,
                                ticketListdropdown['projectInfos'].length > 1 ? SelectProject.mySelection['PROJT_NAME'].toString() : ticketListdropdown['projectInfos'][0]['PROJT_NAME'].toString(),
                                ticketListdropdown['projectInfos'].length > 1 ? SelectProject.mySelection['PROJECT_ID'].toString() : ticketListdropdown['projectInfos'][0]['PROJECT_ID'].toString(),
                                // SelectClient.mySelection['CLIENTS_ID']
                                //     .toString(),
                                // SelectClient.mySelection['COMPANY_ID']
                                //     .toString(),

                                //get and send "CLIENTS_ID" by length checking
                                ticketListdropdown['clientInfos'].length > 1 ? SelectClient.mySelection['CLIENTS_ID'].toString() : ticketListdropdown['clientInfos'][0]['CLIENTS_ID'].toString(), //end of checking

                                //get and send "COMPANY_ID" by length checking
                                ticketListdropdown['clientInfos'].length > 1 ? SelectClient.mySelection['COMPANY_ID'].toString() : ticketListdropdown['clientInfos'][0]['COMPANY_ID'].toString(), //end of checking
                                SelectTicketPriority.mySelection['TKT_PRI_ID'].toString(),
                                CheckBoxIssueTitle.isChecked == true ? CheckBoxIssueTitle.mySelection['CTICKET_ID'].toString() : '0',
                                PickImages.base64ImageList,
                                SelectTicketPriority.criticalCommentController.text,
                              ).then((value) async {
                                if (value['status'].toString() == 'true') {
                                  setState(() {
                                    isApiCallProcess = false;
                                  });
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => ChartPage()),
                                  );
                                  CoolAlert.show(
                                    context: context,
                                    // width: 350,
                                    type: CoolAlertType.success,
                                    text: "Your ticket no is: ${value['data']}",
                                  );
                                  // String cticketId = value.ticketId;
                                  // print(cticketId);
                                  // sendEmail(cticketId.toString()); //send email
                                } else {
                                  setState(() {
                                    isApiCallProcess = false;
                                  });
                                  CoolAlert.show(
                                    context: context,
                                    // width: 350,
                                    type: CoolAlertType.success,
                                    text: 'Connectivity problem! Try again...',
                                  );
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
