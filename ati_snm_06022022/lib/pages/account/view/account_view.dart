import 'package:flutter/material.dart';
import 'account_item_view.dart';

class AccountView extends StatelessWidget {
  final String name, mobileNo, projectName, department, designation;
  const AccountView({
    Key key,
    @required this.name,
    @required this.mobileNo,
    @required this.projectName,
    @required this.department,
    @required this.designation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        // top: 8.0,
        left: 8.0,
        right: 8.0,
      ),
      child: Card(
        color: Color(0xFFe6f2ff),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              name == 'null' ? Container() : AccountItemView(title: name),
              mobileNo == 'null'
                  ? Container()
                  : AccountItemView(title: mobileNo),
              projectName == 'null'
                  ? Container()
                  : AccountItemView(title: projectName),
              department == 'null'
                  ? Container()
                  : AccountItemView(title: department),
              designation == 'null'
                  ? Container()
                  : AccountItemView(title: designation),
            ],
          ),
        ),
      ),
    );
  }
}
