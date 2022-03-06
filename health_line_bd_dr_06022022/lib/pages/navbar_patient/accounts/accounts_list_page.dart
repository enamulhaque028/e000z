import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:health_line_bd/config/common_const.dart';
import 'package:health_line_bd/model/lis/accounts_model.dart';
import 'package:health_line_bd/pages/navbar_patient/profile/user_profile.dart';
import 'package:health_line_bd/services/lis/account_service.dart';
import 'components/account_list_view.dart';

class AccountsListPage extends StatefulWidget {
  const AccountsListPage({Key key}) : super(key: key);

  @override
  _AccountsListPageState createState() => _AccountsListPageState();
}

class _AccountsListPageState extends State<AccountsListPage> {
  Accounts accountInfo = new Accounts();
  var isLoading = true;

  @override
  void initState() {
    AccountService().fetchAccountInfo().then((data) {
      setState(() {
        accountInfo = data;
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        brightness: Brightness.dark,
        centerTitle: true,
        title: Text(
          'Accounts',
          //style: TextStyle(fontSize: 19),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () async {
                // SharedPreferences prefs = await SharedPreferences.getInstance();
                // String profilePhone = prefs.getString('mobileNo');
                // SelectGender.mySelection = null;
                // SelectBloodGroup.mySelection = null;
                // SelectMaritialStatus.mySelection = null;
                // SelectRelation.mySelection = null;
                // ImageUploadService.fileDownloadUrl = '';
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (BuildContext context) => CreateChildAccountPage(
                //       profilePhone: profilePhone,
                //     ),
                //   ),
                // );
              },
              icon: Icon(Icons.add),
            ),
          )
        ],
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(cViolet),
              )
            : Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView.builder(
                    itemCount: accountInfo.pRetrnmsg1.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          accountInfo.pRetrnmsg1[index].approvedfg.toString() ==
                                  '1'
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UserProfile(
                                      isIdFromAccount: true,
                                      pId: accountInfo
                                          .pRetrnmsg1[index].patientId
                                          .toString(),
                                    ),
                                  ),
                                )
                              : CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.info,
                                  title: 'Profile is not available yet!',
                                );
                        },
                        child: AccountListView(
                          name: accountInfo.pRetrnmsg1[index].patientNm
                              .toString(),
                          email: accountInfo.pRetrnmsg1[index].ptemailNo
                              .toString(),
                          bloodGroup: accountInfo.pRetrnmsg1[index].bldgrpTxt
                              .toString(),
                          gender: accountInfo.pRetrnmsg1[index].sorgndrtxt
                              .toString(),
                          phone: accountInfo.pRetrnmsg1[index].pmobileNo
                              .toString(),
                          id: accountInfo.pRetrnmsg1[index].patientId
                              .toString(),
                          birthDate: accountInfo.pRetrnmsg1[index].caldobFmt
                              .toString(),
                          status: accountInfo.pRetrnmsg1[index].approvedfg
                              .toString(),
                          statusDetails:
                              accountInfo.pRetrnmsg1[index].patIdTxt.toString(),
                          imageUrl: accountInfo.pRetrnmsg1[index].photoLoca
                              .toString(),
                        ),
                      );
                    }),
              ),
      ),
    );
  }
}
