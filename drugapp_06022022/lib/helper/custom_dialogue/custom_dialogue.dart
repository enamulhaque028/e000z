import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:mediinfo/config/CommonConstant.dart';
import 'package:mediinfo/custom_lib/drug_icon_icons.dart' as DrugIcon;
import 'package:mediinfo/models/product_des.dart';
import 'package:mediinfo/services/web/product_desc_service.dart';
import '../user_comment.dart';
import 'tabs/tab_container_1.dart';

class CustomDialogue extends StatefulWidget {
  final String genericName;
  final String productNo;
  final String thumbLink;

  const CustomDialogue({
    Key key,
    @required this.genericName,
    @required this.productNo,
    @required this.thumbLink,
  }) : super(key: key);

  @override
  _CustomDialogueState createState() => _CustomDialogueState();
}

class _CustomDialogueState extends State<CustomDialogue> {
  Product fetchProductInfo = new Product();
  bool isLoading = true;
  @override
  void initState() {
    getProductInfo(widget.productNo).then((value) {
      setState(() {
        fetchProductInfo = value;
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    String productName =
        isLoading ? '' : fetchProductInfo.productName.toString();
    String productDesc =
        isLoading ? '' : fetchProductInfo.productDescription.toString();
    List<String> strimages =
        isLoading ? [] : fetchProductInfo.productImageDownloadUrl;
    String unitPrice =
        isLoading ? '1.0' : fetchProductInfo.unitPrice.toString();
    //add list of images from server
    // ignore: deprecated_member_use
    List<NetworkImage> images = List<NetworkImage>();
    int i;
    for (i = 0; i < strimages.length; i++) {
      images.add(NetworkImage(strimages[i]));
    }

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      elevation: 10,
      child: Scaffold(
        //appBar: AppBar(),
        backgroundColor: Colors.transparent,
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        child: Container(
                          height: height / 3.4,
                          width: width,
                          child: Carousel(
                            boxFit: BoxFit.fill,
                            images: strimages.length == 0
                                ? [Image.asset('assests/images/no_preview.png')]
                                : images,
                            dotBgColor: Colors.amber,
                            dotColor: Colors.red,
                            indicatorBgPadding: 5.0,
                          ),
                        ),
                      ),
                      DefaultTabController(
                        length: 4, // length of tabs
                        initialIndex: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              child: TabBar(
                                //isScrollable: true,
                                labelColor: Colors.green,
                                unselectedLabelColor: Color(PrimaryColor),
                                indicatorColor: Color(PrimaryColor),
                                tabs: [
                                  Tab(
                                    //text: 'Description',
                                    icon: Icon(
                                      Icons.description,
                                      color: Color(PrimaryColor),
                                    ),
                                  ),
                                  Tab(
                                    //text: 'Generic',
                                    icon: Icon(
                                      DrugIcon.DrugIcon.medicine,
                                      color: Color(PrimaryColor),
                                    ),
                                  ),
                                  Tab(
                                    //text: 'Therapeutic',
                                    icon: Icon(
                                      DrugIcon.DrugIcon.oncology,
                                      color: Color(PrimaryColor),
                                    ),
                                  ),
                                  Tab(
                                    //text: 'Review',
                                    icon: Icon(
                                      Icons.comment,
                                      color: Color(PrimaryColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: height / 2.3, //height of TabBarView
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Colors.grey,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              child: TabBarView(
                                children: <Widget>[
                                  TabContainer1(
                                    productName: productName,
                                    genericName: widget.genericName,
                                    productDesc: productDesc,
                                    productNo: widget.productNo,
                                    thumbLink: widget.thumbLink,
                                    unitPrice: unitPrice,
                                  ),
                                  tabContainer2(context),
                                  tabContainer3(context),
                                  tabContainer4(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     // Add your onPressed code here!
        //     Navigator.of(context).pop();
        //   },
        //   // label: Text('Ok'),
        //   child: new Text("Ok"),
        //   backgroundColor: Color(PrimaryColor),
        // ),
      ),
    );
  }

  tabContainer2(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              "Generic",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Display Tab for Generic',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
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

  tabContainer3(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              "Therapeutic",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Display Tab for Therapeutic',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
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

  tabContainer4() {
    return Container(
      child: UserComment(),
    );
  }
}
