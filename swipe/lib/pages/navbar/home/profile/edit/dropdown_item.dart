import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';

class DropDownItem extends StatelessWidget {
  final String iconPath;
  final String title;
  final String selectedValue;
  final VoidCallback onTap;

  const DropDownItem({
    Key? key,
    required this.iconPath,
    required this.title,
    required this.selectedValue,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: [
          ListTile(
            leading: Image.asset(
              iconPath,
              height: 35,
            ),
            title: Text(
              title,
              style: TextStyle(
                color: AppColor.secondaryTextColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.iconBackground.withOpacity(0.3),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: AppColor.borderColor, width: 1),
              ),
              child: ListTile(
                title: Text(
                  selectedValue,
                  style: TextStyle(
                    color: AppColor.primaryTextColor,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_drop_down_outlined,
                  size: 35,
                  color: Colors.blue,
                ),
                onTap: () {
                  onTap();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
