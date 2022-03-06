import 'dart:developer';
import 'package:cool_alert/cool_alert.dart';
import 'package:dil_app/api/client_info_service.dart';
import 'package:dil_app/api/db/db_provider.dart';
import 'package:dil_app/config/common_const.dart';
import 'package:dil_app/model/client_info_model.dart';
import 'package:dil_app/pages/chart/summary_page/details/summary_details_page.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SummaryView extends StatefulWidget {
  final String days;

  const SummaryView({
    Key key,
    @required this.days,
  }) : super(key: key);

  @override
  _SummaryViewState createState() => _SummaryViewState();
}

class _SummaryViewState extends State<SummaryView> {
  List<CountStatusByDate> statusData = [];
  List<CountPriorityByDate> priorityData = [];
  var isLoading = true;
  final Shader linearGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    tileMode: TileMode.mirror,
    colors: <Color>[Colors.blueGrey[100], Colors.blueGrey],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  @override
  void initState() {
    log('Days: ${widget.days}');
    DBProvider().getTicketStatusByDate(widget.days).then((value) {
      setState(() {
        statusData = value;
        addAdditionalStatusData();
      });
    }).then((value) {
      DBProvider().getTicketPriorityByDate(widget.days).then((value) {
        setState(() {
          priorityData = value;
          addAdditionalPriorityData();
          isLoading = false;
        });
      });
      setState(() {
        statusData.sort((a, b) => a.tKTSTUSID.compareTo(b.tKTSTUSID));
      });
    });
    super.initState();
  }

  Future addAdditionalStatusData() async {
    int getStatus(String id) {
      var open = statusData.where((value) => value.tKTSTUSID == id).toList();
      return open.length;
    }

    getStatus('1') == 0
        ? statusData.addAll({CountStatusByDate(count: 0, tICKSTATUS: 'Open', tKTSTUSID: '1')})
        : Container();
    if (getStatus('3') == 0 && getStatus('2') == 0) {
      statusData.addAll({CountStatusByDate(count: 0, tICKSTATUS: 'Work In Progress / On Hold', tKTSTUSID: '3')});
    } else {
      getStatus('3') == 0
          ? statusData.addAll({CountStatusByDate(count: 0, tICKSTATUS: 'Work In Progress', tKTSTUSID: '3')})
          : Container();
      getStatus('2') == 0
          ? statusData.addAll({CountStatusByDate(count: 0, tICKSTATUS: 'On Hold', tKTSTUSID: '2')})
          : Container();
    }
    if (getStatus('4') == 0 && getStatus('5') == 0) {
      statusData.addAll({CountStatusByDate(count: 0, tICKSTATUS: 'Resolved/Not Resolved', tKTSTUSID: '4')});
    } else {
      getStatus('4') == 0
          ? statusData.addAll({CountStatusByDate(count: 0, tICKSTATUS: 'Resolved', tKTSTUSID: '4')})
          : Container();
      getStatus('5') == 0
          ? statusData.addAll({CountStatusByDate(count: 0, tICKSTATUS: 'Not Resolved', tKTSTUSID: '5')})
          : Container();
    }
    getStatus('9') == 0
        ? statusData.addAll({CountStatusByDate(count: 0, tICKSTATUS: 'Closed', tKTSTUSID: '9')})
        : Container();
  }

  addAdditionalPriorityData() {
    int getPriority(String id) {
      var open = priorityData.where((value) => value.tKTPRIID == id).toList();
      return open.length;
    }

    getPriority('1') == 0
        ? priorityData.addAll({CountPriorityByDate(count: 0, ticketPriority: 'Critical / Urgent')})
        : Container();
    getPriority('2') == 0
        ? priorityData.addAll({CountPriorityByDate(count: 0, ticketPriority: 'Major / High')})
        : Container();
    getPriority('3') == 0
        ? priorityData.addAll({CountPriorityByDate(count: 0, ticketPriority: 'Minor / Medium')})
        : Container();
    getPriority('4') == 0
        ? priorityData.addAll({CountPriorityByDate(count: 0, ticketPriority: 'Trivial / Low')})
        : Container();
    // getStatus('5') == 0
    //     ? priorityData.addAll({CountPriorityByDate(count: 0, ticketPriority: 'Not Defined Yet')})
    //     : Container();
  }

