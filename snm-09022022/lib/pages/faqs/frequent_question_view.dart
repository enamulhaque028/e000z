import 'package:dil_app/config/common_const.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class FrequentQestionsView extends StatefulWidget {
  final String questions;
  final String anwsers;
  final double rating;
  const FrequentQestionsView({
    Key key,
    @required this.questions,
    @required this.anwsers,
    @required this.rating,
  }) : super(key: key);

  @override
  _FrequentQestionsViewState createState() => _FrequentQestionsViewState();
}

class _FrequentQestionsViewState extends State<FrequentQestionsView> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ExpansionPanelList(
        elevation: 0,
        animationDuration: Duration(milliseconds: 1500),
        children: [
          ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.questions,
                      style: TextStyle(color: Colors.black),
                    ),
                    SmoothStarRating(
                      size: 20,
                      isReadOnly: true,
                      rating: widget.rating,
                      color: Color(PrimaryColor),
                      borderColor: Color(PrimaryColor),
                    ),
                  ],
                ),
              );
            },
            body: Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: cViolet, width: 1.5),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.anwsers,
                      ),
                      SizedBox(height: 16),
                      Container(
                        height: 55,
                        decoration: BoxDecoration(
                          color: Colors.green[300],
                          border:
                              Border.all(color: Color(PrimaryColor), width: 2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Is this helpful?",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: SmoothStarRating(),
                      )
                    ],
                  ),
                ),
              ),
            ),
            isExpanded: _expanded,
            canTapOnHeader: true,
          ),
        ],
        dividerColor: Colors.grey,
        expansionCallback: (panelIndex, isExpanded) {
          _expanded = !_expanded;
          setState(() {});
        },
      ),
    );
  }
}
