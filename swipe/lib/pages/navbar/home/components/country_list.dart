import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';
import 'package:swipe/pages/navbar/home/components/trailing_item_tile.dart';

class CountryList extends StatefulWidget {
  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  int value = 0;
  List<String> countryList = [
    'All country',
    'Bangladesh',
    'India',
    'Canada',
    'Italy',
    'Brazil',
    'Spain',
    'Japna',
    'Pakistan',
    'Thailand',
  ];
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: Colors.blue,
      ),
      child: ListView.builder(
        itemCount: countryList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              RadioListTile<int>(
                value: index,
                groupValue: value,
                onChanged: (ind) {
                  setState(() {
                    value = ind!;
                  });
                  print(ind);
                },
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${countryList[index]}',
                      style: TextStyle(
                        color: AppColor.primaryTextColor,
                      ),
                    ),
                    TrailingItemTile(),
                  ],
                ),
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }
}
