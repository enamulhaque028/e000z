import 'dart:developer';
import 'package:ati_ams/config/common_const.dart';
import 'package:ati_ams/model/create_event_dropdown_model.dart';
import 'package:flutter/material.dart';

class AuthorizerDropdown extends StatefulWidget {
  static String selectedvalue;

  final List<TeacherList> authorizer;
  const AuthorizerDropdown({
    Key key,
    @required this.authorizer,
  }) : super(key: key);

  @override
  _AuthorizerDropdownState createState() => _AuthorizerDropdownState();
}

class _AuthorizerDropdownState extends State<AuthorizerDropdown> {
  @override
  void initState() {
    AuthorizerDropdown.selectedvalue = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: cViolet),
                borderRadius: BorderRadius.all(Radius.circular(5))),
            child: DropdownButtonFormField<TeacherList>(
              hint: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text("Select Authorizer"),
              ),
              isExpanded: true,
              validator: (newVal) => newVal == null ? ' * required' : null,
              items: widget.authorizer.map((value) {
                return DropdownMenuItem<TeacherList>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(value.name),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  AuthorizerDropdown.selectedvalue =
                      value == null ? {} : value.id.toString();
                  log(value.id.toString());
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
