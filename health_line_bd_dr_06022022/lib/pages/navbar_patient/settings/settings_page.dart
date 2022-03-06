import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_line_bd/config/language_constants.dart';
import 'package:health_line_bd/pages/navbar_doctor/Profile/edit/edit_profile.dart';
import 'package:health_line_bd/pages/navbar_doctor/Profile/edit/widgets/image_picker.dart';
import 'package:health_line_bd/pages/navbar_doctor/settings/visiting_card/visiting_card_chooser_dialog.dart';
import 'package:health_line_bd/theme/theme_chooser_dialog.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String selected;

  void choiceAction(String choice) {
    if (choice == Languages.English) {
      EasyLocalization.of(context).locale = Locale('en', 'US');
    } else if (choice == Languages.Bangla) {
      EasyLocalization.of(context).locale = Locale('bn', 'BD');
    }
  }

  String patientName;
  bool isLoading = true;
  Map accountListdropdown;
  Map mySelection;
  // getRespFromSP() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   accountListdropdown = json.decode(prefs.getString('apiresp'));
  //   patientName = prefs.getString('patientName');
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  @override
  void initState() {
    // getRespFromSP();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      brightness: Brightness.dark,
      title: Text(
        'settingsPage.appBarTitle'.tr().toString(),
        style: TextStyle(fontSize: 19),
        textAlign: TextAlign.center,
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 24),
            Container(
              height: 40,
              child: ListTile(
                title: Text(
                  'settingsPage.themeTitle'.tr().toString(),
                ),
                leading: Icon(Icons.color_lens),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return ThemeChooserDialog();
                      });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                height: 1.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey[200],
              ),
            ),
            Container(
              height: 40,
              child: ListTile(
                title: Text(
                  'Choose visiting card',
                ),
                leading: Icon(Icons.credit_card_rounded),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return VisitingCardChooserDialog();
                      });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                height: 1.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey[200],
              ),
            ),
            Container(
              height: 40,
              child: ListTile(
                title: Text(
                  'Edit profile',
                ),
                leading: Icon(FontAwesomeIcons.edit),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  PickImages.profileImgPath = '';
                  PickImages.signatureImgPath = '';
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => EditProfileDialog(),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                height: 1.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey[200],
              ),
            ),
            Container(
              height: 40,
              child: ListTile(
                title: Text(
                  'settingsPage.languageTitle'.tr().toString(),
                ),
                leading: Icon(Icons.language),
                trailing: PopupMenuButton<String>(
                  icon: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Icon(
                      Icons.more_vert,
                      size: 24,
                    ),
                  ),
                  initialValue: selected,
                  //onSelected: choiceAction,
                  onSelected: (val) {
                    setState(() {
                      choiceAction(val);
                      selected = val;
                    });
                  },
                  itemBuilder: (BuildContext context) {
                    return Languages.choices.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                height: 1.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey[200],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
            //   child: isLoading
            //       ? Center(
            //           child: Text('loading'),
            //         )
            //       : DropdownButton<Map>(
            //           isExpanded: true,
            //           hint: Text(patientName.toString() == 'null'
            //               ? accountListdropdown['P_RETURNMSG4'][0]["patient_nm"]
            //                   .toString()
            //               : patientName.toString()),
            //           items: accountListdropdown['P_RETURNMSG4']
            //               .map<DropdownMenuItem<Map>>((item) {
            //             return new DropdownMenuItem<Map>(
            //               value: item,
            //               child: Padding(
            //                 padding: const EdgeInsets.only(left: 8.0),
            //                 child: new Text(
            //                   item["patient_nm"].toString(),
            //                 ),
            //               ),
            //             );
            //           }).toList(),
            //           onChanged: (newVal) async {
            //             SharedPreferences prefs =
            //                 await SharedPreferences.getInstance();
            //             setState(() {
            //               mySelection = newVal == null ? {} : newVal;
            //               print(
            //                 mySelection.toString(),
            //                 // mySelection['g_id']
            //                 //     .toString(),
            //               );
            //               String patientId =
            //                   mySelection['patient_id'].toString();
            //               String patientName =
            //                   mySelection['patient_nm'].toString();
            //               prefs.setString('patientId', patientId);
            //               prefs.setString('patientName', patientName);
            //               Navigator.pop(context);
            //               Navigator.pushReplacement(
            //                   context,
            //                   MaterialPageRoute(
            //                       builder: (context) => BottomNavBar()));
            //               // showAlertDialogue();
            //             });
            //           },
            //           value: mySelection,
            //         ),
            // ),
          ],
        ),
      ),
    );
  }
}
