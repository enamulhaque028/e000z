import 'package:flutter/material.dart';
import 'package:health_line_bd/widgets/timeline_widget.dart';

class UserInfoTile extends StatelessWidget {
  final String title;
  final String info;
  final Function onTap;

  UserInfoTile({@required this.title, @required this.info, this.onTap});

  @override
  Widget build(BuildContext context) {
    return info.toString() == ''
        ? Container()
        : Row(
            children: [
              CustomTimeLine(height: 50),
              SizedBox(
                width: 5.0,
              ),
              Expanded(
                flex: 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      info,
                      style: TextStyle(fontSize: 18),
                    ),
                    Divider(
                      thickness: 1.0,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
              // IconButton(
              //     icon: Icon(
              //       FontAwesomeIcons.edit,
              //       size: 15,
              //     ),
              //     onPressed: () {
              //       onTap();
              //     })
            ],
          );
  }
}
