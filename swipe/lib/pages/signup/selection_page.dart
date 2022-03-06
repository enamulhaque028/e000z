// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:swipe/config/presentation/app_color.dart';
// import 'package:swipe/pages/navbar/navbar_page.dart';
// import 'package:swipe/pages/signup/components/gender_list_dialog.dart';
// import 'package:swipe/widgets/app_title.dart';
// import 'package:swipe/widgets/custom_text_button.dart';
// import 'package:swipe/widgets/selection_field_rounded.dart';

// import 'components/country_list_dialog.dart';

// class SelectionPage extends StatefulWidget {
//   const SelectionPage({Key? key}) : super(key: key);

//   @override
//   State<SelectionPage> createState() => _SelectionPageState();
// }

// class _SelectionPageState extends State<SelectionPage> {
//   String birthDayText = 'Date of Birth';
//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;

//     return Scaffold(
//       backgroundColor: AppColor.kBackground,
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Column(
//             children: [
//               SizedBox(
//                 height: height * 0.4,
//                 child: Center(
//                   child: AppTitle(),
//                 ),
//               ),
//               Column(
//                 children: [
//                   SelectionFieldRounded(
//                     placeholderText: 'Select your country',
//                     iconPath: 'assets/images/earth.png',
//                     onTap: () {
//                       showModalBottomSheet(
//                         context: context,
//                         backgroundColor: AppColor.kBackground,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(15.0),
//                               topRight: Radius.circular(15.0)),
//                         ),
//                         builder: (context) {
//                           return CountryListDialog();
//                         },
//                       );
//                     },
//                   ),
//                   SelectionFieldRounded(
//                     placeholderText: 'Gender',
//                     iconPath: 'assets/images/gender.png',
//                     onTap: () {
//                       showModalBottomSheet(
//                         context: context,
//                         backgroundColor: AppColor.kBackground,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(15.0),
//                               topRight: Radius.circular(15.0)),
//                         ),
//                         builder: (context) {
//                           return GenderListDialog(
//                             ctxMoreOption: context,
//                           );
//                         },
//                       );
//                     },
//                   ),
//                   SelectionFieldRounded(
//                     placeholderText: birthDayText,
//                     iconPath: 'assets/images/calender.png',
//                     onTap: () {
//                       showDatePicker(
//                         context: context,
//                         initialDate: DateTime.now(),
//                         firstDate: DateTime(1930, 1),
//                         lastDate: DateTime.now(),
//                       ).then((pickedDate) {
//                         String formattedDate =
//                             DateFormat('yyyy-MM-dd').format(pickedDate!);
//                         setState(() {
//                           birthDayText = formattedDate;
//                         });
//                       });
//                     },
//                   ),
//                   SizedBox(height: 16),
//                   SizedBox(
//                     height: 60,
//                     width: 70,
//                     child: CustomTextButton(
//                       showArrow: true,
//                       title: '',
//                       onTapBtn: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => NavBarPage(),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   SizedBox(height: 12),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
