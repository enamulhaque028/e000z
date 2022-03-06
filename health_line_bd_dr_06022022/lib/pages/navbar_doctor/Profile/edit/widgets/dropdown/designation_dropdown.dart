import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:health_line_bd/config/common_const.dart';
import 'package:health_line_bd/model/dropdown/designation_model.dart';

class DesignationDropDown extends StatefulWidget {
  static String selectedDesignation;

  final List<DesignationCategory> designationCategory;
  const DesignationDropDown({Key key, @required this.designationCategory})
      : super(key: key);

  @override
  _DesignationDropDownState createState() => _DesignationDropDownState();
}

class _DesignationDropDownState extends State<DesignationDropDown> {
  @override
  Widget build(BuildContext context) {
    DesignationCategory valueUpdated;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: cViolet),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: DropdownButtonFormField<DesignationCategory>(
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
          ),
          hint: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text("Select Designation"),
          ),
          isExpanded: true,
          validator: (newVal) => newVal == null ? ' * required' : null,
          items: widget.designationCategory.map((value) {
            return DropdownMenuItem<DesignationCategory>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(value.designationName),
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              DesignationDropDown.selectedDesignation =
                  value == null ? {} : value.designationName;
              valueUpdated = value;
              log(value.designationName.toString());
            });
          },
          value: valueUpdated,
        ),
      ),
    );
  }
}
