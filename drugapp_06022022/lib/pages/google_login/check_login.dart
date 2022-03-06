import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mediinfo/pages/google_login/ui/checkout_page.dart';
import 'package:mediinfo/pages/google_login/ui/login.dart';
import 'package:mediinfo/pages/google_login/ui/splash.dart';

class CheckLogin extends StatelessWidget {
  final String totalBill;
  const CheckLogin({Key key, @required this.totalBill}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, AsyncSnapshot<UserInfo> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return SplashPage();
        if (!snapshot.hasData || snapshot.data == null) return LoginPage();
        // print(snapshot.data.displayName);
        return CheckoutPage(
          totalBill: totalBill,
        );
      },
    );
  }
}
