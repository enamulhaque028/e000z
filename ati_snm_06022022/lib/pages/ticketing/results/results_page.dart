// import 'package:dil_app/api/client_info_service.dart';
// import 'package:dil_app/api/db/db_provider.dart';
// import 'package:dil_app/api/resolved_service.dart';
// import 'package:dil_app/custom/custom_timeline_widget.dart';
// import 'package:dil_app/model/client_info_model.dart';
// import 'package:flutter/material.dart';
// import 'package:dil_app/config/common_const.dart';
// import 'package:smooth_star_rating/smooth_star_rating.dart';

// class ResultsPage extends StatefulWidget {
//   @override
//   _ResultsPageState createState() => _ResultsPageState();
// }

// class _ResultsPageState extends State<ResultsPage> {
//   DBProvider dbService = DBProvider();
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   List<ClientInfo> clients;
//   List<ClientInfo> displayClients;
//   var isLoading = true;
//   bool isSearching = false;
//   final TextEditingController _controller = TextEditingController();
//   final TextEditingController _commentController = TextEditingController();
//   var rating = 0.0;
//   bool isEnabled = false;

//   @override
//   void initState() {
//     dbService.getAllTickets('4').then((data) {
//       setState(() {
//         clients = data;
//         displayClients = clients;
//         isLoading = false;
//       });
//     });
//     super.initState();
//   }

//   enableButton() {
//     setState(() {
//       isEnabled = true;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       appBar: buildAppBar(),
//       body: isLoading
//           ? Center(
//               child: CircularProgressIndicator(),
//             )
//           : ListView.builder(
//               itemCount: displayClients.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return Container(
//                   //padding: EdgeInsetsDirectional.only(top: 1),
//                   child: Row(
//                     children: <Widget>[
//                       CustomTimeLine(
//                         height: 105,
//                       ),
//                       Expanded(
//                         flex: 12,
//                         child: Container(
//                           padding: EdgeInsets.only(right: 5),
//                           height: 120,
//                           child: InkWell(
//                             child: Card(
//                               elevation: 5.0,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                               ),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Column(
//                                   children: <Widget>[
//                                     Row(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: <Widget>[
//                                         Text(
//                                           displayClients[index]
//                                               .tICKETGDT
//                                               .toString(),
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.green,
//                                           ),
//                                         ),
//                                         Text(
//                                           displayClients[index]
//                                               .tICKSTATUS
//                                               .toString(),
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             color: Colors.green,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: 10.0,
//                                     ),
//                                     Column(
//                                       children: <Widget>[
//                                         Text(
//                                           displayClients[index]
//                                               .cSTTITLES
//                                               .toString(),
//                                           overflow: TextOverflow.ellipsis,
//                                           maxLines: 2,
//                                         ),
//                                         SizedBox(
//                                           height: 20.0,
//                                         ),
//                                         Row(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: <Widget>[
//                                             Text(''),
//                                             Text(
//                                               displayClients[index]
//                                                   .tPRIORITY
//                                                   .toString(),
//                                               style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.red,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                             onTap: () {
//                               // print(snapshot.data[index].cTICKETID.toString());
//                               // print(snapshot.data[index].tKTSTUSID);

//                               Widget cancelButton = FlatButton(
//                                 child: Text("Cancel"),
//                                 onPressed: () {
//                                   Navigator.of(context, rootNavigator: true)
//                                       .pop('dialog');
//                                 },
//                               );
//                               Widget continueButton = FlatButton(
//                                 child: Text("Continue"),
//                                 onPressed: () {
//                                   resolvedTicket(
//                                     displayClients[index].cTICKETID.toString(),
//                                   ).then(
//                                     (value) {
//                                       DBProvider().initDB().then((_) {
//                                         ClientApiProvider().getAllEmployees();
//                                       });
//                                     },
//                                     // dbService.getAllTickets('4');
//                                     // DBProvider().initDB().then((_) {
//                                     //   ClientApiProvider().getAllEmployees();
//                                     // });
//                                   ).then((value) {
//                                     dbService.getAllTickets('4');
//                                     Navigator.of(context, rootNavigator: true)
//                                         .pop('dialog');
//                                     final snackBar = SnackBar(
//                                       content: Text('Issue closed!'),
//                                     );
//                                     scaffoldKey.currentState
//                                         .showSnackBar(snackBar);
//                                     FocusScope.of(context)
//                                         .requestFocus(FocusNode());
//                                   });
//                                 },
//                               );

