import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';

class TrailingItemTile extends StatelessWidget {
  const TrailingItemTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.iconBackground,
                borderRadius: BorderRadius.all(
                  Radius.circular(2),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                child: Text(
                  'Ads',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          Image.asset(
            'assets/images/crown.png',
            height: 40,
          )
        ],
      ),
    );
  }
}
