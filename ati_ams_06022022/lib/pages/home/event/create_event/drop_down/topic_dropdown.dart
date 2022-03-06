import 'dart:developer';
import 'package:ati_ams/config/common_const.dart';
import 'package:ati_ams/model/create_event_dropdown_model.dart';
import 'package:flutter/material.dart';

class TopicDropdown extends StatefulWidget {
  static String selectedvalue;

  final List<Topic> topic;
  const TopicDropdown({
    Key key,
    @required this.topic,
  }) : super(key: key);

  @override
  _TopicDropdownState createState() => _TopicDropdownState();
}

class _TopicDropdownState extends State<TopicDropdown> {
  @override
  void initState() {
    TopicDropdown.selectedvalue = null;
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
            child: DropdownButtonFormField<Topic>(
              hint: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text("Select Topic"),
              ),
              isExpanded: true,
              validator: (newVal) => newVal == null ? ' * required' : null,
              items: widget.topic.map((value) {
                return DropdownMenuItem<Topic>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(value.topic),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  TopicDropdown.selectedvalue =
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
