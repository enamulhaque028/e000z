import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';

class BottomPanelTile extends StatelessWidget {
  final VoidCallback onTapGender;
  final VoidCallback onTapCountry;
  const BottomPanelTile({
    Key? key,
    required this.onTapGender,
    required this.onTapCountry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(bottom: width * 0.15),
      child: Container(
        width: width * 0.8,
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          color: AppColor.kBackground,
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {
                onTapGender();
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CircleAvatar(
                      backgroundColor: AppColor.iconBackground,
                      radius: 18,
                      child: Image.asset(
                        'assets/images/gender.png',
                        height: 25,
                        width: 25,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Text(
                    'Gender',
                    style: TextStyle(
                      color: Color.fromRGBO(56, 56, 56, 1),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                onTapCountry();
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CircleAvatar(
                      backgroundColor: AppColor.iconBackground,
                      radius: 18,
                      child: Image.asset(
                        'assets/images/earth.png',
                        height: 25,
                        width: 25,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Text(
                    'Country',
                    style: TextStyle(
                      color: Color.fromRGBO(56, 56, 56, 1),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
