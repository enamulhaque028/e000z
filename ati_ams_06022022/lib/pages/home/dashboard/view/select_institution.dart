import 'package:ati_ams/pages/home/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectInstitution extends StatefulWidget {
  const SelectInstitution({
    Key key,
  }) : super(key: key);

  @override
  _SelectInstitutionState createState() => _SelectInstitutionState();
}

class _SelectInstitutionState extends State<SelectInstitution> {
  List<String> institution = ['BIRDEM 1', 'BIRDEM 2'];
  String selectedInstitution;
  String institutionDropdown = '';
  @override
  void initState() {
    getRespFromSP();
    super.initState();
  }

  Future getRespFromSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    institutionDropdown = prefs.getString('institutionDropdown');
    return institutionDropdown;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Text(institutionDropdown.toString() == 'null'
          ? institution[0]
          : institutionDropdown),
      value: selectedInstitution,
      items: institution.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (selectedValue) async {
        print(selectedValue);
        setState(() {
          selectedInstitution = selectedValue;
        });
        var spValue = selectedValue == 'BIRDEM 1' ? 'BIRDEM_01' : 'BIRDEM_02';
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('institution', spValue);
        prefs.setString('institutionDropdown', selectedValue);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardPage(),
          ),
        );
      },
    );
  }
}
