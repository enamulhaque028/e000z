import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:mediinfo/helper/offline_container.dart';
import 'package:mediinfo/pages/about/about.dart';
import 'package:mediinfo/pages/all_product/all_product_page.dart';
import 'package:mediinfo/pages/home/Home.dart';
import 'package:mediinfo/services/db/db_service.dart';
import 'package:mediinfo/services/web/webservices.dart';
import './custom_lib/drug_icon_icons.dart' as DrugIcon;
import 'config/CommonConstant.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mediinfo/theme/app_theme.dart';
import 'services/db/db_provider.dart';
import 'package:mediinfo/pages/favourite_list/favourite_list_page.dart';
import 'package:upgrader/upgrader.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    var isDarkTheme = prefs.getBool("darkTheme") ?? false;
    return runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ChangeNotifierProvider<ThemeProvider>(
          child: EasyLocalization(
            path: "assests/langs",
            saveLocale: true,
            supportedLocales: [
              Locale('en', 'US'),
              Locale('bn', 'BD'),
            ],
            fallbackLocale: Locale('en', 'US'),
            child: DrugApp(),
          ),
          create: (BuildContext context) {
            return ThemeProvider(isDarkTheme);
          },
        ),
      ),
    );
  });
}

class DrugApp extends StatefulWidget {
  @override
  _DrugAppState createState() => _DrugAppState();
}

class _DrugAppState extends State<DrugApp> {
  getColor() {}
  @override
  void initState() {
    Webservice().tokenAuth().then((value) {
      Webservice().fetchCountries();
    });
    // Webservice().fetchCountries();
    DBProvider().initDB();
    DBService().init();
    super.initState();
  }

  var pageIndex = 0;
  final pages = [
    Home(),
    AllProductPage(),
    // Pharma(),
    // Herbal(),
    // Oncology(),
    FavouriteListPage(),
    About(),
  ];
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    // final appcastURL =
    //     'https://raw.githubusercontent.com/larryaasen/upgrader/master/test/testappcast.xml';
    // final cfg = AppcastConfiguration(url: appcastURL, supportedOS: ['android']);
    return Consumer<ThemeProvider>(
      builder: (context, value, child) {
        return MaterialApp(
          //theme: ThemeData(brightness: Brightness.dark),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            EasyLocalization.of(context).delegate,
          ],
          supportedLocales: EasyLocalization.of(context).supportedLocales,
          locale: EasyLocalization.of(context).locale,
          home: Scaffold(
            bottomNavigationBar: SafeArea(
              child: buildCurvedNavigationBar(),
            ),

            /*  body: pages[pageIndex],*/
            body: UpgradeAlert(
              // appcastConfig: cfg,
              debugLogging: true,
              child: OfflineBuilder(
                connectivityBuilder: (BuildContext context,
                    ConnectivityResult connectivity, Widget child) {
                  final bool connected = connectivity != ConnectivityResult.none;
                  return Stack(
                    fit: StackFit.expand,
                    children: [
                      child,
                      Positioned(
                        left: 0.0,
                        right: 0.0,
                        bottom: 0.0,
                        height: 16,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.fastOutSlowIn,
                          child: connected ? null : buildContainerOffline(),
                        ),
                      ),
                    ],
                  );
                },
                child: Container(
                  //  margin: const EdgeInsets.only(bottom: 10),
                  height: height,
                  child: pages[pageIndex],
                ),
              ),
            ),
          ),
          theme: value.getTheme(),
        );
      },
    );
  }

  CurvedNavigationBar buildCurvedNavigationBar() {
    return CurvedNavigationBar(
      index: 0,
      height: 50,
      color: Color(PrimaryColor),
      buttonBackgroundColor: Color(PrimaryColor),
      backgroundColor: getColor(),
      //backgroundColor: Colors.white,
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(microseconds: 600),
      onTap: (index) {
        setState(() {
          pageIndex = index;
        });
      },
      items: [
        Icon(
          Icons.home,
          color: Colors.white,
        ),
        Icon(
          DrugIcon.DrugIcon.medicine,
          color: Colors.white,
        ),
        // Icon(
        //   DrugIcon.DrugIcon.herbal,
        //   color: Colors.white,
        // ),
        // Icon(
        //   DrugIcon.DrugIcon.oncology,
        //   color: Colors.white,
        // ),
        Icon(
          Icons.favorite,
          color: Colors.white,
        ),
        Icon(
          Icons.help,
          color: Colors.white,
        ),
      ],
    );
  }
}
