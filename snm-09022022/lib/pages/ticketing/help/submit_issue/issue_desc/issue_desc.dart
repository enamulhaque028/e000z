import 'package:dil_app/custom/custom_timeline_widget.dart';
import 'package:flutter/material.dart';

class IssueDescription extends StatefulWidget {
  const IssueDescription({
    Key key,
    @required TextEditingController issueDescController,
  })  : _issueDescController = issueDescController,
        super(key: key);

  final TextEditingController _issueDescController;

  @override
  _IssueDescriptionState createState() => _IssueDescriptionState();
}

class _IssueDescriptionState extends State<IssueDescription> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        CustomTimeLine(
          height: 135,
        ),
        Expanded(
          flex: 15,
          child: Container(
            height: 150,
            child: Card(
              elevation: 5,
              child: new TextFormField(
                controller: widget._issueDescController,
                onFieldSubmitted: (String value) {
                  setState(() {
                    widget._issueDescController.text = value;
                  });
                },
                decoration: new InputDecoration(
                  enabledBorder: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelText: "Input Issue Description",
                ),
                maxLines: 50,
                validator: (value) =>
                    value.isEmpty ? '     Field is required' : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
