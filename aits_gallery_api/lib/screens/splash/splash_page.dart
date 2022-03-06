import 'package:aits_gallery/config/presentation/app_color.dart';
import 'package:aits_gallery/screens/home/home_page.dart';
// import 'package:aits_gallery/service/cache_manager_service.dart';
import 'package:aits_gallery/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // @override
  // void initState() {
  //   CacheManager().cacheApiRespone(context);
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColor.backgroungGradient,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset('assets/images/gallery.png', height: 145),
            Container(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150.0,
                  child: Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Text(
                      'Lorem ipsum dolor sit, consect elit, sed do tempor ut labore et. Lorem ipsum dolor sit amet, consect adipiscing elit, sed do eiusmod tempor.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                CustomButtom(
                  btnText: 'Start',
                  btnTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
