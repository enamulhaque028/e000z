import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:health_line_bd/config/common_const.dart';
import 'package:health_line_bd/model/dropdown/institution_model.dart';

class InstitutionDropDown extends StatefulWidget {
  static String selectedInstitution;

  final List<InstitutionCategory> institutionCategory;
  const InstitutionDropDown({Key key, @required this.institutionCategory})
      : super(key: key);

  @override
  _InstitutionDropDownState createState() => _InstitutionDropDownState();
}

class _InstitutionDropDownState extends State<InstitutionDropDown> {
  @override
  Widget build(BuildContext context) {
    InstitutionCategory valueUpdated;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: cViolet),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: DropdownButtonFormField<InstitutionCategory>(
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
          ),
          hint: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text("Select Institution"),
          ),
          isExpanded: true,
          validator: (newVal) => newVal == null ? ' * required' : null,
          items: widget.institutionCategory.map((value) {
            return DropdownMenuItem<InstitutionCategory>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(value.instituteName),
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              InstitutionDropDown.selectedInstitution =
                  value == null ? {} : value.instituteName;
              valueUpdated = value;
              log(value.instituteName.toString());
            });
          },
          value: valueUpdated,
        ),
      ),
    );
  }
}
