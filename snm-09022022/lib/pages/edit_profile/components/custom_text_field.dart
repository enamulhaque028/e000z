import 'package:flutter/material.dart';

class CustomTextFieldProfile extends StatelessWidget {
  final TextEditingController textEditingController;
  final String placeholderText;
  final Function(String) onFieldSubmitted;
  final double horizontalPadding;

  const CustomTextFieldProfile({
    Key key,
    @required this.textEditingController,
    @required this.placeholderText,
    @required this.onFieldSubmitted,
    this.horizontalPadding = 16.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(horizontalPadding, 0, horizontalPadding, 8),
      child: TextFormField(
        controller: textEditingController,
        onFieldSubmitted: (value) {
          onFieldSubmitted(value);
        },
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 0.0,
            ),
          ),
          border: OutlineInputBorder(),
          labelText: placeholderText,
        ),
      ),
    );
  }
}
