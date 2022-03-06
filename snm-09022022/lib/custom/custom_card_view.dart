import 'package:dil_app/pages/chart/chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomCardView extends StatelessWidget {
  final String createdDate;
  final String closedDate;
  final String status;
  final String priority;
  final String ticketId;
  final String ticketTitle;
  final String projectName;
  final String clientName;
  final String description;
  final String ticketNo;
  final String ticketReqMode;
  const CustomCardView({
    @required this.createdDate,
    @required this.closedDate,
    @required this.status,
    @required this.priority,
    @required this.ticketId,
    @required this.ticketTitle,
    @required this.projectName,
    @required this.clientName,
    @required this.description,
    @required this.ticketNo,
    @required this.ticketReqMode,
  });

  @override
  Widget build(BuildContext context) {
    String formatClosedDate() {
      if (closedDate == '') {
        return '';
      } else {
        DateTime dateTime = DateTime.parse(closedDate);
        String formattedDate = DateFormat("MMMM dd, yyyy").format(dateTime);
        return formattedDate;
      }
    }

    return Stack(
      children: <Widget>[
        Positioned(
          height: 60,
          //top: 20,
          left: 0,
          right: 10,
          child: Card(
            color: Colors.teal[50],
            child: Padding(
              padding: const EdgeInsets.only(
                top: 5.0,
                left: 5.0,
                right: 5.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    ticketNo,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  Text(
                    priority,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          height: 60,
          top: 110,
          left: 0,
          right: 10,
          child: Card(
            color: Colors.teal[50],
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 5.0,
                left: 5.0,
                right: 5.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    formatClosedDate(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  Text(
                    status,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 25,
          left: 5,
          right: 15,
          child: Container(
            height: 170,
            padding: const EdgeInsets.only(top: 50.0),
            child: Card(
              color: Colors.yellow[50],
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      ticketTitle,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      clientName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Divider(),
                    Text(
                      projectName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      ticketReqMode,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: 'Requested By : ',
                            style: TextStyle(
                              color: Colors.purple[900],
                              fontWeight: FontWeight.bold,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: ChartPage.userName.toString(),
                                style: TextStyle(
                                  color: Colors.purple[900],
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          createdDate,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[600],
                          ),
                        ),
                      ],
                    ),
                    // Text(
                    //   description,
                    //   style: TextStyle(color: Colors.grey[600]),
                    //   overflow: TextOverflow.ellipsis,
                    //   maxLines: 2,
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
