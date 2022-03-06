import 'package:flutter/material.dart';
import 'package:mediinfo/config/CommonConstant.dart';
import 'package:mediinfo/helper/card_design/design/build_card_arrow.dart';
import 'package:mediinfo/helper/card_design/design/build_card_oval.dart';
import 'package:mediinfo/helper/custom_button/dragable_button.dart';
import 'package:mediinfo/helper/custom_dialogue/custom_dialogue.dart';
import 'package:mediinfo/helper/history_view/history_view.dart';
import 'package:mediinfo/helper/shimmer_effect.dart';
import 'package:mediinfo/models/country.dart';
import 'package:mediinfo/models/token.dart';
import 'package:mediinfo/pages/cart/cart_page.dart';
import 'package:mediinfo/services/db/db_provider.dart';
import 'package:mediinfo/services/db/db_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:easy_localization/easy_localization.dart';

class AllProductPage extends StatefulWidget {
  @override
  _AllProductPageState createState() => _AllProductPageState();
}

class _AllProductPageState extends State<AllProductPage> {
  final TextEditingController _controller = TextEditingController();

  bool isSearching = false;
  bool _isSwitchOn = false;
  DBService dbService = DBService();
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  DBProvider dbProvider = DBProvider();
  List<Country> countries;
  List<Country> displayCountries;
  List<SearchHistory> history;
  List<SearchHistory> displayHistory;
  var isLoading = true;
  // Product fetchProductInfo = new Product();
  String productCategory = 'ALL';
  String token = '';
  String tokenType = '';

