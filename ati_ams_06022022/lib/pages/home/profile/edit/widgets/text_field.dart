import 'package:ati_ams/config/common_const.dart';
import 'package:flutter/material.dart';

class CustomtextField extends StatelessWidget {
  const CustomtextField({
    Key key,
    @required this.nameController,
    @required this.labeltext,
    @required this.icon,
    @required this.onTapCalendar,
    this.readOnly = false,
  }) : super(key: key);

  final TextEditingController nameController;
  final String labeltext;
  final IconData icon;
  final VoidCallback onTapCalendar;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: _autoValidate == false ? 55 : 70,
      padding: EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: nameController,
        onFieldSubmitted: (String value) {
          nameController.text = value;
        },
        onTap: () {
          onTapCalendar();
        },
        readOnly: readOnly,
        validator: (value) => value.isEmpty ? '* required' : null,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: cViolet),
          ),
          border: OutlineInputBorder(),
          labelText: '$labeltext',
          prefixIcon: Icon(
            icon,
            color: Colors.black.withOpacity(0.4),
          ),
        ),
      ),
    );
  }
}
