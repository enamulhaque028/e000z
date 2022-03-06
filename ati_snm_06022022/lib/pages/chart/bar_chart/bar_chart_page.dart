import 'package:dil_app/api/db/db_provider.dart';
import 'package:dil_app/model/client_info_model.dart';
import 'package:dil_app/pages/chart/chart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BarChartPage extends StatefulWidget {
  final String days;
  const BarChartPage({Key key, @required this.days}) : super(key: key);

  @override
  _BarChartPageState createState() => _BarChartPageState();
}

class _BarChartPageState extends State<BarChartPage> {
  bool isLoading = true;
  List<charts.Series> prioritySeriesListBarChart;
  List<charts.Series> statusSeriesListBarChart;

  Future<List<charts.Series<CountPriority, String>>>
      _priorityCreateBarChart() async {
    var dbService = DBProvider();
    var data = await dbService.tPriorityCount(widget.days);
    //log(data[0].tICKSTATUS.toString());
    return [
      charts.Series<CountPriority, String>(
        id: 'TableDataBarPie',
        domainFn: (CountPriority data, _) => data.tPRIORITY.toString(),
        measureFn: (CountPriority data, _) => data.count,
        data: data,
        //labelAccessorFn: (TableData data, _) => data.month,
        labelAccessorFn: (CountPriority data, _) => data.tPRIORITY.toString(),
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

  Future<List<charts.Series<CountStatus, String>>>
      _statusCreateBarChart() async {
    var dbService = DBProvider();
    var data = await dbService.tStatusCount(widget.days);
    //log(data[0].tICKSTATUS.toString());
    return [
      charts.Series<CountStatus, String>(
        id: 'TableDataBarPie',
        domainFn: (CountStatus data, _) => data.tICKSTATUS.toString(),
        measureFn: (CountStatus data, _) => data.count,
        data: data,
        //labelAccessorFn: (TableData data, _) => data.month,
        labelAccessorFn: (CountStatus data, _) => data.tICKSTATUS.toString(),
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
    _priorityCreateBarChart().then((value) {
      setState(() {
        prioritySeriesListBarChart = value;
      });
    }).then((value) {
      _statusCreateBarChart().then((value) {
        setState(() {
          statusSeriesListBarChart = value;
          isLoading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
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
                              ? prioritySeriesListBarChart[0].data.isEmpty
                              ? Center(child: Image.asset('assets/images/no_records.png'))
                              : charts.BarChart(
                                  prioritySeriesListBarChart,
                                  animate: true,
                                  animationDuration: Duration(seconds: 3),
                                  //vertical: false,
                                  barGroupingType: charts.BarGroupingType.grouped,
                                  defaultRenderer: charts.BarRendererConfig(
                                    groupingType: charts.BarGroupingType.grouped,
                                    strokeWidthPx: 1.0,
                                  ),
                                )
                              : statusSeriesListBarChart[0].data.isEmpty
                              ? Center(child: Image.asset('assets/images/no_records.png'))
                              : charts.BarChart(
                                  statusSeriesListBarChart,
                                  animate: true,
                                  animationDuration: Duration(seconds: 3),
                                  //vertical: false,
                                  barGroupingType: charts.BarGroupingType.grouped,
                                  defaultRenderer: charts.BarRendererConfig(
                                    groupingType: charts.BarGroupingType.grouped,
                                    strokeWidthPx: 1.0,
                                  ),
                                ),
                        );
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
