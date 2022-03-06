import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';
import 'package:swipe/widgets/custom_button.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColor.kBackground,
      body: Builder(
        builder: (BuildContext context) {
          return Stack(
            children: <Widget>[
              Image.asset(
                'assets/images/bg.png',
                fit: BoxFit.cover,
                height: 220,
                width: size.width,
              ),
              Positioned(
                top: 50,
                left: 16,
                child: Row(
                  children: [
                    CustomButton(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      iconData: Icons.arrow_back_ios_new,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: size.width / 3 - 32),
                      child: Text(
                        'Notification',
                        style: TextStyle(
                          fontSize: 18,
                          color: AppColor.kBackground,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  height: size.height,
                  padding: EdgeInsets.only(top: 120),
                  child: Card(
                    color: AppColor.kBackground,
                    elevation: 0.0,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: AppColor.kBackground,
                                  radius: 29.0,
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundImage: AssetImage(
                                        "assets/images/background.png"),
                                  ),
                                ),
                                title: RichText(
                                  text: TextSpan(
                                    text: 'Jenny ',
                                    style: TextStyle(
                                      color: Color.fromRGBO(34, 33, 91, 0.6),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'paid you for video call',
                                        style: TextStyle(
                                          color: AppColor.primaryTextColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                subtitle: Text(
                                  'Will do, super, thank you....',
                                  style: TextStyle(
                                    color: Color.fromRGBO(129, 129, 152, 1),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                trailing: Text(
                                  'Thu 20',
                                  style: TextStyle(
                                    color: Color.fromRGBO(129, 129, 152, 1),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              Divider(thickness: 1)
                            ],
                          );
                        }),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
