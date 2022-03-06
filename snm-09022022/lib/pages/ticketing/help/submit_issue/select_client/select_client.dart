import 'package:dil_app/custom/custom_timeline_widget.dart';
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class SelectClient extends StatefulWidget {
  final Map clientListdropdown;
  static Map mySelection;

  const SelectClient({Key key, @required this.clientListdropdown})
      : super(key: key);

  @override
  _SelectClientState createState() => _SelectClientState();
}

class _SelectClientState extends State<SelectClient> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        CustomTimeLine(
          height: 57,
        ),
        Expanded(
          flex: 15,
          child: Container(
            height: 75,
            padding: EdgeInsets.all(2.0),
            child: Card(
              elevation: 5.0,
              child: SingleChildScrollView(
                child: SearchableDropdown(
                  underline: SizedBox(),
                  searchHint: 'Select Client',
                  hint: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("Select Client"),
                  ),
                  isExpanded: true,
                  items: widget.clientListdropdown['clientInfos']
                      .map<DropdownMenuItem<Map>>((item) {
                    return new DropdownMenuItem<Map>(
                      value: item,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: new Text(
                          item["CLINT_NAME"],
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (newVal) {
                    setState(() {
                      SelectClient.mySelection = newVal == null ? {} : newVal;
                      print(
                        SelectClient.mySelection.toString(),
                      );
                    });
                  },
                  validator: (newVal) =>
                      newVal == null ? '    Field is required' : null,
                  value: SelectClient.mySelection,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
