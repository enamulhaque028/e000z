import 'package:flutter/material.dart';
import 'package:mediinfo/helper/custom_dialogue/custom_dialogue.dart';
import 'package:mediinfo/models/country.dart';
import 'package:mediinfo/models/product_des.dart';
import 'package:mediinfo/models/token.dart';
import 'package:mediinfo/pages/favourite_list/components/fav_list_tile.dart';
import 'package:mediinfo/services/db/db_provider.dart';
import 'package:mediinfo/services/db/db_service.dart';

class FavouritePage extends StatefulWidget {
  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  DBProvider dbProvider = DBProvider();
  DBService dbService = DBService();
  List<AddToFavourite> data = [];
  List<AddToFavourite> displayData = [];
  bool isSearching = false;
  final TextEditingController _controller = TextEditingController();
  Product fetchProductInfo = new Product();
  String tokenType = '';
  String token = '';

  void _handleTap(String productName, String thumbLink, String productNo,
      String genericName) async {
    dbService.addCountry(productName, thumbLink, productNo, genericName);
    showDialog(
        useRootNavigator: false,
        context: context,
        builder: (context) {
          return CustomDialogue(
            genericName: genericName,
            productNo: productNo,
            thumbLink: thumbLink,
          );
        });
  }

  @override
  void initState() {
    dbProvider.getProductsFromFavourite().then((res) {
      setState(() {
        data = res;
        displayData = data;
      });
    });
    getTokenFromSP();
    //click events
    String userActivity = 'User is in Favorite page';
    String page = 'Favorite';
    String date = DateTime.now().toString();
    dbProvider.addToClickEvent(userActivity, page, date);
    super.initState();
  }

  Future getTokenFromSP() async {
    token = await Token().getToken();
    tokenType = await Token().getTokenType();
  }

  //delete product from Favourite
  _deleteProduct(String productNo, String productName) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(
              'Do you want to delete item from favorite?',
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
                  String userActivity = 'Deleted "$productName" from Favorite';
                  String page = 'Favorite';
                  String date = DateTime.now().toString();
                  dbProvider.addToClickEvent(userActivity, page, date);

                  //delete product
                  dbProvider.deleteProductFromFavourite(productNo).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Product has been removed from favorite'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  });
                  final res = await dbProvider.getProductsFromFavourite();
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
    return Scaffold(
      appBar: buildAppBar(),
      body: displayData.length > 0
          ? ListView.builder(
              itemCount: displayData.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () => _handleTap(
                    displayData[index].productName.toString(),
                    displayData[index].thumbLink.toString(),
                    displayData[index].productNo.toString(),
                    displayData[index].genericName.toString(),
                  ),
                  // child: BuildCardFavList(
                  //   thumbLink: displayData[index].thumbLink.toString(),
                  //   productName: displayData[index].productName.toString(),
                  //   genericName: displayData[index].genericName.toString(),
                  //   onTap: () {
                  //     _deleteProduct(
                  //       displayData[index].productNo.toString(),
                  //       displayData[index].productName.toString(),
                  //     );
                  //   },
                  // ),
                  child: FavListTile(
                    imageUrl: displayData[index].thumbLink.toString(),
                    productName: displayData[index].productName.toString(),
                    genericName: displayData[index].genericName.toString(),
                    tokenType: tokenType,
                    token: token,
                    onTapDalete: (){
                      _deleteProduct(
                        displayData[index].productNo.toString(),
                        displayData[index].productName.toString(),
                      );
                    },
                  ),
                );
              },
            )
          : Center(
              child: Text('No product has been added!'),
            ),
    );
  }

  buildAppBar() {
    return AppBar(
      toolbarHeight: 50,
      elevation: 0,
      backgroundColor: Colors.grey[200],
      title: !isSearching
          ? Text(
              '',
              style: TextStyle(fontSize: 19),
            )
          : TextField(
              controller: _controller,
              onSubmitted: (value) {
                // print(value);
                if (value.isNotEmpty) {
                  _controller.clear();
                }
              },
              onChanged: (text) async {
                text = text.toLowerCase();

                setState(() {
                  displayData = data.where((value) {
                    var productNameTitle = value.productName.toLowerCase();
                    var genericNameTile = value.genericName.toLowerCase();
                    return productNameTitle.contains(text) ||
                        genericNameTile.contains(text);
                  }).toList();
                });
              },
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: "Search Your Product Here",
                hintStyle: TextStyle(
                  color: Colors.black,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[200]),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[200]),
                ),
              ),
            ),
      actions: <Widget>[
        Row(
          children: [
            Container(
              child: isSearching
                  ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: Colors.black,
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
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          this.isSearching = true;
                        });
                      },
                    ),
            ),
          ],
        ),
      ],
    );
  }
}
