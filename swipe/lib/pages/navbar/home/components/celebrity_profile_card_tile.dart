import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';

class CelebrityProfileCardTile extends StatelessWidget {
  final String diamondNo;
  final String assetIconPath;
  final String title;
  final VoidCallback onTap;
  const CelebrityProfileCardTile({
    Key? key,
    required this.diamondNo,
    required this.assetIconPath,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: EdgeInsets.only(bottom: 24),
      child: Card(
        color: AppColor.kBackground,
        elevation: 0.0,
        margin: EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Image.asset(
                  'assets/images/diamond_blue.png',
                  height: 50,
                ),
              ),
              Text(
                diamondNo,
                style: TextStyle(
                  color: AppColor.primaryTextColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                        top: 8.0,
                        bottom: 8,
                        left: 16,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.iconBackground,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Image.asset(
                                assetIconPath,
                                height: 20,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              title,
                              style: TextStyle(
                                color: AppColor.secondaryTextColor
                                    .withOpacity(0.7),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  InkWell(
                    onTap: () {
                      onTap();
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 9, horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppColor.iconBackground,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.blue,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
