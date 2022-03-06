import 'package:dil_app/custom/custom_timeline_widget.dart';
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class SelectTicketPriority extends StatefulWidget {
  final Map tPriorityListdropdown;
  static Map mySelection;
  static final TextEditingController criticalCommentController =
      TextEditingController();

  SelectTicketPriority({Key key, @required this.tPriorityListdropdown});

  @override
  _SelectTicketPriorityState createState() => _SelectTicketPriorityState();
}

class _SelectTicketPriorityState extends State<SelectTicketPriority> {
  // final TextEditingController _criticalCommentController =
  //     TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        CustomTimeLine(
          height: (SelectTicketPriority.mySelection != null &&
                  SelectTicketPriority.mySelection['TKT_PRI_ID'].toString() ==
                      '1')
              ? 145
              : 65,
        ),
        Expanded(
          flex: 15,
          child: Container(
            height: (SelectTicketPriority.mySelection != null &&
                    SelectTicketPriority.mySelection['TKT_PRI_ID'].toString() ==
                        '1')
                ? 160
                : 75,
            padding: EdgeInsets.all(2.0),
            child: Card(
              elevation: 5.0,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SearchableDropdown(
                      underline: SizedBox(),
                      hint: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text("Select Ticket Priority"),
                      ),
                      isExpanded: true,
                      items: widget.tPriorityListdropdown['ticketPriorityInfos']
                          .map<DropdownMenuItem<Map>>((item) {
                        return new DropdownMenuItem<Map>(
                          value: item,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: new Text(
                              item["T_PRIORITY"],
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          SelectTicketPriority.mySelection =
                              newVal == null ? {} : newVal;
                          print(
                            SelectTicketPriority.mySelection.toString(),
                          );
                        });
                      },
                      validator: (newVal) =>
                          newVal == null ? '    Field is required' : null,
                      value: SelectTicketPriority.mySelection,
                    ),

                    //why you choose critical?
                    (SelectTicketPriority.mySelection != null &&
                            SelectTicketPriority.mySelection['TKT_PRI_ID']
                                    .toString() ==
                                '1')
                        ? Container(
                            //padding: EdgeInsets.only(bottom: 10),
                            height: 80,
                            child: new TextFormField(
                              controller: SelectTicketPriority
                                  .criticalCommentController,
                              onFieldSubmitted: (String value) {
                                setState(() {
                                  SelectTicketPriority
                                      .criticalCommentController.text = value;
                                });
                              },
                              decoration: new InputDecoration(
                                // enabled: isEnabled,
                                enabledBorder: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                labelText: "Why you choose critical?",
                              ),
                              maxLines: 50,
                              validator: (value) => value.isEmpty
                                  ? '     Field is required'
                                  : null,
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
    );
  }
}
