import 'package:flutter/material.dart';
import 'package:mediinfo/helper/card_design/paint/custom_paint_oval.dart';
import 'package:mediinfo/services/db/db_provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:mediinfo/models/country.dart';

class BuildCardOval extends StatefulWidget {
  final Color color;
  final String drugIcon;
  final String productName;
  final String genericName;
  final String thumbLink;
  final String productNo;
  final String unitPrice;
  final String tokenType;
  final String token;

  const BuildCardOval({
    Key key,
    @required this.color,
    @required this.drugIcon,
    @required this.productName,
    @required this.genericName,
    @required this.thumbLink,
    @required this.productNo,
    @required this.unitPrice,
    this.tokenType = '',
    this.token = '',
  }) : super(key: key);

  @override
  _BuildCardOvalState createState() => _BuildCardOvalState();
}

class _BuildCardOvalState extends State<BuildCardOval> {
  double cpWidth = 500;
  var rating = 0.0;
  var favBtnValue = 0;
  var shortListBtnValue = 0;
  var cartBtnValue = 0;
  String isPending = '0';
  DBProvider dbProvider = DBProvider();
  List<AddToFavourite> favData = [];
  List<AddToShortList> shortListData = [];
  List<AddToCartTable> cartData = [];

  // this initState() is only for getting the length of favorite and shortlist products
  // if initState() isn't created then "favData.length" and "shortListData.length" will be []
  @override
  void initState() {
    super.initState();
    dbProvider.getProductsFromFavourite().then((res) {
      setState(() {
        favData = res;
      });
    });
    dbProvider.getProductsFromShortList().then((res) {
      setState(() {
        shortListData = res;
      });
    });
    dbProvider.getProductCartTable(isPending).then((res) {
      setState(() {
        cartData = res;
      });
    });
  }

  // get all products no from favorite
  List<String> getFavProductNo() {
    List<String> allFavProductNo = [];
      int i;
      for (i = 0; i < favData.length; i++) {
        allFavProductNo.add(favData[i].productNo.toString());
      }
    return allFavProductNo;
  }

  // get all products no from short list
  List<String> getShortListProductNo() {
    List<String> allShortListProductNo = [];
    setState(() {
      int i;
      for (i = 0; i < shortListData.length; i++) {
        allShortListProductNo.add(shortListData[i].productNo.toString());
      }
    });
    return allShortListProductNo;
  }
  // get all products no from cart
  List<String> getCartProductNo() {
    List<String> allCartProductNo = [];
    setState(() {
      int i;
      for (i = 0; i < cartData.length; i++) {
        allCartProductNo.add(cartData[i].productNo.toString());
      }
    });
    return allCartProductNo;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: 143,
      width: width,
      padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        shadowColor: Colors.grey,
        elevation: 4.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(5.0),
                  child: CircleAvatar(
                    radius: 12,
                    backgroundImage: NetworkImage(widget.drugIcon),
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 5.0),
                      width: width / 3.34,
                      child: Text(
                        widget.productName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      width: width / 3.34,
                      height: 33,
                      child: Text(
                        widget.genericName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Container(
                      //width: width / 3.34,
                      child: SmoothStarRating(
                        rating: rating,
                        size: 18,
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
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              //print(getFavProductNo());
                              var btnVal;
                              if (favBtnValue == 0 && getFavProductNo().contains(widget.productNo) == false) {
                                dbProvider.addToFavourite(widget.productNo, widget.productName, widget.genericName, widget.thumbLink).then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text('Product has been added to favorite'),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                });
                                btnVal = 1;
                              } else {
                                dbProvider.deleteProductFromFavourite(widget.productNo).then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text('Product has been removed from favorite'),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                });
                                btnVal = 0;
                              }
                              setState(() {
                                favBtnValue = btnVal;
                              });
                            },
                            child: (favBtnValue == 0 && getFavProductNo().contains(widget.productNo) == false)
                                ? Icon(Icons.favorite_outline,color: Colors.grey,)
                                : Icon(Icons.favorite,color: Colors.red,),
                            ),
                          SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              print(getShortListProductNo());
                              var btnVal;
                              if(shortListBtnValue == 0 && getShortListProductNo().contains(widget.productNo) == false) {
                                dbProvider.addToShortList(widget.productNo, widget.productName, widget.genericName, widget.thumbLink).then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: Duration(seconds: 1),
                                      content: const Text('Product has been added to short list'),
                                    ),
                                  );
                                });
                                btnVal = 1;
                                } else {
                                  dbProvider.deleteProductFromShortList(widget.productNo).then((value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: const Text('Product has been removed from short list'),
                                        duration: Duration(seconds: 1),
                                      ),
                                    );
                                  });
                                  btnVal = 0;
                                }
                              setState(() {
                                shortListBtnValue = btnVal;
                              });
                            },
                            child: (shortListBtnValue == 0 && getShortListProductNo().contains(widget.productNo) == false)
                                ? Icon(Icons.add_circle_outline,color: Colors.grey)
                                : Icon(Icons.check_outlined,color: Colors.green),
                          ),
                          SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              print(getCartProductNo());
                              var btnVal;
                              if (cartBtnValue == 0 && getCartProductNo().contains(widget.productNo) == false) {
                                dbProvider.addToCartTable(widget.productNo, widget.productName, widget.genericName, '1', widget.unitPrice ,widget.thumbLink).then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: Duration(seconds: 1),
                                      content: const Text('Product has been added to cart'),
                                    ),
                                  );
                                });
                                btnVal = 1;
                              } else {
                                dbProvider.deleteProductCartTable(widget.productNo).then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text('Product has been removed from cart'),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                });
                                btnVal = 0;
                              }
                              setState(() {
                                cartBtnValue = btnVal;
                              });
                            },
                            child: (cartBtnValue == 0 && getCartProductNo().contains(widget.productNo) == false)
                                ? Icon(Icons.shopping_cart_outlined,color: Colors.grey)
                                : Icon(Icons.shopping_cart_rounded,color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  //color: Colors.green,
                  child: CustomPaint(
                    size: Size(
                      200,
                      (cpWidth * 0.3).toDouble(),
                    ), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                    painter: RPSCustomPainterOval(getColor: widget.color),
                  ),
                ),
                Positioned(
                  left: 97,
                  top: 20,
                  child: Container(
                    width: 88.0,
                    height: 88.0,
                    child: CircleAvatar(
                      radius: 88,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: Image.network(
                          widget.thumbLink,
                          headers: {'Authorization': '${widget.tokenType} ${widget.token}'},
                          errorBuilder: (context, object, stacktrace) {
                            return Container(
                              width: 88.0,
                              height: 88.0,
                              child: Image.asset(
                                'assests/images/no_preview.png',
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    // decoration: new BoxDecoration(
                    //   color: Colors.white,
                    //   shape: BoxShape.circle,
                    //   image: new DecorationImage(
                    //     fit: BoxFit.fill,
                    //     image: new NetworkImage(
                    //       widget.thumbLink,
                    //       headers: {
                    //         'Authorization': '${widget.tokenType} ${widget.token}',
                    //       },
                    //     ),
                    //     onError: (object, stacktrace) {
                    //         return Image.asset(
                    //           'assests/images/no_preview.png',
                    //           fit: BoxFit.cover,
                    //         );
                    //       }
                    //   ),
                    // ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
