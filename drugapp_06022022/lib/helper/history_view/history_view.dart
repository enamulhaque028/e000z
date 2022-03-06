import 'package:flutter/material.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({
    Key key,
    @required this.productname,
    @required this.onTap,
    @required this.onLongPress,
  }) : super(key: key);

  final String productname;
  final Function onTap;
  final Function onLongPress;

  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          widget.onTap();
        },
        onLongPress: () {
          widget.onLongPress();
        },
        child: new Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: new Center(
            child: new Text(
              widget.productname,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
      ),
    );
  }
}
