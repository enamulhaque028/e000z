import 'package:dil_app/custom/custom_timeline_widget.dart';
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class SelectProject extends StatefulWidget {
  final Map projectListdropdown;
  static Map mySelection;
  const SelectProject({
    Key key,
    @required this.projectListdropdown,
  }) : super(key: key);

  @override
  _SelectProjectState createState() => _SelectProjectState();
}

class _SelectProjectState extends State<SelectProject> {
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
                  searchHint: 'Select Project',
                  hint: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("Select Project"),
                  ),
                  isExpanded: true,
                  items: widget.projectListdropdown['projectInfos']
                      .map<DropdownMenuItem<Map>>((item) {
                    return new DropdownMenuItem<Map>(
                      value: item,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: new Text(
                          item["PROJT_NAME"],
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (newVal) {
                    setState(() {
                      SelectProject.mySelection = newVal == null ? {} : newVal;
                      print(
                        SelectProject.mySelection.toString(),
                        // SelectProject.mySelection['PROJT_NAME']
                        //     .toString(),
                      );
                    });
                  },
                  validator: (newVal) =>
                      newVal == null ? '    Field is required' : null,
                  value: SelectProject.mySelection,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SelectedProjectView extends StatelessWidget {
  final String projectName;
  const SelectedProjectView({
    Key key,
    @required this.projectName,
  }) : super(key: key);

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
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 20.0),
                  child: Text(projectName),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
