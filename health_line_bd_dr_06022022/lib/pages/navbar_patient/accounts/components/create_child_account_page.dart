// import 'dart:developer';
// import 'package:ati_lis/config/common_const.dart';
// import 'package:ati_lis/pages/login/custom_progress/ProgressHUD.dart';
// import 'package:ati_lis/pages/registration/TextFields/mobile-number.dart';
// import 'package:ati_lis/pages/registration/TextFields/name_field.dart';
// import 'package:ati_lis/pages/registration/drop_downs/age/select_age_day.dart';
// import 'package:ati_lis/pages/registration/drop_downs/age/select_age_month.dart';
// import 'package:ati_lis/pages/registration/drop_downs/age/select_age_year.dart';
// import 'package:ati_lis/pages/registration/drop_downs/birthday/select_birth_day.dart';
// import 'package:ati_lis/pages/registration/drop_downs/birthday/select_birth_month.dart';
// import 'package:ati_lis/pages/registration/drop_downs/birthday/select_birth_year.dart';
// import 'package:ati_lis/pages/registration/drop_downs/select_blood_group.dart';
// import 'package:ati_lis/pages/registration/drop_downs/select_gender.dart';
// import 'package:ati_lis/pages/registration/drop_downs/select_maritial_status.dart';
// import 'package:ati_lis/pages/registration/drop_downs/select_relation.dart';
// import 'package:ati_lis/pages/registration/image_picker/profile_image_picker.dart';
// import 'package:ati_lis/services/child_registration_service.dart';
// import 'package:ati_lis/services/upload_image_service.dart';
// import 'package:cool_alert/cool_alert.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'dart:convert';
// import 'dart:ui';
// import 'package:http/http.dart' as http;
// import '../accounts_list_page.dart';

// class CreateChildAccountPage extends StatefulWidget {
//   final String profilePhone;
//   const CreateChildAccountPage({Key key, @required this.profilePhone})
//       : super(key: key);

//   @override
//   _CreateChildAccountPageState createState() => _CreateChildAccountPageState();
// }

// class _CreateChildAccountPageState extends State<CreateChildAccountPage> {
//   final _formKey = GlobalKey<FormState>();
//   bool _autoValidate = false;
//   var isLoading = true;
//   bool isChecked = false;
//   Map ticketListdropdown;
//   bool isApiCallProcess = false;
//   TextEditingController nameController = new TextEditingController();
//   TextEditingController phoneController = new TextEditingController();
//   TextEditingController emailController = new TextEditingController();

//   dropDownServiceMethod() async {
//     String extUrl = 'cmh/fget/';
//     Uri url = Uri.parse(baseUrl + extUrl);
//     // var url = "http://192.168.0.54:8088/ords/ordstest/cmh/fget/";
//     final response = await http.get(url);
//     // final responseJson = json.decode(response.body);
//     // print(responseJson);
//     // print(response.statusCode);

//     if (response.statusCode == 200) {
//       setState(() {
//         isLoading = false;
//         ticketListdropdown = json.decode(response.body)['items'][0];
//       });
//     } else {
//       setState(() {
//         isLoading = false;
//       });
//       throw Exception('Failed to load internet');
//     }
//   }

