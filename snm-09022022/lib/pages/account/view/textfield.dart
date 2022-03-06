import 'package:flutter/material.dart';
import 'package:dil_app/custom/custom_timeline_widget.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController _textFieldController;
  final String labelText;
  const TextFieldWidget({
    Key key,
    @required TextEditingController textFieldController,
    @required this.labelText,
  })  : _textFieldController = textFieldController,
        super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
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
            height: 80,
            child: Card(
              elevation: 2,
              child: new TextFormField(
                controller: widget._textFieldController,
                onFieldSubmitted: (String value) {
                  setState(() {
                    widget._textFieldController.text = value;
                  });
                },
                decoration: new InputDecoration(
                  enabledBorder: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  labelText: widget.labelText,
                ),
                // maxLength: 120,
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
