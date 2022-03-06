import 'package:cool_alert/cool_alert.dart';
import 'package:dil_app/api/user_review_service.dart';
import 'package:dil_app/pages/chart/chart.dart';
import 'package:dil_app/pages/login/custom_progress/ProgressHUD.dart';
import 'package:flutter/material.dart';

class RecommendationPage extends StatefulWidget {
  const RecommendationPage({Key key}) : super(key: key);

  @override
  _RecommendationPageState createState() => _RecommendationPageState();
}

class _RecommendationPageState extends State<RecommendationPage> {
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool isApiCallProcess = false;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _issueDescController = new TextEditingController();
  TextEditingController _issueTitleController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
      child: Scaffold(
        backgroundColor: Color(0xFFf6edf7),
        appBar: AppBar(
          brightness: Brightness.dark,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
          ),
          backgroundColor: Color(0xFFf6edf7),
          elevation: 0.0,
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                // ignore: deprecated_member_use
                autovalidate: _autoValidate,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(),
                          Image.asset(
                            'assets/images/idea.png',
                            height: 100,
                            width: 100,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'We are ready to hear from you!',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _issueTitleController,
                          onFieldSubmitted: (String value) {
                            setState(() {
                              _issueTitleController.text = value;
                            });
                          },
                          validator: (value) =>
                              value.isEmpty ? '     Field is required' : null,
                          decoration: new InputDecoration(
                            enabledBorder: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: new BorderSide(color: Colors.green),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            errorBorder: new OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: new BorderSide(color: Colors.red),
                            ),
                            labelText: "Input your suggestion title",
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          height: 150,
                          child: TextFormField(
                            controller: _issueDescController,
                            onFieldSubmitted: (String value) {
                              setState(() {
                                _issueDescController.text = value;
                              });
                            },
                            validator: (value) =>
                                value.isEmpty ? '     Field is required' : null,
                            maxLines: 50,
                            decoration: new InputDecoration(
                              enabledBorder: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: new BorderSide(color: Colors.green),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.green),
                              ),
                              errorBorder: new OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: new BorderSide(color: Colors.red),
                              ),
                              labelText: "Input your suggestion in details",
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'N.B: Your suggestion will be cofedential and anonymous. We assure that it will not be disclosed or shared anywhere.',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.red.withOpacity(0.6),
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 24),
                        MaterialButton(
                          height: 55,
                          // minWidth: 340,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(25)),
                          onPressed: () {
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
                                  type: 'S',
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
                          child: Center(
                            child: Text(
                              "Send",
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          color: Colors.green[300],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
