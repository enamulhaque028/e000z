import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:health_line_bd/config/common_const.dart';
import 'package:health_line_bd/model/dropdown/department_model.dart';

class DepartmentDropDown extends StatefulWidget {
  static String selectedDepartment;

  final List<DepartmentCategory> departmentCategory;
  const DepartmentDropDown({Key key, @required this.departmentCategory})
      : super(key: key);

  @override
  _DepartmentDropDownState createState() => _DepartmentDropDownState();
}

class _DepartmentDropDownState extends State<DepartmentDropDown> {
  @override
  Widget build(BuildContext context) {
    DepartmentCategory valueUpdated;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: cViolet),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: DropdownButtonFormField<DepartmentCategory>(
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
          ),
          hint: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text("Select Department"),
          ),
          isExpanded: true,
          validator: (newVal) => newVal == null ? ' * required' : null,
          items: widget.departmentCategory.map((value) {
            return DropdownMenuItem<DepartmentCategory>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(value.departmentName),
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              DepartmentDropDown.selectedDepartment =
                  value == null ? {} : value.departmentName;
              valueUpdated = value;
              log(value.departmentName.toString());
            });
          },
          value: valueUpdated,
        ),
      ),
    );
  }
}
