// import 'package:flutter/material.dart';
// import 'package:mediinfo/config/CommonConstant.dart';

// class Constants {
//   Constants._();
//   static const double padding = 20;
//   static const double avatarRadius = 60;
// }

// class CustomDialogBox extends StatefulWidget {
//   final String title, descriptions, text;
//   final Image img;

//   const CustomDialogBox(
//       {Key key, this.title, this.descriptions, this.text, this.img})
//       : super(key: key);

//   @override
//   _CustomDialogBoxState createState() => _CustomDialogBoxState();
// }

// class _CustomDialogBoxState extends State<CustomDialogBox> {
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(Constants.padding),
//       ),
//       elevation: 0,
//       //backgroundColor: Colors.transparent,
//       child: contentBox(context),
//     );
//   }

//   contentBox(context) {
//     return Stack(
//       children: <Widget>[
//         Container(
//           padding: EdgeInsets.only(
//             left: Constants.padding,
//             top: Constants.avatarRadius + Constants.padding,
//             right: Constants.padding,
//             bottom: Constants.padding,
//           ),
//           margin: EdgeInsets.only(
//             top: Constants.avatarRadius,
//           ),
//           // decoration: BoxDecoration(
//           //   shape: BoxShape.rectangle,
//           //   //color: Colors.white,
//           //   borderRadius: BorderRadius.circular(Constants.padding),
//           //   boxShadow: [
//           //     BoxShadow(
//           //       color: Colors.black,
//           //       offset: Offset(0, 10),
//           //       blurRadius: 10,
//           //     ),
//           //   ],
//           // ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Text(
//                 widget.title,
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//               Text(
//                 widget.descriptions,
//                 style: TextStyle(
//                   fontSize: 14,
//                 ),
//               ),
//               SizedBox(
//                 height: 22,
//               ),
//               // Align(
//               //   alignment: Alignment.bottomRight,
//               //   child: FlatButton(
//               //     onPressed: () {
//               //       Navigator.of(context).pop();
//               //     },
//               //     child: Text(
//               //       widget.text,
//               //       style: TextStyle(
//               //         fontSize: 18,
//               //       ),
//               //     ),
//               //   ),
//               // ),
//               Align(
//                 alignment: Alignment.bottomRight,
//                 child: FloatingActionButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: Text('ok'),
//                   backgroundColor: Color(PrimaryColor),
//                 ),
//               )
//             ],
//           ),
//         ),
//         Positioned(
//           left: Constants.padding,
//           right: Constants.padding,
//           child: CircleAvatar(
//             backgroundColor: Colors.transparent,
//             radius: Constants.avatarRadius,
//             child: ClipRRect(
//               borderRadius: BorderRadius.all(
//                 Radius.circular(Constants.avatarRadius),
//               ),
//               child: Image.network(
//                   'http://drug-international.com/resource/img/12.jpg'),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:mediinfo/config/CommonConstant.dart';

class Constants {
  Constants._();
  static const double padding = 20;
  static const double avatarRadius = 60;
}

class CustomDialogBox extends StatefulWidget {
  final String title, descriptions;
  final Image img;

  const CustomDialogBox({Key key, this.title, this.descriptions, this.img})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.cyan[50],
            borderRadius: BorderRadius.circular(Constants.padding),
            boxShadow: [
              BoxShadow(
                  color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
            ],
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Color(PrimaryColor),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 70.0),
                    child: Text(
                      widget.descriptions,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 22,
                  // ),
                  // Align(
                  //   alignment: Alignment.bottomRight,
                  //   child: FloatingActionButton(
                  //     onPressed: () => Navigator.pop(context),
                  //     child: Text('ok'),
                  //     backgroundColor: Color(PrimaryColor),
                  //   ),
                  // ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => Navigator.pop(context),
              child: Text('ok'),
              backgroundColor: Color(PrimaryColor),
            ),
          ),
        ),
        Positioned(
          left: Constants.padding,
          right: Constants.padding,
          child: Container(
            height: 120,
            width: 80,
            child: widget.img,
          ),
        ),
      ],
    );
  }
}