//   @override
//   void initState() {
//     dropDownServiceMethod();
//     phoneController.text = widget.profilePhone;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     //change status bar properties
//     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
//       // statusBarColor: Colors.red,
//       statusBarBrightness: Brightness.dark,
//     ));
//     var textStyle = TextStyle(
//       color: Colors.black.withOpacity(0.6),
//       fontWeight: FontWeight.w500,
//     );
//     var height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: ProgressHUD(
//         inAsyncCall: isApiCallProcess,
//         opacity: 0.3,
//         child: Stack(children: [
//           ConstrainedBox(
//               constraints: const BoxConstraints.expand(),
//               child: Image.asset('assets/images/login.png', fit: BoxFit.cover)),
//           Center(
//             child: Container(
//               height: height,
//               child: Card(
//                 elevation: 8.0,
//                 child: isLoading
//                     ? Center(
//                         child: CircularProgressIndicator(
//                           valueColor: AlwaysStoppedAnimation<Color>(cViolet),
//                         ),
//                       )
//                     : Container(
//                         height: height,
//                         decoration: new BoxDecoration(
//                           image: DecorationImage(
//                             // alignment: Alignment(1, 1),
//                             image: AssetImage("assets/images/reg_curve.jpg"),
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                         child: SingleChildScrollView(
//                           child: Form(
//                             key: _formKey,
//                             // ignore: deprecated_member_use
//                             autovalidate: _autoValidate,
//                             child: Padding(
//                               padding: const EdgeInsets.only(
//                                   top: 30.0,
//                                   left: 12.0,
//                                   right: 12.0,
//                                   bottom: 12.0),
//                               child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         InkWell(
//                                           onTap: () {
//                                             log(ImageUploadService
//                                                 .fileDownloadUrl);
//                                           },
//                                           child: Text('Create Child Account',
//                                               style: TextStyle(
//                                                   fontSize: 25,
//                                                   fontWeight: FontWeight.bold)),
//                                         ),
//                                         IconButton(
//                                             iconSize: 30,
//                                             icon: Icon(Icons.close),
//                                             onPressed: () {
//                                               Navigator.of(context).pop();
//                                             })
//                                       ],
//                                     ),
//                                     PickProfileImages(
//                                       uploadUrl:
//                                           ticketListdropdown['upload_dir']
//                                               .toString(),
//                                     ),
//                                     NameField(
//                                       autoValidate: _autoValidate,
//                                       nameController: nameController,
//                                     ),
//                                     Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Padding(
//                                               padding: const EdgeInsets.only(
//                                                   top: 8.0, bottom: 8.0),
//                                               child: Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceBetween,
//                                                   children: [
//                                                     Text(
//                                                         !isChecked
//                                                             ? 'Birthday'
//                                                             : 'Age',
//                                                         style: textStyle),
//                                                     // Row(children: [
//                                                     //   Text('Age',
//                                                     //       style: textStyle),
//                                                     //   Checkbox(
//                                                     //       value: isChecked,
//                                                     //       onChanged: (value) {
//                                                     //         setState(() {
//                                                     //           isChecked = value;
//                                                     //         });
//                                                     //       })
//                                                     // ])
//                                                   ])),
//                                           !isChecked
//                                               ? Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceBetween,
//                                                   children: [
//                                                       SelectBirthDay(),
//                                                       SelectBirthMonth(),
//                                                       SelectBirthYear(),
//                                                     ])
//                                               : Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceBetween,
//                                                   children: [
//                                                       SelectAgeYear(),
//                                                       SelectAgeMonth(),
//                                                       SelectAgeDay(),
//                                                     ])
//                                         ]),
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 8.0),
//                                       child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               children: [
//                                                 Padding(
//                                                   padding:
//                                                       const EdgeInsets.only(
//                                                           bottom: 5.0),
//                                                   child: Text(
//                                                     'Gender',
//                                                     style: textStyle,
//                                                   ),
//                                                 ),
//                                                 SelectGender(
//                                                     projectListdropdown:
//                                                         ticketListdropdown),
//                                               ],
//                                             ),
//                                             Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Padding(
//                                                       padding:
//                                                           const EdgeInsets.only(
//                                                               bottom: 5.0),
//                                                       child: Text('Blood Group',
//                                                           style: textStyle)),
//                                                   SelectBloodGroup(
//                                                       projectListdropdown:
//                                                           ticketListdropdown)
//                                                 ]),
//                                             Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Padding(
//                                                       padding:
//                                                           const EdgeInsets.only(
//                                                               bottom: 5.0),
//                                                       child: Text(
//                                                           'Maritial Status',
//                                                           style: textStyle)),
//                                                   SelectMaritialStatus(
//                                                       projectListdropdown:
//                                                           ticketListdropdown)
//                                                 ]),
//                                           ]),
//                                     ),
//                                     SizedBox(height: 10),
//                                     SelectRelation(
//                                         projectListdropdown:
//                                             ticketListdropdown),
//                                     SizedBox(height: 10),
//                                     MobileNumberField(
//                                         autoValidate: _autoValidate,
//                                         phoneController: phoneController),
//                                     // N.B: EmailField class exists in this file
//                                     EmailField(
//                                         autoValidate: _autoValidate,
//                                         emailController: emailController),

