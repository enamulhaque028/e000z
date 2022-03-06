import 'package:dil_app/api/account_service.dart';
import 'package:dil_app/config/common_const.dart';
import 'package:dil_app/model/account_model.dart';
import 'package:dil_app/pages/account/create_account_page.dart';
import 'package:dil_app/pages/account/view/account_view.dart';
import 'package:flutter/material.dart';

class AccountListPage extends StatefulWidget {
  const AccountListPage({Key key}) : super(key: key);

  @override
  _AccountListPageState createState() => _AccountListPageState();
}

class _AccountListPageState extends State<AccountListPage> {
  AccountModel accountData = new AccountModel();
  bool isLoading = true;

  @override
  void initState() {
    AccountService().fetchAccountData().then((value) {
      setState(() {
        accountData = value;
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Request for Account'),
        brightness: Brightness.dark,
        backgroundColor: Color(PrimaryColor),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : accountData.result.isEmpty
          ? Center(child: Image.asset('assets/images/no_records.png'))
          : ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8),
              itemCount: accountData.result.length,
              itemBuilder: (context, index) {
                var accountInfo = accountData.result[index];
                return AccountView(
                  name: accountInfo.cltcpName.toString(),
                  mobileNo: accountInfo.ccpMobile.toString(),
                  projectName: accountInfo.cltcpemail.toString(),
                  department: accountInfo.deprtName.toString(),
                  designation: accountInfo.desigName.toString(),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateAccountPage(),
            ),
          );
        },
        backgroundColor: Color(PrimaryColor),
        child: Icon(Icons.add),
      ),
    );
  }
}
