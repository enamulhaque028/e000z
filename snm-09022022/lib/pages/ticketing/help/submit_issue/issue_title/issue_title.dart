import 'package:flutter/material.dart';
import 'package:dil_app/custom/custom_timeline_widget.dart';

class IssueTitle extends StatefulWidget {
  final TextEditingController _issueTitleController;
  const IssueTitle({
    Key key,
    @required TextEditingController issueTitleController,
  })  : _issueTitleController = issueTitleController,
        super(key: key);

  @override
  _IssueTitleState createState() => _IssueTitleState();
}

class _IssueTitleState extends State<IssueTitle> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        CustomTimeLine(
          height: 80,
        ),
        Expanded(
          flex: 15,
          child: Container(
            child: Card(
              elevation: 5,
              child: new TextFormField(
                controller: widget._issueTitleController,
                onFieldSubmitted: (String value) {
                  setState(() {
                    widget._issueTitleController.text = value;
                  });
                },
                decoration: new InputDecoration(
                  enabledBorder: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelText: "Input Issue Title",
                ),
                maxLength: 120,
                validator: (value) => value.length < 11
                    ? 'At least 11 character is needed'
                    : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
