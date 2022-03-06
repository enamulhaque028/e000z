import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';

class CelebrityListTile extends StatelessWidget {
  final String status;
  final String profileImgUrl;
  final String name;
  final String flagUrl;
  final String country;
  final VoidCallback onTap;
  const CelebrityListTile({
    Key? key,
    required this.status,
    required this.profileImgUrl,
    required this.name,
    required this.flagUrl,
    required this.country,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 24),
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Card(
          color: AppColor.kBackground,
          elevation: 0.0,
          margin: EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green[500],
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        status,
                        style: TextStyle(
                          color: AppColor.primaryTextColor,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.pink),
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(profileImgUrl),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.grey[600]!.withOpacity(0.9),
                    fontSize: 17,
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      // child: Image.asset(
                      //   flagUrl,
                      //   height: 15,
                      //   width: 25,
                      // ),
                      child: Text(flagUrl, style: TextStyle(fontSize: 16),),
                    ),
                    Text(
                      country,
                      style: TextStyle(
                        color: Color.fromRGBO(129, 129, 152, 1),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
