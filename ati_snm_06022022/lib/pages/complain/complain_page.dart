import 'package:dil_app/api/user_review_service.dart';
import 'package:dil_app/pages/complain/components/bottom_container.dart';
import 'package:dil_app/pages/complain/components/complaint_page_fields.dart';
import 'package:dil_app/pages/login/custom_progress/ProgressHUD.dart';
import 'package:flutter/material.dart';
import 'components/background_design.dart';

class ComplainPage extends StatefulWidget {
  const ComplainPage({Key key}) : super(key: key);

  @override
  _ComplainPageState createState() => _ComplainPageState();
}

class _ComplainPageState extends State<ComplainPage> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool isApiCallProcess = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _issueDescController = new TextEditingController();
  TextEditingController _issueTitleController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ProgressHUD(
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            // ignore: deprecated_member_use
            autovalidate: _autoValidate,
            child: Container(
              width: size.width,
              height: size.height,
              child: Stack(
                children: [
                  BackgroundDesign(),
                  ComplaintPageFields(
                    issueTitleController: _issueTitleController,
                    issueDescController: _issueDescController,
                  ),
                  BottomContainer(
                    onTap: () {
                      print(_issueTitleController.text);
                      print(_issueDescController.text);
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          isApiCallProcess = true;
                        });
                        setState(() {
                          UserReviewService().sendUserReview(
                            title: _issueTitleController.text,
                            description: _issueDescController.text,
                            type: 'C',
                          );
                          //     .then((value) async {
                          //   if (value['success'].toString() == 'true') {
                          //     setState(() {
                          //       isApiCallProcess = false;
                          //     });
                          //     Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (context) => ChartPage()));
                          //     CoolAlert.show(
                          //       context: context,
                          //       // width: 350,
                          //       type: CoolAlertType.success,
                          //       text: "Request Submitted successfully",
                          //     );
                          //     // String cticketId = value.ticketId;
                          //     // print(cticketId);
                          //     // sendEmail(cticketId.toString()); //send email
                          //   } else {
                          //     setState(() {
                          //       isApiCallProcess = false;
                          //     });
                          //     final snackBar = SnackBar(
                          //       content: Text(
                          //           'Connectivity problem! Try again...'),
                          //     );
                          //     scaffoldKey.currentState
                          //         // ignore: deprecated_member_use
                          //         .showSnackBar(snackBar);
                          //     FocusScope.of(context)
                          //         .requestFocus(FocusNode());
                          //   }
                          // });
                        });
                        _formKey.currentState.save();
                      } else {
                        setState(() {
                          _autoValidate = true;
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
