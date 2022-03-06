import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediinfo/config/CommonConstant.dart';
import 'package:mediinfo/helper/custom_button/confirm_button.dart';
import 'package:mediinfo/services/db/db_provider.dart';
// import 'package:mediinfo/pages/google_login/utils/firebase_auth.dart';

class CheckoutPage extends StatefulWidget {
  final String totalBill;
  const CheckoutPage({Key key, @required this.totalBill}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  DBProvider dbProvider = DBProvider();
  @override
  void initState() {
    //click events
    String userActivity = 'User is Checkout page now';
    String page = 'Checkout';
    String date = DateTime.now().toString();
    dbProvider.addToClickEvent(userActivity, page, date);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, AsyncSnapshot<UserInfo> snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Checkout'),
            backgroundColor: Color(PrimaryColor),
            brightness: Brightness.dark,
          ),
          body: (!snapshot.hasData || snapshot.data == null)
              ? CircularProgressIndicator()
              :
              // Center(
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: <Widget>[
              //         Text('Confirm your order'),
              //         Text("Name: ${snapshot.data.displayName}"),
              //         Text("Email: ${snapshot.data.email}"),
              //         Text("Total Bill: $totalBill"),
              //         Container(
              //           height: 200,
              //           width: 200,
              //           decoration: new BoxDecoration(
              //             shape: BoxShape.circle,
              //             image: new DecorationImage(
              //               image: new NetworkImage(
              //                   '${snapshot.data.photoUrl.toString()}'),
              //               fit: BoxFit.cover,
              //             ),
              //           ),
              //         ),
              //         // ignore: deprecated_member_use
              //         RaisedButton(
              //           child: Text("Log out"),
              //           onPressed: () {
              //             AuthProvider().logOut();
              //           },
              //         )
              //       ],
              //     ),
              //   ),
              SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Confirm your order',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(PrimaryColor),
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: new DecorationImage(
                                      image: new NetworkImage(
                                          '${snapshot.data.photoUrl.toString()}'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 8),
                                    Text(
                                      snapshot.data.displayName.toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      snapshot.data.email.toString(),
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Divider(
                        color: Colors.grey[400],
                        height: 2,
                        thickness: 0.75,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Bill ',
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              '৳${widget.totalBill}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.grey[400],
                        height: 2,
                        thickness: 0.75,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Vat',
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              '৳0.0',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.grey[400],
                        height: 2,
                        thickness: 0.75,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Bill',
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              '৳${widget.totalBill}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ConfirmButton(
                        onTap: () {
                          String userActivity = 'User confirmed the order';
                          String page = 'Checkout';
                          String date = DateTime.now().toString();
                          dbProvider.addToClickEvent(userActivity, page, date);
                          dbProvider.moveToPending();
                          Navigator.pop(context);
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Container(
                                    height: 180,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      (2 / 5) -
                                                  8,
                                              child: RichText(
                                                text: TextSpan(
                                                  text: 'Your Order is ',
                                                  style: TextStyle(
                                                    color: Color(PrimaryColor),
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: 'successful',
                                                      style: TextStyle(
                                                        color: Colors.green,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 19,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Icon(
                                              Icons.check_circle_outline,
                                              color: Colors.green,
                                              size: 40,
                                            ),
                                          ],
                                        ),
                                        Center(
                                          child: TypewriterAnimatedTextKit(
                                              speed:
                                                  Duration(milliseconds: 200),
                                              onTap: () {
                                                print("Tap Event");
                                              },
                                              text: [
                                                'Please Wait for the Confirmation',
                                                'Please Wait for the Confirmation',
                                                'Please Wait for the Confirmation',
                                                'Please Wait for the Confirmation',
                                              ],
                                              textStyle: TextStyle(
                                                  fontSize: 20.0,
                                                  fontFamily: "Agne",
                                                  color: Color(PrimaryColor),
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.start,
                                              alignment: AlignmentDirectional
                                                  .topStart // or Alignment.topLeft
                                              ),
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: TextButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all<
                                                          Color>(
                                                      Color(PrimaryColor)),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Back',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
