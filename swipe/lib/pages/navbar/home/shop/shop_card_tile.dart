import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';

class ShopCardTile extends StatelessWidget {
  final String diamondNo;
  final String diamondPrice;
  final VoidCallback onTap;
  const ShopCardTile({
    Key? key,
    required this.diamondNo,
    required this.diamondPrice,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 24),
      child: Card(
        color: AppColor.kBackground,
        elevation: 0.0,
        margin: EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Image.asset(
                  'assets/images/diamond_shop.png',
                  height: 60,
                ),
              ),
              Text(
                diamondNo,
                style: TextStyle(
                  color: Colors.grey[600]!.withOpacity(0.9),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 8.0),
              InkWell(
                onTap: () {
                  onTap();
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Color.fromRGBO(26, 201, 253, 1),
                        Color.fromRGBO(29, 105, 241, 1)
                      ],
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(7),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      diamondPrice,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
