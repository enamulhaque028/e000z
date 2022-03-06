import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipe/pages/login/google_login/utils/firebase_auth.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, AsyncSnapshot<User?> snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Home Page'),
          ),
          body: (!snapshot.hasData || snapshot.data == null)
              ? CircularProgressIndicator()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(),
                    Text("Name: ${snapshot.data?.displayName}"),
                    Text("Email: ${snapshot.data?.email}"),

                    // Image.network(
                    //     '${snapshot.data.photoURL.toString()}',
                    //     height: 200,
                    //     width: 200,
                    //   ),
                    Container(
                      height: 200,
                      width: 200,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          image: new NetworkImage(
                              '${snapshot.data?.photoURL.toString()}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      child: Text("Log out"),
                      onPressed: () {
                        AuthProvider().logOut();
                      },
                    )
                  ],
                ),
        );
      },
    );
  }
}
