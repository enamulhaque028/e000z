import 'dart:developer';
import 'package:dil_app/pages/edit_profile/components/custom_text_field.dart';
import 'package:flutter/material.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({Key key}) : super(key: key);

  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  bool isEnableEditName = false;
  bool isEnableEditDesignation = false;
  String name = 'Md. Enamul Haque';
  String designation = 'Software Developer';
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController designationController = new TextEditingController();
  @override
  void initState() {
    nameController.text = name;
    designationController.text = designation;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipOval(
                child: Image.network(
                  'https://enamulhaque028.github.io/profile/img/profile.jpg',
                  height: 180,
                  width: 180,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: -10,
                top: 35,
                child: InkWell(
                  onTap: () {
                    log('object');
                  },
                  child: Image.asset(
                    'assets/images/camera.png',
                    height: 40,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          !isEnableEditName
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: (){
                        setState(() {
                          isEnableEditName = true;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Image.asset('assets/images/edit.png', height: 25),
                      ),
                    ),
                  ],
                )
              : CustomTextFieldProfile(
                  textEditingController: nameController,
                  placeholderText: 'Edit Name',
                  onFieldSubmitted: (value) {
                    setState(() {
                      isEnableEditName = false;
                      name = nameController.text;
                    });
                  },
                ),
          SizedBox(height: 8),
          !isEnableEditDesignation
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Software Developer',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isEnableEditDesignation = true;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Image.asset('assets/images/edit.png', height: 25),
                      ),
                    ),
                  ],
                )
              : CustomTextFieldProfile(
                  textEditingController: designationController,
                  placeholderText: 'Edit Designation',
                  onFieldSubmitted: (value) {
                    setState(() {
                      isEnableEditDesignation = false;
                      designation = designationController.text;
                    });
                  },
                ),
        ],
      ),
    );
  }
}
