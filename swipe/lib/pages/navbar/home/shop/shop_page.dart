import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';
import 'package:swipe/pages/navbar/home/shop/payment_dialog.dart';
import 'package:swipe/widgets/custom_button.dart';
import 'shop_card_tile.dart';

class ShopPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFf2f2f2),
      body: Builder(
        builder: (BuildContext context) {
          return Stack(
            children: <Widget>[
              Image.asset(
                'assets/images/bg.png',
                fit: BoxFit.cover,
                height: 200,
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
                    Container(
                      width: size.width / 1.4,
                      child: Center(
                        child: Text(
                          'Shop ',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColor.kBackground,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.only(top: 100),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    shrinkWrap: true,
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return ShopCardTile(
                        diamondNo: '10 Diamond',
                        diamondPrice: 'BDT 600 tk',
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: AppColor.kBackground,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                topRight: Radius.circular(15.0),
                              ),
                            ),
                            builder: (context) {
                              return PaymentDialog(
                                creditCardNo: "**** **** **** 4747",
                                onTapBuy: () {
                                  Navigator.of(context).pop();
                                },
                              );
                            },
                          );
                        },
                      );
                    },
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
