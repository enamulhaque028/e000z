import 'package:dil_app/pages/edit_profile/components/profile_info.dart';
import 'package:dil_app/pages/edit_profile/components/tabs/company_info_tab.dart';
import 'package:dil_app/pages/edit_profile/components/tabs/credential_info_tab.dart';
import 'package:dil_app/pages/edit_profile/components/tabs/personal_info_tab.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> with SingleTickerProviderStateMixin {
  TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.white,
        toolbarHeight: 10,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Icon(Icons.arrow_back),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30.0),
                    child: Text(
                      'USER PROFILE',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(),
                ],
              ),
              ProfileInfo(),
              Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey[100],
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: new TabBar(
                      controller: _controller,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      tabs: [
                        new Tab(
                          text: 'PERSONAL',
                        ),
                        new Tab(
                          text: 'COMPANY',
                        ),
                        new Tab(
                          text: 'CREDENTIALS',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: 350.0,
                child: new TabBarView(
                  controller: _controller,
                  children: <Widget>[
                    PersonalInfoTab(),
                    CompanyInfoTab(),
                    CredentialInfoTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}