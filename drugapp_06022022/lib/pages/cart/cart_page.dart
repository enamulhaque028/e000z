import 'package:flutter/material.dart';
import 'package:mediinfo/config/CommonConstant.dart';
import 'package:mediinfo/models/token.dart';
import 'package:mediinfo/pages/all_product/all_product_page.dart';
import 'package:mediinfo/pages/cart/components/cart_list_tile.dart';
import 'package:mediinfo/pages/google_login/check_login.dart';
import 'package:mediinfo/services/db/db_provider.dart';
import 'package:mediinfo/models/country.dart';

class CartPage extends StatefulWidget {
  final Color backgroundColor;
  final Color textColor;
  CartPage({this.backgroundColor, this.textColor});
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  DBProvider dbProvider = DBProvider();
  List<AddToCartTable> data = [];
  List<AddToCartTable> displayData = [];
  bool isSearching = false;
  final TextEditingController _controller = TextEditingController();
  String isPending = '0';
  String tokenType = '';
  String token = '';

  @override
  void initState() {
    dbProvider.getProductCartTable(isPending).then((res) {
      setState(() {
        data = res;
        displayData = data;
      });
    });
    getTokenFromSP();
    //click events
    String userActivity = 'User is in Cart page';
    String page = 'Cart';
    String date = DateTime.now().toString();
    dbProvider.addToClickEvent(userActivity, page, date);
    super.initState();
  }

  Future getTokenFromSP() async {
    token = await Token().getToken();
    tokenType = await Token().getTokenType();
  }

//get total amount from cart
  String getTotalBill() {
    var totalBill = 0.0;
    setState(() {
      int i;
      for (i = 0; i < displayData.length; i++) {
        totalBill = totalBill + displayData[i].totalPrice;
      }
    });
    return totalBill.toString();
  }

  //get all product name from cart as list
  List<String> getProductList() {
    List<String> allProducts = [];
    setState(() {
      int i;
      for (i = 0; i < displayData.length; i++) {
        allProducts.add(displayData[i].productName.toString());
      }
    });
    return allProducts;
  }

  //delete product from cart
  _deleteProduct(String productNo, String productName) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(
              'Do you want to delete item from cart?',
              style: TextStyle(fontSize: 18),
            ),
            actions: [
              // ignore: deprecated_member_use
              FlatButton(
                color: Colors.green,
                onPressed: () => Navigator.pop(_, false), // passing false
                child: Text('No'),
              ),
              // ignore: deprecated_member_use
              FlatButton(
                color: Colors.red,
                onPressed: () async {
                  Navigator.pop(_, true); // passing true
                  //click events
                  String userActivity = 'Deleted "$productName" from Cart Page';
                  String page = 'Cart';
                  String date = DateTime.now().toString();
                  dbProvider.addToClickEvent(userActivity, page, date);

                  //delete product
                  dbProvider.deleteProductCartTable(productNo).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Product has been removed from cart'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  });
                  final res = await dbProvider.getProductCartTable(isPending);
                  setState(() {
                    displayData = res;
                  });
                },
                child: Text('Yes'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: buildAppBar(),
      body: displayData.isEmpty ? Center(child: Text('No product has been added!'))
          : ListView.builder(
              itemCount: displayData.length,
              itemBuilder: (BuildContext context, int index) {
                return CartListTile(
                  imageUrl: displayData[index].thumbLink.toString(),
                  productName: displayData[index].productName.toString(),
                  productAmount: displayData[index].productAmount.toString(),
                  totalPrice: 'Tk ${displayData[index].totalPrice.toString()}',
                  tokenType: tokenType,
                  token: token,
                  onTapDalete: () {
                    _deleteProduct(displayData[index].productNo.toString(), displayData[index].productName.toString());
                  },
                  onTapDecrement: () async {
                    int prodAmount = (int.parse(displayData[index].productAmount) - 1); // decrementing value
                    int productAmount = prodAmount > 1 ? prodAmount : 1;
                    String unitPrice = displayData[index].unitPrice.toString();
                    String productNo = displayData[index].productNo;
                    dbProvider.updateProductAmount(productAmount.toString(), unitPrice, productNo);
                    final res = await dbProvider.getProductCartTable(isPending);
                    setState(() {
                      displayData = res;
                    });
                  },
                  onTapIncrement: () async {
                    int productAmount = (int.parse(displayData[index].productAmount) + 1); // incrementing value
                    String unitPrice = displayData[index].unitPrice.toString();
                    String productNo = displayData[index].productNo;
                    dbProvider.updateProductAmount(productAmount.toString(), unitPrice, productNo);
                    final res = await dbProvider.getProductCartTable(isPending);
                    setState(() {
                      displayData = res;
                    });
                  },
                );
              },
            ),
        bottomNavigationBar: displayData.length > 0
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40,
                  width: width / 2,
                  color: Colors.grey[300],
                  child: Center(
                    child: Text(
                      'TK. ${getTotalBill()}',
                      style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  width: width / 2,
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    onPressed: () {
                      // print(getProductList()[0]);
                      String totalBill = getTotalBill().toString();
                      Navigator.push(context,MaterialPageRoute(builder: (BuildContext ctx) => CheckLogin(totalBill: totalBill)));
                    },
                    color: Colors.black,
                    child: Text(
                      'CHECKOUT',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Text(''),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color(PrimaryColor),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AllProductPage()));
        }
      ),
    );
  }

  buildAppBar() {
    return AppBar(
      brightness: Brightness.dark,
      elevation: 0,
      toolbarHeight: 50,
      backgroundColor: widget.backgroundColor != null
          ? widget.backgroundColor
          : Color(PrimaryColor),
      title: !isSearching
          ? Text('Added products', style: TextStyle(fontSize: 19, color: Colors.grey[200]))
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
                  displayData = data.where((value) {
                    var productNameTitle = value.productName.toLowerCase();
                    //var genericNameTile = value.genericName.toLowerCase();
                    return productNameTitle.contains(text);
                    //return genericNameTile.contains(text);
                  }).toList();
                });
              },
              style: TextStyle(color: widget.textColor != null ? widget.textColor : Colors.white),
              decoration: InputDecoration(
                hintText: "Search Your Product Here",
                hintStyle: TextStyle(
                  color: widget.textColor != null ? widget.textColor: Colors.white,
                ),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[200])),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey[200])),
              ),
            ),
      actions: <Widget>[
        Row(
          children: [
            isSearching
                ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: widget.textColor != null ? widget.textColor : Colors.white,
                    ),
                    onPressed: () async {
                      _controller.text = "";
                      //var data = await dbProvider.getProductsByCategory('P');
                      setState(() {
                        this.isSearching = false;
                        displayData = data;
                      });
                    },
                  )
                : IconButton(
                    icon: Icon(
                      Icons.search,
                      color: widget.textColor != null ? widget.textColor : Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        this.isSearching = true;
                      });
                    },
                  ),
          ],
        ),
      ],
    );
  }
}
