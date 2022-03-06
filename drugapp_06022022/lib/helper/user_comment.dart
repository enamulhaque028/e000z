import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mediinfo/config/CommonConstant.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

double count = 0.0;

class UserComment extends StatefulWidget {
  @override
  _UserCommentState createState() => _UserCommentState();
}

class _UserCommentState extends State<UserComment> {
  List<String> comments = <String>[];
  var rating = 0.0;

  bool _validate = false;
  bool isEnabled = false;
  bool _isVisible = true;

  TextEditingController _commentController = TextEditingController();

  void addCommentToList() {
    if (_commentController.text.isEmpty) {
      _validate = true;
      return;
    } else
      _validate = false;
    setState(() {
      comments.add(_commentController.text);
      //_commentController.text.isEmpty ? _validate = true : _validate = false;
    });
  }

  enableButton() {
    setState(() {
      isEnabled = true;
    });
  }

  void invisibleContent() {
    setState(() {
      _isVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              //padding: const EdgeInsets.all(8),
              itemCount: comments.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      // MaterialButton(
                      //   onPressed: () {},
                      //   color: Colors.blue,
                      //   textColor: Colors.white,
                      //   child: Icon(
                      //     Icons.people,
                      //     size: 20,
                      //   ),
                      //   //padding: EdgeInsets.all(5),
                      //   shape: CircleBorder(),
                      // ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 5, right: 5, left: 5),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                            "https://avatars1.githubusercontent.com/u/20776965?s=460&u=25112d84b0d5a7a8216240cd5ad16a347018102d&v=4",
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Enamul Haque",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // Row(
                                  //   children: [
                                  //     IconButton(
                                  //       icon: Icon(Icons.favorite),
                                  //       padding: EdgeInsets.all(2),
                                  //       onPressed: () {
                                  //         setState(() {
                                  //           count += 1;
                                  //         });
                                  //       },
                                  //     ),
                                  //     Text('$count'),
                                  //   ],
                                  // ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  SmoothStarRating(
                                    rating: rating,
                                    isReadOnly: true,
                                    size: 15,
                                    starCount: 5,
                                    onRated: (value) {
                                      setState(() {
                                        rating = value;
                                      });
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(
                                      //DateTime.now().toString(),
                                      //DateFormat.yMMMMEEEEd().format(DateTime.now()),
                                      DateFormat.yMMMMd()
                                          .format(DateTime.now()),
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                      size: 15.0,
                                    ),
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (builder) {
                                          return SingleChildScrollView(
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.6,
                                              padding: EdgeInsets.only(
                                                top: 10,
                                                left: 10,
                                                right: 10,
                                                bottom: MediaQuery.of(context)
                                                        .viewInsets
                                                        .bottom +
                                                    10,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: <Widget>[
                                                  TextField(
                                                    decoration: InputDecoration(
                                                      labelText: 'Name',
                                                    ),
                                                    controller:
                                                        _commentController,
                                                  ),
                                                  // ignore: deprecated_member_use
                                                  RaisedButton(
                                                    color: Colors.purple,
                                                    child: Text('update'),
                                                    textColor: Colors.white,
                                                    onPressed: () {
                                                      // print(_commentController
                                                      //     .text);
                                                      comments[
                                                          index] = comments[
                                                              index]
                                                          .replaceAll(
                                                              comments[index],
                                                              _commentController
                                                                  .text);
                                                      // print('${comments[index]}');
                                                      // print('${comments[index]}'
                                                      //     .replaceAll(
                                                      //         '${comments[index]}',
                                                      //         _commentController
                                                      //             .text));
                                                      // addCommentToList();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                              ExpandText(
                                '${comments[index]}',
                                textAlign: TextAlign.justify,
                                maxLines: 3,
                                //arrowColor: Colors.blue,
                                arrowSize: 20,
                                arrowPadding: EdgeInsets.all(0),
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Visibility(
            visible: _isVisible,
            child: SmoothStarRating(
              rating: rating,
              size: 20,
              starCount: 5,
              onRated: (value) {
                setState(() {
                  rating = value;
                  enableButton();
                  //invisibleContent();
                });
              },
            ),
          ),
          // Visibility(
          //   visible: _isVisible,
          //   child: RaisedButton(
          //     child: Text('Rate'),
          //     onPressed: rating > 0.0
          //         ? () {
          //             enableButton();
          //             print('Rated');
          //             invisibleContent();
          //           }
          //         : null,
          //   ),
          // ),
          Visibility(
            visible: _isVisible,
            child: Container(
              padding: EdgeInsets.all(5),
              height: 80,
              width: MediaQuery.of(context).size.width,
              child: TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  enabled: isEnabled,
                  hintText: 'Add your comments here',
                  errorText: _validate ? 'Please enter some text' : null,
                ),
              ),
            ),
          ),
          Visibility(
            visible: _isVisible,
            child: Container(
              height: 30,
              // ignore: deprecated_member_use
              child: RaisedButton(
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: isEnabled
                    ? () {
                        addCommentToList();
                        _commentController.clear();
                        // invisibleContent();
                        if (!_validate) {
                          return invisibleContent();
                        }
                      }
                    : null,
                color: Color(PrimaryColor),
                // working disable button
                //onPressed: isEnabled ? addCommentToList : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