//                               // set up the AlertDialog
//                               AlertDialog alert = AlertDialog(
//                                 title: Text("AlertDialog"),
//                                 content: StatefulBuilder(builder:
//                                     (BuildContext context,
//                                         StateSetter setState) {
//                                   return Container(
//                                     height: 200,
//                                     width: 200,
//                                     child: SingleChildScrollView(
//                                       child: Column(
//                                         children: [
//                                           Text(
//                                             "Would you like to continue closing this issue?",
//                                           ),
//                                           SizedBox(
//                                             height: 10,
//                                           ),
//                                           SmoothStarRating(
//                                             rating: rating,
//                                             size: 25,
//                                             starCount: 5,
//                                             color: Colors.red,
//                                             borderColor: Colors.red,
//                                             onRated: (value) {
//                                               setState(() {
//                                                 rating = value;
//                                                 enableButton();
//                                               });
//                                               //print(rating);
//                                             },
//                                           ),
//                                           Container(
//                                             height: 100,
//                                             child: Card(
//                                               elevation: 5,
//                                               child: new TextFormField(
//                                                 controller: _commentController,
//                                                 onFieldSubmitted:
//                                                     (String value) {
//                                                   setState(() {
//                                                     _commentController.text =
//                                                         value;
//                                                   });
//                                                 },
//                                                 decoration: new InputDecoration(
//                                                   enabled: isEnabled,
//                                                   enabledBorder:
//                                                       new OutlineInputBorder(
//                                                     borderSide: new BorderSide(
//                                                         color: Colors.white),
//                                                   ),
//                                                   focusedBorder:
//                                                       OutlineInputBorder(
//                                                     borderSide: BorderSide(
//                                                         color: Colors.white),
//                                                   ),
//                                                   labelText:
//                                                       "Leave your comments here",
//                                                 ),
//                                                 maxLines: 50,
//                                                 validator: (value) => value
//                                                         .isEmpty
//                                                     ? '     Field is required'
//                                                     : null,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   );
//                                 }),
//                                 actions: [
//                                   cancelButton,
//                                   continueButton,
//                                 ],
//                               );
//                               showDialog(
//                                 context: context,
//                                 builder: (BuildContext context) {
//                                   return alert;
//                                 },
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//     );
//   }

//   buildAppBar() {
//     return AppBar(
//       backgroundColor: Color(PrimaryColor),
//       title: !isSearching
//           ? Text(
//               'Waiting for Sattlement',
//               style: TextStyle(fontSize: 19),
//             )
//           : TextField(
//               controller: _controller,
//               onSubmitted: (value) {
//                 if (value.isNotEmpty) {
//                   _controller.clear();
//                 }
//               },
//               onChanged: (text) async {
//                 text = text.toLowerCase();

//                 setState(() {
//                   displayClients = clients.where((value) {
//                     var projectNameTile =
//                         value.pROJTNAME.toString().toLowerCase();
//                     var cstTitlesTile =
//                         value.cSTTITLES.toString().toLowerCase();
//                     var ticketPriorityTile =
//                         value.tPRIORITY.toString().toLowerCase();
//                     var ticketStatusTile =
//                         value.tICKSTATUS.toString().toLowerCase();
//                     return projectNameTile.contains(text) ||
//                         cstTitlesTile.contains(text) ||
//                         ticketPriorityTile.contains(text) ||
//                         ticketStatusTile.contains(text);
//                     //return genericNameTile.contains(text);
//                   }).toList();
//                 });
//               },
//               style: TextStyle(color: Colors.white),
//               decoration: InputDecoration(
//                 // icon: Icon(
//                 //   Icons.search,
//                 //   color: Colors.white,
//                 // ),
//                 hintText: "Search Here",
//                 hintStyle: TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//       actions: <Widget>[
//         Row(
//           children: [
//             Container(
//               child: isSearching
//                   ? IconButton(
//                       icon: Icon(Icons.arrow_back),
//                       onPressed: () async {
//                         _controller.text = "";
//                         //var data = await dbProvider.getProductsByCategory('P');
//                         setState(() {
//                           this.isSearching = false;
//                           displayClients = clients;
//                         });
//                       },
//                     )
//                   : IconButton(
//                       icon: Icon(Icons.search),
//                       onPressed: () {
//                         setState(() {
//                           this.isSearching = true;
//                         });
//                       },
//                     ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