  @override
  Widget build(BuildContext context) {
    
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Center(
          child: SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            //enablePullUp: true,
            header: WaterDropMaterialHeader(),
            onRefresh: () async {
              ClientApiProvider().getAllEmployees().then((res) {
                log('::::::::::::::::::::::::::::::::CALLED CLIENT SERVICE:::::::::::::::::::::::::::::::::');
                Future.delayed(Duration(seconds: 2), () async {
                    await DBProvider().getTicketStatusByDate(widget.days).then((value) {
                    setState(() {
                      statusData = value;
                      addAdditionalStatusData();
                    });
                  }).then((value) {
                    DBProvider().getTicketPriorityByDate(widget.days).then((value) {
                      setState(() {
                        priorityData = value;
                        addAdditionalPriorityData();
                        isLoading = false;
                      });
                    });
                    setState(() {
                      statusData.sort((a, b) => a.tKTSTUSID.compareTo(b.tKTSTUSID));
                    });
                  });
                  _refreshController.refreshCompleted();
                });
              });
            },
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Container(),
                  SizedBox(height: 16),
                  statusData.isEmpty
                      ? Center(child: Text('No status history found!'))
                      : Card(
                        elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Container(
                                // decoration: BoxDecoration(
                                //   borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                                //   color: cViolet,
                                //   // image: DecorationImage(image: NetworkImage('http://www.textures4photoshop.com/tex/thumbs/animated-sparkle-overlay-for-photoshop-thumb38.gif'), fit: BoxFit.cover)
                                // ),
                                height: (statusData.length * 62).toDouble(),
                                width: 50,
                                child: RotatedBox(
                                  quarterTurns: -1,
                                  child: Center(
                                    child: Text(
                                      'STATUS',
                                      style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold, foreground: Paint()..shader = linearGradient),
                                    ),
                                  ),
                                ),
                              ),
                              Container(color: Colors.green, height: (statusData.length * 62 + 16).toDouble(), width: 1),
                              Expanded(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: Divider(),
                                    ),
                                    ListView.builder(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: statusData.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        String ticketStatusId = statusData[index].tKTSTUSID.toString();
                                        Color textColor = ticketStatusId == '1'
                                        ? Color(0xff3366cc)
                                        : ticketStatusId == '2'
                                        ? Colors.amber
                                        : ticketStatusId == '3'
                                        ? Colors.purple
                                        : ticketStatusId == '4'
                                        ? Colors.grey
                                        : ticketStatusId == '5'
                                        ? Colors.red
                                        : ticketStatusId == '9'
                                        ? Colors.green
                                        : Colors.grey;
                                        return InkWell(
                                          onTap: (){
                                            if(statusData[index].count == 0){
                                              // CoolAlert.show(context: context, type: CoolAlertType.info, text: 'Not found!');
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text('Not found!'), duration: Duration(seconds: 1)),
                                              );
                                            } else {
                                              Navigator.push(context, MaterialPageRoute(
                                                builder: (context) => SummaryDetailsPage(ticketStatusId: ticketStatusId, ticketPriorityId: '', passDate: widget.days)));
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      '${statusData[index].tICKSTATUS.toString()}',
                                                      style: TextStyle(color: textColor),
                                                    ),
                                                    Container(
                                                      width: 30,
                                                      height: 30,
                                                      decoration: BoxDecoration(color: cViolet,shape: BoxShape.circle),
                                                      child: Center(
                                                        child: Text(
                                                          '${statusData[index].count.toString()}',
                                                          style: TextStyle(color: Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Divider(),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                  // SizedBox(height: 16),
                  priorityData.isEmpty
                      ? Center(child: Text('No priority history found!'))
                      : Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: [
                                Container(
                                  // decoration: BoxDecoration(
                                  //   borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                                  //   color: Color(PrimaryColor),
                                  //   // image: DecorationImage(image: NetworkImage('http://www.textures4photoshop.com/tex/thumbs/animated-sparkle-overlay-for-photoshop-thumb38.gif'), fit: BoxFit.cover)
                                  // ),
                                  height: (priorityData.length * 62).toDouble(),
                                  width: 50,
                                  child: RotatedBox(
                                    quarterTurns: -1,
                                    child: Center(
                                      child: Text(
                                        'PRIORITY',
                                        style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold, foreground: Paint()..shader = linearGradient),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(color: Color(PrimaryColor), height: (priorityData.length * 62 + 16).toDouble(), width: 1),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                        child: Divider(),
                                      ),
                                      ListView.builder(
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: priorityData.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          String ticketPriorityId =  priorityData[index].tKTPRIID.toString();
                                          Color textColor = ticketPriorityId =='1'
                                          ? Color(0xffdc3912)
                                          : ticketPriorityId == '2'
                                          ? Color(0xff3366cc)
                                          : ticketPriorityId =='3'
                                          ? Color(0xfffdbe19)
                                          : ticketPriorityId =='4'
                                          ? Color(0xff7CFC00)
                                          : ticketPriorityId =='5'
                                          ? Colors.purple
                                          : Colors.grey;
                                          return InkWell(
                                            onTap: (){
                                            if(priorityData[index].count == 0){
                                              // CoolAlert.show(context: context, type: CoolAlertType.info, text: 'Not found!');
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(content: Text('Not found!'), duration: Duration(seconds: 1)),
                                              );
                                            } else {
                                              Navigator.push(context, MaterialPageRoute(
                                                builder: (context) => SummaryDetailsPage(ticketPriorityId: ticketPriorityId, ticketStatusId: '', passDate: widget.days)));
                                            }
                                          },
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        '${priorityData[index].ticketPriority.toString()}',
                                                        style: TextStyle(color: textColor),
                                                      ),
                                                      Container(
                                                          width: 30,
                                                          height: 30,
                                                          decoration: BoxDecoration(
                                                            color:Color(PrimaryColor),
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              '${priorityData[index].count.toString()}',
                                                              style: TextStyle(color: Colors.white),
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                  Divider()
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                  // Container(),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ),
        );
  }
}
