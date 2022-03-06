import 'package:flutter/material.dart';
import 'package:mediinfo/config/CommonConstant.dart';
import 'package:mediinfo/models/country.dart';
import 'package:mediinfo/pages/cart/cart_page.dart';
import 'package:mediinfo/pages/favourite_list/pending_page.dart';
import 'package:mediinfo/pages/favourite_list/short_list_page.dart';
import 'package:mediinfo/services/db/db_provider.dart';
import 'favorite_page.dart';

class FavouriteListPage extends StatefulWidget {
  @override
  _FavouriteListPageState createState() => _FavouriteListPageState();
}

class _FavouriteListPageState extends State<FavouriteListPage> {
  DBProvider dbProvider = DBProvider();
  List<AddToCartTable> cartData = [];
  List<AddToCartTable> pendingData = [];

  @override
  void initState() {
    super.initState();
    dbProvider.getProductCartTable('0').then((res) {
      setState(() {
        cartData = res;
      });
    });
    dbProvider.getProductCartTable('1').then((res) {
      setState(() {
        pendingData = res;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return (cartData.length > 0 || pendingData.length > 0)
        ? DefaultTabController(
            length: 4,
            child: Scaffold(
              appBar: AppBar(
                brightness: Brightness.dark,
                toolbarHeight: 50,
                backgroundColor: Color(PrimaryColor),
                bottom: TabBar(
                  isScrollable: true,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white70,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding: EdgeInsets.all(5.0),
                  indicatorColor: Color(0xFF9d0c0b),
                  tabs: [
                    Tab(
                      text: "Favorite",
                      // icon: Icon(Icons.favorite),
                    ),
                    Tab(
                      text: "Short List",
                      // icon: Icon(Icons.list_alt),
                    ),
                    Tab(
                      text: "Order List",
                      // icon: Icon(Icons.list_alt),
                    ),
                    Tab(
                      text: "Pending",
                      // icon: Icon(Icons.list_alt),
                    ),
                  ],
                ),
              ),
              body: TabBarView(children: [
                FavouritePage(),
                ShortListPage(),
                CartPage(
                  backgroundColor: Colors.grey[200],
                  textColor: Colors.black,
                ),
                PendingPage(),
              ]),
            ),
          )
        : DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                brightness: Brightness.dark,
                toolbarHeight: 50,
                backgroundColor: Color(PrimaryColor),
                bottom: TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.white70,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding: EdgeInsets.all(5.0),
                  indicatorColor: Color(0xFF9d0c0b),
                  tabs: [
                    Tab(
                      text: "Favorite",
                      // icon: Icon(Icons.favorite),
                    ),
                    Tab(
                      text: "Short List",
                      // icon: Icon(Icons.list_alt),
                    ),
                  ],
                ),
              ),
              body: TabBarView(children: [
                FavouritePage(),
                ShortListPage(),
              ]),
            ),
          );
  }
}
