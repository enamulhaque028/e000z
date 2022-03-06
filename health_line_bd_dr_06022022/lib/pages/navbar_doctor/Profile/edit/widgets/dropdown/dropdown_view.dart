import 'package:flutter/material.dart';
import 'package:health_line_bd/model/dropdown/department_model.dart';
import 'package:health_line_bd/model/dropdown/designation_model.dart';
import 'package:health_line_bd/model/dropdown/institution_model.dart';
import 'package:health_line_bd/pages/navbar_doctor/Profile/edit/widgets/dropdown/department_dropdown.dart';
import 'package:health_line_bd/pages/navbar_doctor/Profile/edit/widgets/dropdown/institution_dropdown.dart';
import 'package:health_line_bd/services/dropdown/dropdown_service.dart';
import 'designation_dropdown.dart';

class DropDownView extends StatefulWidget {
  const DropDownView({
    Key key,
  }) : super(key: key);

  @override
  _DropDownViewState createState() => _DropDownViewState();
}

class _DropDownViewState extends State<DropDownView> {
  List<DesignationCategory> designationCategory = [];
  List<DepartmentCategory> departmentCategory = [];
  List<InstitutionCategory> institutionCategory = [];
  bool isLoading = true;

  @override
  void initState() {
    // nameController.text = 'ENamul Haque';
    DropdownServices().fetchDesignation().then((value) {
      setState(() {
        designationCategory = value.listResponse;
      });
    }).then((value) {
      DropdownServices().fetchDepartment().then((value) {
        setState(() {
          departmentCategory = value.listResponse;
        });
      });
    }).then((value) {
      DropdownServices().fetchInstitution().then((value) {
        setState(() {
          institutionCategory = value.listResponse;
          isLoading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: Image.asset(
              'assets/images/loader.gif',
              height: 100,
            ),
          )
        : Column(
            children: [
              DesignationDropDown(designationCategory: designationCategory),
              DepartmentDropDown(departmentCategory: departmentCategory),
              InstitutionDropDown(institutionCategory: institutionCategory)
            ],
          );
  }
}
