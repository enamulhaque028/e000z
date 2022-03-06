import 'package:flutter/material.dart';
import 'package:mediinfo/config/CommonConstant.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key key,
    @required this.textFieldController,
    this.labelText = 'Enter name',
    this.disableTextField = false,
    this.isRequiredValidation = true,
    this.onTapLocation,
    this.maxLines = 1,
  }) : super(key: key);

  final TextEditingController textFieldController;
  final String labelText;
  final bool disableTextField;
  final bool isRequiredValidation;
  final VoidCallback onTapLocation;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: _autoValidate == false ? 55 : 70,
      padding: EdgeInsets.only(top: 10),
      child: TextFormField(
        readOnly: disableTextField,
        controller: textFieldController,
        maxLines: maxLines,
        onFieldSubmitted: (String value) {
          textFieldController.text = value;
        },
        validator: (value) => isRequiredValidation
            ? value.isEmpty
                ? 'newPharmacyRequest.required'.tr().toString()
                : null
            : null,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: cViolet),
          ),
          border: OutlineInputBorder(),
          labelText: labelText,
          suffixIcon: disableTextField
              ? IconButton(
                  icon: Icon(Icons.location_on),
                  color: Colors.green,
                  onPressed: () {
                    onTapLocation();
                  },
                )
              : Icon(
                  Icons.location_on,
                  size: 0,
                  color: Colors.transparent,
                ),
        ),
      ),
    );
  }
}

class CustomTextFieldMobile extends StatelessWidget {
  const CustomTextFieldMobile({
    Key key,
    @required this.textFieldController,
    @required this.labelText,
  }) : super(key: key);

  final TextEditingController textFieldController;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    String patttern =
        r'^(?:\+?88)?01[3-9]\d{8}$'; //validation all BD Mobile Operator
    RegExp regExp = new RegExp(patttern);
    return Container(
      // height: _autoValidate == false ? 55 : 70,
      padding: EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: textFieldController,
        keyboardType: TextInputType.number,
        onFieldSubmitted: (String value) {
          textFieldController.text = value;
        },
        // validator: (value) => value.isEmpty ? '* required' : null,
        validator: (value) => value.isEmpty
            ? 'newPharmacyRequest.required'.tr().toString()
            : regExp.hasMatch(textFieldController.text)
                ? null
                : 'newPharmacyRequest.phoneRequired'.tr().toString(),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: cViolet),
          ),
          border: OutlineInputBorder(),
          labelText: labelText,
          // prefixIcon: Icon(Icons.phone),
        ),
      ),
    );
  }
}
