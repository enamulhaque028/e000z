import 'package:dil_app/api/db/db_provider.dart';
import 'package:dil_app/custom/custom_card_view.dart';
import 'package:dil_app/custom/custom_dialogue.dart';
import 'package:dil_app/custom/custom_timeline_widget.dart';
import 'package:dil_app/model/client_info_model.dart';
import 'package:dil_app/pages/chart/chart.dart';
import 'package:flutter/material.dart';
import 'package:dil_app/config/common_const.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClosedPage extends StatefulWidget {
  @override
  _ClosedPageState createState() => _ClosedPageState();
}

class _ClosedPageState extends State<ClosedPage> {
  DBProvider dbService = DBProvider();
  List<ClientInfo> clients;
  List<ClientInfo> displayClients;
  var isLoading = true;
  bool isSearching = false;
  final TextEditingController _controller = TextEditingController();
  String title;
  String days;
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  Future getRespFromSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    days = prefs.getString('days').toString();
    title = prefs.getString('title').toString();
  }

  @override
  void initState() {
    getRespFromSP().then((value) {
      dbService.getClosedTicketsByDate('9', days).then((data) {
        setState(() {
          clients = data;
          displayClients = clients;
          isLoading = false;
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var titleFromSettings = isLoading
        ? ''
        : title.toString() == 'null'
            ? 'Last 3 months'
            : title;
    return Scaffold(
      appBar: buildAppBar(titleFromSettings),
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            header: WaterDropMaterialHeader(),
            onRefresh: () async {
              await dbService.getClosedTicketsByDate('9', days).then((data) {
                setState(() {
                  clients = data;
                  displayClients = clients;
                });
              });
              _refreshController.refreshCompleted();
            },
            child: displayClients.isEmpty
                ? Center(
                    child: Image.asset('assets/images/no_records.png'),
                  )
                : ListView.builder(
                    itemCount: displayClients.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        //padding: EdgeInsetsDirectional.only(top: 1),
                        child: Row(
                          children: <Widget>[
                            CustomTimeLine(
                              height: 160,
                            ),
                            Expanded(
                              flex: 12,
                              child: Container(
                                padding: EdgeInsets.only(right: 5),
                                height: 170,
                                child: InkWell(
                                  child: CustomCardView(
                                    createdDate:'${displayClients[index].tICKETGDT.toString()}',
                                    closedDate: '${displayClients[index].uPDATEDAT.toString()}',
                                    status:'${displayClients[index].tICKSTATUS.toString()}',
                                    priority:'${displayClients[index].tPRIORITY.toString()}',
                                    ticketId:'${displayClients[index].cTICKETID.toString()}',
                                    ticketTitle:'${displayClients[index].cSTTITLES.toString()}',
                                    projectName:'${displayClients[index].pROJTNAME.toString()}',
                                    clientName:'${displayClients[index].cLINTNAME.toString()}',
                                    description:'${displayClients[index].tICKETDESC.toString()}',
                                    ticketNo:'${displayClients[index].tICKETUDID.toString()}',
                                    ticketReqMode:'${displayClients[index].tREQMODE.toString()}',
                                  ),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      useRootNavigator: false,
                                      builder: (context) => CustomDialogue(
                                        displayClients: displayClients,
                                        index: index,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
    );
  }

  buildAppBar(String appbarTitle) {
    return AppBar(
      backgroundColor: Color(PrimaryColor),
      brightness: Brightness.dark,
      leading: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ChartPage()));
        },
        child: Icon(Icons.arrow_back),
      ),
      title: !isSearching
          ? Text(
              'Closed Ticket List ($appbarTitle)',
              style: TextStyle(fontSize: 17),
            )
          : TextField(
              controller: _controller,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  _controller.clear();
                }
              },
              onChanged: (text) async {
                text = text.toLowerCase();

                setState(() {
                  displayClients = clients.where((value) {
                    var projectNameTile =
                        value.pROJTNAME.toString().toLowerCase();
                    var cstTitlesTile =
                        value.cSTTITLES.toString().toLowerCase();
                    var ticketPriorityTile =
                        value.tPRIORITY.toString().toLowerCase();
                    var ticketStatusTile =
                        value.tICKSTATUS.toString().toLowerCase();
                    var ticketDateTile =
                        value.tICKETGDT.toString().toLowerCase();
                    var ticketIdTile = value.cTICKETID.toString().toLowerCase();
                    var ticketNo = value.tICKETUDID.toString().toLowerCase();
                    var reqMode = value.tREQMODE.toString().toLowerCase();
                    return projectNameTile.contains(text) ||
                        cstTitlesTile.contains(text) ||
                        ticketPriorityTile.contains(text) ||
                        ticketStatusTile.contains(text) ||
                        ticketDateTile.contains(text) ||
                        ticketIdTile.contains(text) ||
                        ticketNo.contains(text) ||
                        reqMode.contains(text);
                  }).toList();
                });
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                // icon: Icon(
                //   Icons.search,
                //   color: Colors.white,
                // ),
                hintText: "Search Here",
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
      actions: <Widget>[
        Row(
          children: [
            Container(
              child: isSearching
                  ? IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () async {
                        _controller.text = "";
                        //var data = await dbProvider.getProductsByCategory('P');
                        setState(() {
                          this.isSearching = false;
                          displayClients = clients;
                        });
                      },
                    )
                  : IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        setState(() {
                          this.isSearching = true;
                        });
                      },
                    ),
            ),
          ],
        ),
      ],
    );
  }
}
