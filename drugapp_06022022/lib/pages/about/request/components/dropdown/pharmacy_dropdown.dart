import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mediinfo/config/CommonConstant.dart';
import 'model.dart';

class PharmacyDropDown extends StatefulWidget {
  static String selectedPharmacy;

  final List<PharmacyCategory> pharmacyCategory;
  const PharmacyDropDown({Key key, @required this.pharmacyCategory})
      : super(key: key);

  @override
  _PharmacyDropDownState createState() => _PharmacyDropDownState();
}

class _PharmacyDropDownState extends State<PharmacyDropDown> {
  @override
  Widget build(BuildContext context) {
    PharmacyCategory valueUpdated;
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: cViolet),
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: DropdownButtonFormField<PharmacyCategory>(
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
        ),
        hint: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text("Select Category"),
        ),
        isExpanded: true,
        validator: (newVal) => newVal == null ? ' * required' : null,
        items: widget.pharmacyCategory.map((value) {
          return DropdownMenuItem<PharmacyCategory>(
            value: value,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(value.name),
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            PharmacyDropDown.selectedPharmacy = value == null ? {} : value.name;
            valueUpdated = value;
            log(value.name.toString());
          });
        },
        value: valueUpdated,
      ),
    );
  }
}
