import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:mediinfo/helper/custom_dialogue/custom_dialogue.dart';
import 'package:mediinfo/models/country.dart';
import 'package:mediinfo/models/product_des.dart';
import 'package:mediinfo/models/token.dart';
import 'package:mediinfo/services/db/db_provider.dart';
import 'package:mediinfo/services/db/db_service.dart';

class MostViewedProducts extends StatefulWidget {
  @override
  _MostViewedProductsState createState() => _MostViewedProductsState();
}

class _MostViewedProductsState extends State<MostViewedProducts> {
  DBService dbService = DBService();
  DBProvider dbProvider = DBProvider();
  int currentPage = 0;
  final PageController ctrl = PageController(viewportFraction: 0.8);
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
    getTokenFromSP();
    super.initState();

    // Set state when page changes
    ctrl.addListener(() {
      int next = ctrl.page.round();

      if (currentPage != next) {
        //click events
        String userActivity = 'Scrolling the most viewed products';
        String page = 'Home';
        String date = DateTime.now().toString();
        dbProvider.addToClickEvent(userActivity, page, date);
        setState(() {
          currentPage = next;
        });
      }
    });
  }

  Future getTokenFromSP() async {
    token = await Token().getToken();
    tokenType = await Token().getTokenType();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: FutureBuilder<List<Country>>(
        future: dbService.fetchTopCountries(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 25,
                    width: width,
                    // margin: const EdgeInsets.only(
                    //   top: 5.0,
                    //   bottom: 20.0,
                    // ),
                    child: Center(
                      child: ColorizeAnimatedTextKit(
                        repeatForever: true,
                        text: [
                          "Most Viewed Products",
                        ],
                        textStyle: TextStyle(
                            fontSize: 25.0,
                            fontFamily: "Horizon",
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                        colors: [
                          Colors.purple,
                          Colors.blue,
                          Colors.yellow,
                          Colors.red,
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: PageView.builder(
                      //shrinkWrap: true,
                      controller: ctrl,
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (snapshot.data.length > index) {
                          // Active page
                          bool active = index == currentPage;
                          return _buildAnimatedContainer(
                              snapshot, index, active);
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  AnimatedContainer _buildAnimatedContainer(
      AsyncSnapshot<List<Country>> snapshot, int index, bool active) {
    final double blur = active ? 10 : 0;
    final double offset = active ? 10 : 0;
    final double top = active ? 30 : 50;

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.only(top: top, bottom: 40, right: 50),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black26,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(
            snapshot.data[index].thumbLink.toString(),
            headers: {'Authorization': '$tokenType $token'},
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black87,
            blurRadius: blur,
            offset: Offset(offset, offset),
          ),
        ],
      ),
      child: InkWell(
        child: Container(
          alignment: Alignment.center,
          width: 500,
          height: 500,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            //color: Colors.black26,
          ),
          // child: Text(
          //   snapshot.data[index].productName.toString(),
          //   style: TextStyle(
          //     color: Colors.white,
          //     fontSize: 20,
          //     fontWeight: FontWeight.w500,
          //   ),
          // ),
        ),
        onTap: () => _handleTap(
          snapshot.data[index].productName.toString(),
          snapshot.data[index].thumbLink.toString(),
          snapshot.data[index].productNo.toString(),
          snapshot.data[index].genericName.toString(),
        ),
      ),
    );
  }
}
