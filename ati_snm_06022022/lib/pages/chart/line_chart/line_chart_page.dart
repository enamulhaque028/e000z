import 'package:dil_app/api/db/db_provider.dart';
import 'package:dil_app/model/client_info_model.dart';
import 'package:dil_app/pages/chart/chart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class LineChartPage extends StatefulWidget {
  final String days;
  const LineChartPage({Key key, @required this.days}) : super(key: key);

  @override
  _LineChartPageState createState() => _LineChartPageState();
}

class _LineChartPageState extends State<LineChartPage> {
  bool isLoading = true;
  List<charts.Series> prioritySeriesListLineChart;
  List<charts.Series> statusSeriesListLineChart;

  Future<List<charts.Series<CountPriority, int>>>
      _priorityCreateLineChart() async {
    var dbService = DBProvider();
    var data = await dbService.tPriorityCount(widget.days);
    return [
      charts.Series<CountPriority, int>(
        id: 'TableDataUnani',
        domainFn: (CountPriority data, _) => int.parse(
            data.tKTPRIID), //if "tKTPRIID == null" then graph not working
        //domainFn: (CountPriority data, _) => data.count,
        measureFn: (CountPriority data, _) => data.count,
        data: data,
        colorFn: (CountPriority data, _) {
          if (data.tKTPRIID == "1") {
            return charts.ColorUtil.fromDartColor(
              Color(0xffdc3912),
            );
          } else if (data.tKTPRIID == "2") {
            return charts.ColorUtil.fromDartColor(
              Color(0xff3366cc),
            );
          } else if (data.tKTPRIID == "3") {
            return charts.ColorUtil.fromDartColor(
              Color(0xfffdbe19),
            );
          } else if (data.tKTPRIID == "4") {
            return charts.ColorUtil.fromDartColor(
              Color(0xff7CFC00),
            );
          } else if (data.tKTPRIID == "5") {
            return charts.ColorUtil.fromDartColor(
              Colors.purple,
            );
          }
          return charts.ColorUtil.fromDartColor(
            Color(0xffdc3912),
          );
        },
      ),
    ];
  }

  Future<List<charts.Series<CountStatus, int>>> _statusCreateLineChart() async {
    var dbService = DBProvider();
    var data = await dbService.tStatusCount(widget.days);
    return [
      charts.Series<CountStatus, int>(
        id: 'TableDataUnani',
        domainFn: (CountStatus data, _) => data.count,
        measureFn: (CountStatus data, _) => data.count,
        data: data,
        colorFn: (CountStatus data, _) {
          if (data.tKTSTUSID == "1") {
            return charts.ColorUtil.fromDartColor(
              Color(0xff3366cc),
            );
          } else if (data.tKTSTUSID == "2") {
            return charts.ColorUtil.fromDartColor(
              Colors.amber,
            );
          } else if (data.tKTSTUSID == "3") {
            return charts.ColorUtil.fromDartColor(
              Colors.purple,
            );
          } else if (data.tKTSTUSID == "4") {
            return charts.ColorUtil.fromDartColor(
              Colors.grey,
            );
          } else if (data.tKTSTUSID == "5") {
            return charts.ColorUtil.fromDartColor(
              Colors.red,
            );
          } else if (data.tKTSTUSID == "9") {
            return charts.ColorUtil.fromDartColor(
              Colors.green,
            );
          }
          return charts.ColorUtil.fromDartColor(
            Color(0xffdc3912),
          );
        },
      ),
    ];
  }

  @override
  void initState() {
    _priorityCreateLineChart().then((value) {
      setState(() {
        prioritySeriesListLineChart = value;
      });
    }).then((value) {
      _statusCreateLineChart().then((value) {
        setState(() {
          statusSeriesListLineChart = value;
          isLoading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: <Widget>[
                  ValueListenableBuilder(
                    valueListenable: switchValue,
                    builder: (context, value, widget) {
                      return Expanded(
                        child: value == false
                            ? charts.LineChart(
                                prioritySeriesListLineChart,
                                animate: true,
                                animationDuration: Duration(seconds: 3),
                                defaultRenderer: new charts.LineRendererConfig(
                                  //includeArea: true,
                                  stacked: true,
                                  includePoints: true,
                                ),
                                behaviors: [
                                  new charts.ChartTitle('Priority',
                                      behaviorPosition:
                                          charts.BehaviorPosition.bottom,
                                      titleOutsideJustification: charts
                                          .OutsideJustification.middleDrawArea),
                                  // new charts.ChartTitle('Sales',
                                  //     behaviorPosition: charts.BehaviorPosition.start,
                                  //     titleOutsideJustification:
                                  //         charts.OutsideJustification.middleDrawArea),
                                ],
                              )
                            : charts.LineChart(
                                statusSeriesListLineChart,
                                animate: true,
                                animationDuration: Duration(seconds: 3),
                                defaultRenderer: new charts.LineRendererConfig(
                                  //includeArea: true,
                                  stacked: true,
                                  includePoints: true,
                                ),
                                behaviors: [
                                  new charts.ChartTitle('Status',
                                      behaviorPosition:
                                          charts.BehaviorPosition.bottom,
                                      titleOutsideJustification: charts
                                          .OutsideJustification.middleDrawArea),
                                  // new charts.ChartTitle('Sales',
                                  //     behaviorPosition: charts.BehaviorPosition.start,
                                  //     titleOutsideJustification:
                                  //         charts.OutsideJustification.middleDrawArea),
                                ],
                              ),
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
