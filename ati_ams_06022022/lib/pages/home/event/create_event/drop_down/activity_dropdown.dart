import 'dart:developer';
import 'package:ati_ams/config/common_const.dart';
import 'package:ati_ams/model/create_event_dropdown_model.dart';
import 'package:flutter/material.dart';

class ActivityDropdown extends StatefulWidget {
  static String selectedvalue;

  final List<ActivityInfo> authorizer;
  const ActivityDropdown({
    Key key,
    @required this.authorizer,
  }) : super(key: key);

  @override
  _ActivityDropdownState createState() => _ActivityDropdownState();
}

class _ActivityDropdownState extends State<ActivityDropdown> {
  @override
  void initState() {
    ActivityDropdown.selectedvalue = null;
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
            child: DropdownButtonFormField<ActivityInfo>(
              hint: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text("Select Activity"),
              ),
              isExpanded: true,
              validator: (newVal) => newVal == null ? ' * required' : null,
              items: widget.authorizer.map((value) {
                return DropdownMenuItem<ActivityInfo>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(value.activityName),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  ActivityDropdown.selectedvalue =
                      value == null ? {} : value.activityId.toString();
                  log(value.activityId.toString());
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
