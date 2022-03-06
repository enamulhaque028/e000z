import 'package:flutter/material.dart';
import 'package:mediinfo/models/country.dart';
import 'package:mediinfo/models/token.dart';
import 'package:mediinfo/services/db/db_provider.dart';
import 'package:mediinfo/services/db/db_service.dart';

import 'components/fav_list_tile.dart';

class PendingPage extends StatefulWidget {
  @override
  PendingPageState createState() => PendingPageState();
}

class PendingPageState extends State<PendingPage> {
  DBProvider dbProvider = DBProvider();
  DBService dbService = DBService();
  List<AddToCartTable> data = [];
  List<AddToCartTable> displayData = [];
  bool isSearching = false;
  final TextEditingController _controller = TextEditingController();
  String isPending = '1';
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
    String userActivity = 'User is in Pending page';
    String page = 'Pending';
    String date = DateTime.now().toString();
    dbProvider.addToClickEvent(userActivity, page, date);
    super.initState();
  }

  Future getTokenFromSP() async {
    token = await Token().getToken();
    tokenType = await Token().getTokenType();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: displayData.length > 0
          ? ListView.builder(
              itemCount: displayData.length,
              itemBuilder: (BuildContext context, int index) {
                // return BuildCardFavList(
                //   thumbLink: displayData[index].thumbLink.toString(),
                //   productName: displayData[index].productName.toString(),
                //   genericName: displayData[index].genericName.toString(),
                //   onTap: () {},
                // );
                return FavListTile(
                    imageUrl: displayData[index].thumbLink.toString(),
                    productName: displayData[index].productName.toString(),
                    genericName: displayData[index].genericName.toString(),
                    tokenType: tokenType,
                    token: token,
                    isVisibleDeleteIcon: false,
                    onTapDalete: (){},
                  );
              },
            )
          : Center(
              child: Text('No pending products!'),
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
