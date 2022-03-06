import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mediinfo/config/CommonConstant.dart';
import 'package:mediinfo/pages/about/request/components/dropdown/model.dart';
import 'package:mediinfo/pages/about/request/components/dropdown/service.dart';
import 'pharmacy_dropdown.dart';

class DropDownView extends StatefulWidget {
  static String selectedDivisions;
  static String selectedDistrict;
  const DropDownView({Key key}) : super(key: key);

  @override
  _DropDownViewState createState() => _DropDownViewState();
}

class _DropDownViewState extends State<DropDownView> {
  DistrictModel dropdownDataAll = DistrictModel();
  var isLoading = true;
  List<Division> _divisions = [];
  List<Division> _filteredDivision = [];
  bool isVisible = false;
  Division valueDiv;
  District valueDist;
  @override
  void initState() {
    Webservice().fetchDistricts().then((value) {
      setState(() {
        dropdownDataAll = value;
        _divisions = value.divisions;
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            padding: EdgeInsets.only(top: 8),
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: cViolet),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: DropdownButtonFormField<Division>(
                    decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                    ),
                    hint: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text("Select Division"),
                    ),
                    isExpanded: true,
                    validator: (newVal) =>
                        newVal == null ? ' * required' : null,
                    items: _divisions.map((value) {
                      return DropdownMenuItem<Division>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(value.bnName),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        DropDownView.selectedDistrict = null;
                        valueDist = null;
                        DropDownView.selectedDivisions =
                            value == null ? {} : value.bnName;
                        valueDiv = value;

                        _filteredDivision = dropdownDataAll.divisions
                            .where((element) => element.bnName == value.bnName)
                            .toList();
                        isVisible = true;
                        log(value.name.toString());
                      });
                    },
                    value: valueDiv,
                  ),
                ),
                !isVisible
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: cViolet),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: DropdownButtonFormField<District>(
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                            ),
                            hint: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text("Select District"),
                            ),
                            isExpanded: true,
                            validator: (newVal) =>
                                newVal == null ? ' * required' : null,
                            items: _filteredDivision[0].districts.map((value) {
                              return DropdownMenuItem<District>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(value.bnName),
                                ),
                              );
                            }).toList(),
                            // onChanged: (value) => print(value),
                            onChanged: (value) {
                              setState(() {
                                DropDownView.selectedDistrict =
                                    value == null ? {} : value.bnName;
                                valueDist = value;
                                log(value.name.toString());
                              });
                            },
                            value: valueDist,
                          ),
                        ),
                      ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: PharmacyDropDown(
                    pharmacyCategory: dropdownDataAll.pharmacyCategory,
                  ),
                )
              ],
            ),
          );
  }
}
