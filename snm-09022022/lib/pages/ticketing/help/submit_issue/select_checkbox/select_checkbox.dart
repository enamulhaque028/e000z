import 'package:dil_app/pages/login/Animation/FadeAnimation.dart';
import 'package:dil_app/pages/ticketing/help/submit_issue/issue_title/issue_title.dart';
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:dil_app/custom/custom_timeline_widget.dart';

class CheckBoxIssueTitle extends StatefulWidget {
  final Map ticketTitleListdropdown;
  static Map mySelection;
  static bool isChecked = false;
  final TextEditingController _issueTitleController;
  const CheckBoxIssueTitle({
    Key key,
    @required this.ticketTitleListdropdown,
    @required TextEditingController issueTitleController,
  })  : _issueTitleController = issueTitleController,
        super(key: key);

  @override
  _CheckBoxIssueTitleState createState() => _CheckBoxIssueTitleState();
}

class _CheckBoxIssueTitleState extends State<CheckBoxIssueTitle> {
  @override
    void initState() {
      CheckBoxIssueTitle.isChecked = false;
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CustomTimeLine(
              height: 50,
            ),
            Expanded(
              flex: 15,
              child: Container(
                child: Card(
                  elevation: 5,
                  child: ListTile(
                    title: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Have you faced this issue previously?',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        Checkbox(
                          value: CheckBoxIssueTitle.isChecked,
                          onChanged: (bool value) {
                            setState(() {
                              CheckBoxIssueTitle.isChecked = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        CheckBoxIssueTitle.isChecked == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  CustomTimeLine(
                    //height: 57,
                    height: CheckBoxIssueTitle.mySelection != null ? 85 : 57,
                  ),
                  Expanded(
                    flex: 15,
                    child: Container(
                      //height: 75,
                      height: CheckBoxIssueTitle.mySelection != null ? 100 : 75,
                      padding: EdgeInsets.all(2.0),
                      child: Card(
                        elevation: 5.0,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SearchableDropdown(
                                underline: SizedBox(),
                                searchHint: 'Select Issue Title',
                                hint: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text("Select Issue Title"),
                                ),
                                isExpanded: true,
                                items: widget
                                    .ticketTitleListdropdown['ticketTitleInfos']
                                    .map<DropdownMenuItem<Map>>((item) {
                                  return new DropdownMenuItem<Map>(
                                    value: item,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: new Text(
                                        item["CST_TITLES"].toString(),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newVal) {
                                  setState(() {
                                    CheckBoxIssueTitle.mySelection =
                                        newVal == null ? {} : newVal;
                                    print(
                                      CheckBoxIssueTitle.mySelection.toString(),
                                    );
                                  });
                                },
                                validator: (newVal) => newVal == null
                                    ? '    Field is required'
                                    : null,
                                value: CheckBoxIssueTitle.mySelection,
                              ),
                              CheckBoxIssueTitle.mySelection != null
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'Previous solution: ',
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text:
                                                  '${CheckBoxIssueTitle.mySelection['RESOLUTION'].toString()}',
                                              style: TextStyle(
                                                color: Colors.green[400],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : FadeAnimation(
                0,
                IssueTitle(issueTitleController: widget._issueTitleController),
              ),
      ],
    );
  }
}