  void _handleTap(String productName, String thumbLink, String productNo, String genericName) async {
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
      },
    );
  }

  @override
  void initState() {
    dbProvider.getAllProducts().then((data) {
      setState(() {
        countries = data;
        displayCountries = countries;
        isLoading = false;
      });
    });
    dbProvider.getSearchHistory(productCategory).then((data) {
      setState(() {
        history = data;
        displayHistory = history;
      });
    });
    getTokenFromSP();
    //click events
    String userActivity = 'User is in All Product tab';
    String page = 'All Product';
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
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: isLoading
          ? Center(child: ShimmerList())
          : Stack(
            children: [
              Container(
                  child: SmartRefresher(
                    controller: _refreshController,
                    onRefresh: () async {
                      final res = await dbProvider.getAllProducts();
                      setState(() {
                        displayCountries = res;
                        _refreshController.refreshCompleted();
                      });
                    },
                    enablePullDown: true,
                    //enablePullUp: true,
                    header: WaterDropMaterialHeader(),
                    child: displayCountries.isEmpty
                        ? Center(child: Image.asset('assests/images/no_records.png'))
                        : ListView.builder(
                            itemCount: displayCountries.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () => _handleTap(
                                  displayCountries[index].productName.toString(),
                                  displayCountries[index].thumbLink.toString(),
                                  displayCountries[index].productNo.toString(),
                                  displayCountries[index].genericName.toString(),
                                ),
                                child: _isSwitchOn == false
                                    ? BuildCardOval(
                                        color: Color(0xffdd081d),
                                        drugIcon: 'https://www.freeiconspng.com/thumbs/medical-icon-png/pills-blue-icon-6.png',
                                        productName: displayCountries[index].productName.toString(),
                                        genericName: displayCountries[index].genericName.toString(),
                                        thumbLink: displayCountries[index].thumbLink.toString(),
                                        productNo: displayCountries[index].productNo.toString(),
                                        unitPrice: displayCountries[index].unitPrice.toString(),
                                        token: token,
                                        tokenType: tokenType,
                                      )
                                    : BuildCardArrow(
                                        color: Color(0xffdd081d),
                                        drugIcon: 'https://www.freeiconspng.com/thumbs/medical-icon-png/pills-blue-icon-6.png',
                                        productName: displayCountries[index].productName.toString(),
                                        genericName: displayCountries[index].genericName.toString(),
                                        thumbLink: displayCountries[index].thumbLink.toString(),
                                        productNo: displayCountries[index].productNo.toString(),
                                        unitPrice: displayCountries[index].unitPrice.toString(),
                                        token: token,
                                        tokenType: tokenType,
                                      ),
                              );
                            },
                          ),
                  ),
                ),
              DragableButton(
                initialOffset: Offset(width * 0.80, height * 0.38),
                onBtnTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage()));
                  //click events
                  String userActivity = 'Went to Cart page from AllProduct';
                  String page = 'All Product';
                  String date = DateTime.now().toString();
                  dbProvider.addToClickEvent(userActivity, page, date);
                },
              ),
            ],
          ),
    );
  }

  buildAppBar() {
    return AppBar(
      toolbarHeight: (!isSearching) ? 56 : 120,
      brightness: Brightness.dark,
      backgroundColor: Color(PrimaryColor),
      title: !isSearching
          ? Text(
              'allProdTitle'.tr().toString(),
              style: TextStyle(fontSize: 19),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _controller,
                  onSubmitted: (text) {
                    if (text.isNotEmpty) {
                      _controller.clearComposing();
                    }
                    print(text);
                    dbProvider.addToSearchHistory(text.toString().toLowerCase(), productCategory);
                    text = text.toLowerCase();
                    setState(() {
                      displayCountries = countries.where((value) {
                        var productNameTile = value.productName.toLowerCase();
                        var genericNameTile = value.genericName.toLowerCase();
                        return productNameTile.contains(text) || genericNameTile.contains(text);
                      }).toList();
                    });
                  },
                  onChanged: (text) async {
                    text = text.toLowerCase();
                    setState(() {
                      displayHistory = history.where((value) {
                        var historyTile = value.productName.toLowerCase();
                        return historyTile.contains(text);
                      }).toList();
                    });
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    icon: Icon(Icons.search,color: Colors.white),
                    suffixIcon: IconButton(
                        icon: Icon(Icons.clear,color: Colors.white),
                        onPressed: () async {
                          _controller.text = "";
                          //var data = await dbProvider.getProductsByCategory('P');
                          var historyData = await dbProvider.getSearchHistory(productCategory);
                          //await dbProvider.deleteFromSearch();
                          setState(() {
                            this.isSearching = false;
                            displayCountries = countries;
                            displayHistory = historyData;
                          });
                        }),
                    hintText: "Search Herbal Product Here",
                    hintStyle: TextStyle(color: Colors.white,),
                  ),
                ),
                Container(
                  //color: Colors.yellow,
                  height: 55,
                  child: GridView.builder(
                      padding: EdgeInsets.all(0),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 5),
                      ),
                      itemCount: displayHistory.length,
                      itemBuilder: (BuildContext context, int index) {
                        return HistoryView(
                          productname: displayHistory[index].productName.toString(),
                          onTap: () {
                            _controller.text = displayHistory[index].productName;
                          },
                          onLongPress: () async {
                            
                            //click events
                            String userActivity = 'Deleted "${displayHistory[index].productName.toString()}" from search history';
                            String page = 'AllProduct';
                            String date = DateTime.now().toString();
                            dbProvider.addToClickEvent(userActivity, page, date);

                            //delete product from search history
                            int id = displayHistory[index].id;
                            dbProvider.deleteFromSearch(id).then((value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: const Text('Removed product from history!'),),
                              );
                            });
                            var res = await dbProvider.getSearchHistory(productCategory);
                            setState(() {
                              displayHistory = res;
                            });
                          },
                        );
                      }),
                ),
              ],
            ),
      actions: <Widget>[
        Row(
          children: [
            !isSearching
                ? IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        this.isSearching = true;
                      });
                    },
                  )
                : Container(),
            Switch(
              value: _isSwitchOn,
              onChanged: (val) {
                //click events
                String userActivity = val == false
                    ? 'Switched to cardOval view'
                    : 'Switched to cardArrow view';
                String page = 'AllProduct';
                String date = DateTime.now().toString();
                dbProvider.addToClickEvent(userActivity, page, date);
                setState(() {
                  _isSwitchOn = val;
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