//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Container(),
//                                         ElevatedButton(
//                                             onPressed: () {
//                                               if (_formKey.currentState
//                                                   .validate()) {
//                                                 setState(() {
//                                                   isApiCallProcess = true;
//                                                 });
//                                                 String birthDate =
//                                                     '${SelectBirthDay.dropdownValue}/${SelectBirthMonth.dropdownValue}/${SelectBirthYear.dropdownValue}';
//                                                 String birthDateVal = '';
//                                                 isChecked == false
//                                                     ? birthDateVal = birthDate
//                                                     : birthDateVal = '';
//                                                 int ageDay = isChecked
//                                                     ? int.parse(SelectAgeDay
//                                                         .dropdownValue)
//                                                     : 0;
//                                                 int ageMonth = isChecked
//                                                     ? int.parse(SelectAgeMonth
//                                                         .dropdownValue)
//                                                     : 0;
//                                                 int ageYear = isChecked
//                                                     ? int.parse(SelectAgeYear
//                                                         .dropdownValue)
//                                                     : 0;
//                                                 sumbitChildRegistrationData(
//                                                   nameController.text,
//                                                   phoneController.text,
//                                                   emailController.text,
//                                                   SelectGender
//                                                       .mySelection['r_id']
//                                                       .toString(),
//                                                   SelectBloodGroup
//                                                       .mySelection['r_id']
//                                                       .toString(),
//                                                   birthDateVal,
//                                                   ageDay,
//                                                   ageMonth,
//                                                   ageYear,
//                                                   SelectMaritialStatus
//                                                       .mySelection['r_id']
//                                                       .toString(),
//                                                   SelectRelation
//                                                       .mySelection['r_id']
//                                                       .toString(),
//                                                   ImageUploadService
//                                                       .fileDownloadUrl,
//                                                 ).then((value) {
//                                                   log(statusCodeChild
//                                                       .toString());
//                                                   if (statusCodeChild == 200) {
//                                                     setState(() {
//                                                       isApiCallProcess = false;
//                                                     });
//                                                     // telephony.sendSms(to: "${phoneController.text}", message: "Welcome! Your registration is sucessful!");
//                                                     Navigator.push(
//                                                         context,
//                                                         MaterialPageRoute(
//                                                             builder: (context) =>
//                                                                 AccountsListPage()));
//                                                     CoolAlert.show(
//                                                       context: context,
//                                                       // width: 350,
//                                                       type:
//                                                           CoolAlertType.success,
//                                                       text:
//                                                           "Registration successful!",
//                                                     );
//                                                   } else {
//                                                     setState(() {
//                                                       isApiCallProcess = false;
//                                                     });
//                                                     ScaffoldMessenger.of(
//                                                             context)
//                                                         .showSnackBar(SnackBar(
//                                                       content: Text(
//                                                           'Registration failed! Please Submit again'),
//                                                     ));
//                                                   }
//                                                 });
//                                                 _formKey.currentState.save();
//                                               } else {
//                                                 setState(() {
//                                                   _autoValidate = true;
//                                                 });
//                                               }
//                                             },
//                                             child: Text('Submit'),
//                                             style: ButtonStyle(
//                                               backgroundColor:
//                                                   MaterialStateProperty.all(
//                                                       Colors.green),
//                                             ))
//                                       ],
//                                     ),
//                                   ]),
//                             ),
//                           ),
//                         ),
//                       ),
//               ),
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
// }

// class EmailField extends StatelessWidget {
//   const EmailField({
//     Key key,
//     @required bool autoValidate,
//     @required this.emailController,
//   })  : _autoValidate = autoValidate,
//         super(key: key);

//   final bool _autoValidate;
//   final TextEditingController emailController;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: _autoValidate == false ? 55 : 70,
//       padding: EdgeInsets.only(top: 10),
//       child: TextFormField(
//         controller: emailController,
//         keyboardType: TextInputType.emailAddress,
//         onFieldSubmitted: (String value) {
//           emailController.text = value;
//         },
//         validator: (value) => value.isEmpty ? 'Email is required' : null,
//         decoration: InputDecoration(
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(width: 1.5, color: Colors.black),
//           ),
//           border: OutlineInputBorder(),
//           labelText: 'Enter email',
//           prefixIcon: Icon(
//             Icons.email,
//             color: Colors.black.withOpacity(0.4),
//           ),
//         ),
//       ),
//     );
//   }
// }
