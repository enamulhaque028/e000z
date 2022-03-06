import 'package:flutter/material.dart';
import 'package:mediinfo/config/CommonConstant.dart';

sisterConcerns(BuildContext context) {
  double height = 35;
  double width = MediaQuery.of(context).size.width * 0.8;
  double sizebox = 15;
  showDialog(
    context: context,
    useRootNavigator: false,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 10,
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 70.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: sizebox,
                    ),
                    Container(
                      width: width,
                      height: height,
                      alignment: Alignment.center,
                      decoration: new BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              'http://drug-international.com/resource/img/companies/Drug-International-Ltd-Herb.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: sizebox,
                    ),
                    Container(
                      width: width,
                      height: height,
                      alignment: Alignment.center,
                      decoration: new BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              'http://drug-international.com/resource/img/companies/Drug-International-Unani-LT.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: sizebox,
                    ),
                    Container(
                      width: width,
                      height: height,
                      alignment: Alignment.center,
                      decoration: new BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              'http://drug-international.com/resource/img/companies/kyamch.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: sizebox,
                    ),
                    Container(
                      width: width,
                      height: height,
                      alignment: Alignment.center,
                      decoration: new BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              'http://drug-international.com/resource/img/companies/kyan.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: sizebox,
                    ),
                    Container(
                      width: width,
                      height: height,
                      alignment: Alignment.center,
                      decoration: new BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              'http://drug-international.com/resource/img/companies/kyas.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: sizebox,
                    ),
                    Container(
                      width: width,
                      height: height,
                      alignment: Alignment.center,
                      decoration: new BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              'http://drug-international.com/resource/img/companies/kyau.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: sizebox,
                    ),
                    Container(
                      width: width,
                      height: height,
                      alignment: Alignment.center,
                      decoration: new BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              'http://drug-international.com/resource/img/companies/ATI-Ceramics-LTD.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: sizebox,
                    ),
                    Container(
                      width: width,
                      height: height,
                      alignment: Alignment.center,
                      decoration: new BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              'http://drug-international.com/resource/img/companies/ATI-Logo.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: sizebox,
                    ),
                    Container(
                      width: width,
                      height: height,
                      alignment: Alignment.center,
                      decoration: new BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              'http://drug-international.com/resource/img/companies/M.M-Tea-Estate.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: sizebox,
                    ),
                    Container(
                      width: width,
                      height: height,
                      alignment: Alignment.center,
                      decoration: new BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              'http://drug-international.com/resource/img/companies/Harnest.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Add your onPressed code here!
              Navigator.of(context).pop();
            },
            // label: Text('Ok'),
            child: new Text("Ok"),
            backgroundColor: Color(PrimaryColor),
          ),
        ),
      ),
    ),
  );
}
