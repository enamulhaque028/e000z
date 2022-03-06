import 'package:flutter/material.dart';
import 'package:mediinfo/helper/card_design/paint/custom_paint_arrow.dart';
import 'package:mediinfo/models/country.dart';
import 'package:mediinfo/services/db/db_provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class BuildCardArrow extends StatefulWidget {
  final String productName;
  final String genericName;
  final String thumbLink;
  final String drugIcon;
  final Color color;
  final String productNo;
  final String unitPrice;
  final String tokenType;
  final String token;

  const BuildCardArrow({
    Key key,
    @required this.productName,
    @required this.genericName,
    @required this.thumbLink,
    @required this.drugIcon,
    @required this.color,
    @required this.productNo,
    @required this.unitPrice,
    this.tokenType = '',
    this.token = '',
  }) : super(key: key);

  @override
  _BuildCardArrowState createState() => _BuildCardArrowState();
}

class _BuildCardArrowState extends State<BuildCardArrow> {
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
    setState(() {
      int i;
      for (i = 0; i < favData.length; i++) {
        allFavProductNo.add(favData[i].productNo.toString());
      }
    });
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
    var arrowWidth = width * (2 / 3) - 9;
    var imageWidth = width * (1 / 3) - 9;
    return Container(
      height: 160,
      width: width,
      padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        shadowColor: Colors.grey,
        elevation: 4.0,
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: arrowWidth,
                  height: 160,
                  //color: Colors.blue,
                  child: CustomPaint(
                    size: Size(
                        300,
                        (300 * 0.5333333333333333).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                    painter: RPSCustomPainterArrow(getColor: widget.color),
                  ),
                ),
                Positioned(
                  top: 32,
                  left: arrowWidth / 11,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: arrowWidth / 30),
                        child: CircleAvatar(
                          radius: arrowWidth / 28,
                          backgroundImage: NetworkImage(widget.drugIcon),
                          backgroundColor: Colors.white,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            //color: Colors.green,
                            height: 20,
                            width: arrowWidth / 1.6,
                            child: Text(
                              widget.productName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          //SizedBox(height: 5),
                          Container(
                            //color: Colors.blue,
                            height: 20,
                            width: arrowWidth / 1.4,
                            child: Text(
                              widget.genericName,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ),
                          //SizedBox(height: 5),
                          Container(
                            //color: Colors.blue,
                            height: 20,
                            //width: arrowWidth / 2,
                            width: arrowWidth / 1.98,
                            child: SmoothStarRating(
                              rating: rating,
                              size: 18,
                              starCount: 5,
                              color: Colors.red,
                              borderColor: Colors.white,
                              onRated: (value) {
                                setState(() {
                                  rating = value;
                                });
                                //print(rating);
                              },
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    //print(getFavProducts());
                                    var btnVal;
                                    (favBtnValue == 0 && getFavProductNo().contains(widget.productNo) ==false)
                                        ? () {
                                            dbProvider
                                                .addToFavourite(
                                                    widget.productNo,
                                                    widget.productName,
                                                    widget.genericName,
                                                    widget.thumbLink,
                                                  ).then((value) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  duration: Duration(seconds: 1),
                                                  content: const Text('Product has been added to favorite'),
                                                ),
                                              );
                                            });
                                            btnVal = 1;
                                          }()
                                        : () {
                                            dbProvider.deleteProductFromFavourite(widget.productNo).then((value) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  duration: Duration(seconds: 1),
                                                  content: const Text('Product has been removed from favorite'),
                                                ),
                                              );
                                            });
                                            btnVal = 0;
                                          }();
                                    setState(() {
                                      favBtnValue = btnVal;
                                    });
                                  },
                                  child: (favBtnValue == 0 && getFavProductNo().contains(widget.productNo) == false)
                                      ? Icon(
                                          Icons.favorite_outline,
                                          color: Colors.white,
                                        )
                                      : Icon(
                                          Icons.favorite,
                                          color: Colors.white,
                                        ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    print(getShortListProductNo());
                                    var btnVal;
                                    (shortListBtnValue == 0 && getShortListProductNo().contains(widget.productNo) == false)
                                        ? () {
                                            dbProvider
                                                .addToShortList(
                                                    widget.productNo,
                                                    widget.productName,
                                                    widget.genericName,
                                                    widget.thumbLink,
                                                  ).then((value) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  duration: Duration(seconds: 1),
                                                  content: const Text('Product has been added to short list'),
                                                ),
                                              );
                                            });
                                            btnVal = 1;
                                          }()
                                        : () {
                                            dbProvider.deleteProductFromShortList(widget.productNo).then((value) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  duration: Duration(seconds: 1),
                                                  content: const Text('Product has been removed from short list'),
                                                ),
                                              );
                                            });
                                            btnVal = 0;
                                          }();
                                    setState(() {
                                      shortListBtnValue = btnVal;
                                    });
                                  },
                                  child: (shortListBtnValue == 0 &&  getShortListProductNo().contains(widget.productNo) == false)
                                      ? Icon(
                                          Icons.add_circle_outline,
                                          color: Colors.white,
                                        )
                                      : Icon(
                                          Icons.check_outlined,
                                          color: Colors.white,
                                        ),
                                ),
                                SizedBox(width: 10),
                                InkWell(
                                  onTap: () {
                                    print(getCartProductNo());
                                    var btnVal;
                                    (cartBtnValue == 0 && getCartProductNo().contains(widget.productNo) == false)
                                        ? () {
                                            dbProvider.addToCartTable(widget.productNo, widget.productName, widget.genericName, '1', widget.unitPrice ,widget.thumbLink).then((value) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  duration: Duration(seconds: 1),
                                                  content: const Text('Product has been added to cart'),
                                                ),
                                              );
                                            });
                                            btnVal = 1;
                                          }()
                                        : () {
                                            dbProvider.deleteProductCartTable(widget.productNo).then((value) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: const Text('Product has been removed from cart'),
                                                  duration: Duration(seconds: 1),
                                                ),
                                              );
                                            });
                                            btnVal = 0;
                                          }();
                                    setState(() {
                                      cartBtnValue = btnVal;
                                    });
                                  },
                                  child: (cartBtnValue == 0 && getCartProductNo().contains(widget.productNo) == false)
                                      ? Icon(Icons.shopping_cart_outlined, color: Colors.white)
                                      : Icon(Icons.shopping_cart_rounded, color: Colors.white),
                                    ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            FittedBox(
              child: Container(
                height: 160,
                width: imageWidth,
                child: Image.network(
                  widget.thumbLink,
                  headers: {
                    'Authorization': '${widget.tokenType} ${widget.token}'
                  },
                  errorBuilder: (context, object, stacktrace) {
                    return Container(
                      width: imageWidth,
                      height: 160,
                      child: Image.asset(
                        'assests/images/no_preview.png',
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
