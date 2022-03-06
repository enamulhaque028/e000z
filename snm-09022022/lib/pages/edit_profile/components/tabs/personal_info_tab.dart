import 'package:dil_app/pages/edit_profile/components/custom_text_field.dart';
import 'package:dil_app/pages/edit_profile/components/profile_text_tile.dart';
import 'package:flutter/material.dart';

class PersonalInfoTab extends StatefulWidget {
  const PersonalInfoTab({Key key}) : super(key: key);

  @override
  _PersonalInfoTabState createState() => _PersonalInfoTabState();
}

class _PersonalInfoTabState extends State<PersonalInfoTab> {
  String email = 'enamulhaque028@gmail.com';
  String phone = '+8801843498350';
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  bool isEnableEditEmail = false;
  bool isEnableEditPhone = false;
  @override
    void initState() {
      emailController.text = email;
      phoneController.text = phone;
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileTextTile(
          title: 'Username',
          subTitle: 'enamulhaque028',
          isVisibleEdit: false,
          onTapEdit: () {},
        ),
        ProfileTextTile(
          title: 'Department',
          subTitle: 'Mobile Apps',
          isVisibleEdit: false,
          onTapEdit: () {},
        ),
        !isEnableEditEmail ? ProfileTextTile(
          title: 'Email',
          subTitle: email,
          onTapEdit: () {
            setState(() {
              isEnableEditEmail = true;
            });
          },
        ) : CustomTextFieldProfile(
            textEditingController: emailController,
            placeholderText: 'Edit Email',
            horizontalPadding: 4,
            onFieldSubmitted: (value) {
              setState(() {
                isEnableEditEmail= false;
                email = emailController.text;
              });
            },
          ),
        !isEnableEditPhone ? ProfileTextTile(
          title: 'Phone',
          subTitle: '+8801843498350',
          onTapEdit: () {
            setState(() {
              isEnableEditPhone = true;
            });
          },
        ) : CustomTextFieldProfile(
            textEditingController: phoneController,
            placeholderText: 'Edit Phone',
            horizontalPadding: 4,
            onFieldSubmitted: (value) {
              setState(() {
                isEnableEditPhone= false;
                phone = phoneController.text;
              });
            },
          ),
      ],
    );
  }
}
