import 'package:flutter/material.dart';
import 'package:mediinfo/pages/google_login/utils/firebase_auth.dart';
import '../../../helper/custom_button/login_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // TextEditingController _emailController;
  // TextEditingController _passwordController;

  // @override
  // void initState() {
  //   super.initState();
  //   _emailController = TextEditingController(text: "");
  //   _passwordController = TextEditingController(text: "");
  // }

  @override
  Widget build(BuildContext context) {
    Color firebaseNavy = Color(0xFF2C384A);
    Color firebaseOrange = Color(0xFFF57C00);
    Color firebaseYellow = Color(0xFFFFCA28);
    return Scaffold(
      backgroundColor: firebaseNavy,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        width: 100.0,
                        height: 100.0,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new AssetImage('assests/images/drug.png'),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Require',
                      style: TextStyle(
                        color: firebaseYellow,
                        fontSize: 40,
                      ),
                    ),
                    Text(
                      'Authentication',
                      style: TextStyle(
                        color: firebaseOrange,
                        fontSize: 40,
                      ),
                    ),
                  ],
                ),
              ),
              LoginButton(
                buttonText: 'Sign in with Google',
                logoUrl: 'assests/images/google_logo.png',
                onPressed: () async {
                  bool res = await AuthProvider().loginWithGoogle();
                  if (!res) print("error logging in with google");
                  //if(res) return MainScreen();
                  //if (res) {
                  //   Navigator.pushReplacement(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (BuildContext ctx) => MainScreen(),
                  //     ),
                  //   );
                  // }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
