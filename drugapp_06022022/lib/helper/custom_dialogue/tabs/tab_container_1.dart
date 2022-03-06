import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/services.dart';
import 'package:mediinfo/pages/cart/cart_page.dart';
import 'package:mediinfo/services/db/db_provider.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mediinfo/config/CommonConstant.dart';
import 'package:flutter/material.dart';

class TabContainer1 extends StatefulWidget {
  final String productName;
  final String genericName;
  final String productDesc;
  final String productNo;
  final String unitPrice;
  final String thumbLink;

  const TabContainer1({
    Key key,
    @required this.productName,
    @required this.genericName,
    @required this.productDesc,
    @required this.productNo,
    @required this.unitPrice,
    @required this.thumbLink,
  }) : super(key: key);

  @override
  _TabContainer1State createState() => _TabContainer1State();
}

class _TabContainer1State extends State<TabContainer1> {
  TextEditingController _controller = TextEditingController();
  DBProvider dbProvider = DBProvider();
  @override
  void initState() {
    super.initState();
    _controller.text = "1"; // Setting the initial value for the field.
  }

  void _handleTap(var height, var width) {
    var dialogueHeight = height / 2.8; // Change as per your requirement
    var dialogueWidth = width / 1.7; // Change as per your requirement

    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            content: StatefulBuilder(
                builder: (BuildContext ctx, StateSetter setState) {
              return Container(
                height: dialogueHeight,
                width: dialogueWidth,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Product Name",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        //margin: const EdgeInsets.all(15.0),
                        width: dialogueWidth,
                        padding: const EdgeInsets.only(
                          left: 15.0,
                          right: 5.0,
                          top: 10,
                          bottom: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Text(widget.productName),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Quantity",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: dialogueWidth,
                        padding: const EdgeInsets.only(
                          left: 5.0,
                          right: 5.0,
                          //top: 10,
                          //bottom: 10,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                int currentValue = int.parse(_controller.text);
                                setState(() {
                                  currentValue--;
                                  _controller.text =
                                      (currentValue > 1 ? currentValue : 1)
                                          .toString(); // decrementing value
                                });
                              },
                            ),
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(8.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                ),
                                controller: _controller,
                                keyboardType: TextInputType.numberWithOptions(
                                  decimal: false,
                                  signed: true,
                                ),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                              ),
                            ),
                            new IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                int currentValue = int.parse(_controller.text);
                                setState(() {
                                  currentValue++;
                                  _controller.text = (currentValue)
                                      .toString(); // incrementing value
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        child: Container(
                          height: 50,
                          width: dialogueWidth,
                          color: Color(PrimaryColor),
                          child: Center(
                            child: Text(
                              'DONE',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(ctx);
                          // dbProvider.addProductToCart(
                          //     widget.productNo, _controller.text.toString());
                          dbProvider.addToCartTable(
                            widget.productNo,
                            widget.productName,
                            widget.genericName,
                            _controller.text.toString(),
                            widget.unitPrice,
                            widget.thumbLink,
                          );
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.SUCCES,
                            animType: AnimType.BOTTOMSLIDE,
                            headerAnimationLoop: false,
                            body: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                      'Product successfully added to your cart'),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CartPage(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 40,
                                      width: dialogueWidth,
                                      color: Colors.black,
                                      child: Center(
                                        child: Text(
                                          'GO TO CHECKOUT',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                    child: Container(
                                      //margin: const EdgeInsets.all(15.0),
                                      width: dialogueWidth,
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "CONTINUE SHOPPING",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )..show();
                        },
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),

            // ignore: deprecated_member_use
            RaisedButton(
              child: Text(
                "ADD TO CART",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                ),
              ),
              onPressed: () {
                // Navigator.pop(context);
                _handleTap(height, width);
              },
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              widget.productName.toString(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(PrimaryColor),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 70.0),
                    child: Html(
                      data: """${widget.productDesc.toString()}""",
                      defaultTextStyle: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
            Navigator.of(context).pop();
          },
          // label: Text('Ok'),
          child: new Text("Ok"),
          backgroundColor: Color(PrimaryColor),
        ),
      ),
    );
  }
}