import 'package:dil_app/api/client_info_service.dart';
import 'package:dil_app/api/db/db_provider.dart';
import 'package:dil_app/api/resolved_service.dart';
import 'package:dil_app/custom/custom_card_view.dart';
import 'package:dil_app/custom/custom_timeline_widget.dart';
import 'package:dil_app/model/client_info_model.dart';
import 'package:dil_app/pages/chart/chart.dart';
import 'package:flutter/material.dart';
import 'package:dil_app/config/common_const.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ResultsPage extends StatefulWidget {
  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  DBProvider dbService = DBProvider();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<ClientInfo> clients;
  List<ClientInfo> displayClients;
  var isLoading = true;
  bool isSearching = false;
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  var rating = 0.0;

  @override
  void initState() {
    dbService.getAllTickets('4').then((data) {
      setState(() {
        clients = data;
        displayClients = clients;
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: buildAppBar(),
      backgroundColor: Colors.white,
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : displayClients.isEmpty
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
                                  createdDate: '${displayClients[index].tICKETGDT.toString()}',
                                  closedDate: '${displayClients[index].uPDATEDAT.toString()}',
                                  status: '${displayClients[index].tICKSTATUS.toString()}',
                                  priority: '${displayClients[index].tPRIORITY.toString()}',
                                  ticketId: '${displayClients[index].cTICKETID.toString()}',
                                  ticketTitle: '${displayClients[index].cSTTITLES.toString()}',
                                  projectName: '${displayClients[index].pROJTNAME.toString()}',
                                  clientName: '${displayClients[index].cLINTNAME.toString()}',
                                  description: '${displayClients[index].tICKETDESC.toString()}',
                                  ticketNo: '${displayClients[index].tICKETUDID.toString()}',
                                  ticketReqMode: '${displayClients[index].tREQMODE.toString()}',
                                ),
                                onTap: () {
                                  // print(snapshot.data[index].cTICKETID.toString());
                                  // print(snapshot.data[index].tKTSTUSID);

                                  // ignore: deprecated_member_use
                                  Widget cancelButton = FlatButton(
                                    child: Text("Cancel"),
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop('dialog');
                                    },
                                  );
                                  // ignore: deprecated_member_use
                                  Widget continueButton = FlatButton(
                                    child: Text("Continue"),
                                    onPressed: () {
                                      resolvedTicket(
                                              displayClients[index]
                                                  .cTICKETID
                                                  .toString(),
                                              rating.toString(),
                                              _commentController.text)
                                          .then(
                                        (value) {
                                          DBProvider().initDB().then((_) {
                                            ClientApiProvider()
                                                .getAllEmployees();
                                          });
                                        },
                                        // dbService.getAllTickets('4');
                                        // DBProvider().initDB().then((_) {
                                        //   ClientApiProvider().getAllEmployees();
                                        // });
                                      ).then((value) {
                                        dbService.getAllTickets('4');
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop('dialog');
                                        final snackBar = SnackBar(
                                          content: Text('Issue closed!'),
                                        );
                                        scaffoldKey.currentState
                                            // ignore: deprecated_member_use
                                            .showSnackBar(snackBar);
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                      });
                                    },
                                  );

                                  // set up the AlertDialog
                                  AlertDialog alert = AlertDialog(
                                    title: Text("Issue close alert"),
                                    content: StatefulBuilder(builder:
                                        (BuildContext context,
                                            StateSetter setState) {
                                      return Container(
                                        height: rating == 0.0 ? 100 : 200,
                                        width: 200,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Text(
                                                "Would you like to continue closing this issue?",
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              SmoothStarRating(
                                                rating: rating,
                                                size: 25,
                                                starCount: 5,
                                                color: Colors.red,
                                                borderColor: Colors.red,
                                                onRated: (value) {
                                                  setState(() {
                                                    rating = value;
                                                  });
                                                  //print(rating);
                                                },
                                              ),
                                              rating == 0.0
                                                  ? Container()
                                                  : Container(
                                                      height: 100,
                                                      child: Card(
                                                        elevation: 5,
                                                        child:
                                                            new TextFormField(
                                                          controller:
                                                              _commentController,
                                                          onFieldSubmitted:
                                                              (String value) {
                                                            setState(() {
                                                              _commentController
                                                                  .text = value;
                                                            });
                                                          },
                                                          decoration:
                                                              new InputDecoration(
                                                            // enabled: isEnabled,
                                                            enabledBorder:
                                                                new OutlineInputBorder(
                                                              borderSide:
                                                                  new BorderSide(
                                                                      color: Colors
                                                                          .white),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            labelText:
                                                                "Give your feedback here",
                                                          ),
                                                          maxLines: 50,
                                                          // validator: (value) => value
                                                          //         .isEmpty
                                                          //     ? '     Field is required'
                                                          //     : null,
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                    actions: [
                                      cancelButton,
                                      continueButton,
                                    ],
                                  );
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return alert;
                                    },
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
    );
  }

  buildAppBar() {
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
              'Waiting for Sattlement',
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
