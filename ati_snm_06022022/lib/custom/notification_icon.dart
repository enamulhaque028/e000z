import 'package:dil_app/api/db/notification_provider.dart';
import 'package:dil_app/model/notification_model.dart';
import 'package:dil_app/pages/chart/notification_dialogue.dart';
import 'package:flutter/material.dart';

class NamedIcon extends StatefulWidget {
  final IconData iconData;
  final String text;

  const NamedIcon({
    Key key,
    @required this.text,
    @required this.iconData,
  }) : super(key: key);

  @override
  _NamedIconState createState() => _NamedIconState();
}

class _NamedIconState extends State<NamedIcon> {
  NotificationDBProvider dbProvider = NotificationDBProvider();
  List<NotificationData> displayNotification = [];
  @override
  void initState() {
    dbProvider.getNotificationData().then((data) {
      setState(() {
        displayNotification = data;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var data = await dbProvider.getNotificationData();
        setState(() {
          displayNotification = data;
          // displayNotification.length = 0;
        });
        showDialog(
          context: context,
          useRootNavigator: false,
          builder: (context) => NotificationDialogue(),
        );
      },
      child: Container(
        width: 72,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(widget.iconData),
                Text(widget.text, overflow: TextOverflow.ellipsis),
              ],
            ),
            Positioned(
              top: 0,
              right: 2,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                alignment: Alignment.center,
                child: Text('${displayNotification.length.toString()}'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
