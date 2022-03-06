import 'package:ati_ams/pages/home/history/view/history_item_view.dart';
import 'package:ati_ams/widgets/custom_timeline.dart';
import 'package:flutter/material.dart';

class HistoryView extends StatelessWidget {
  final String info1, info2, info3, info4, info5;
  final bool hasGivenAttendance;
  const HistoryView({
    Key key,
    @required this.info1,
    @required this.info2,
    @required this.info3,
    @required this.info4,
    @required this.info5,
    @required this.hasGivenAttendance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        // top: 8.0,
        left: 8.0,
        right: 8.0,
      ),
      child: Row(
        children: [
          CustomTimeLine(height: 155),
          SizedBox(width: 8.0),
          Expanded(
            child: Container(
              height: 170,
              width: double.infinity,
              child: Card(
                // margin: EdgeInsets.only(bottom: 8),
                elevation: 0.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          HistoryItemView(title: info1),
                          HistoryItemView(title: info2),
                          HistoryItemView(title: info3),
                          HistoryItemView(title: info4),
                          (info5 == '' || info5 == 'null')
                              ? Container()
                              : HistoryItemView(title: '$info5 (Out time)'),
                        ],
                      ),
                      hasGivenAttendance
                          ? Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                            )
                          : Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
