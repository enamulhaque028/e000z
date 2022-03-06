import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';

class CountryListDialog extends StatefulWidget {
  final Function(String, String) onTapChangedCountry;

  const CountryListDialog({Key? key, required this.onTapChangedCountry})
      : super(key: key);
  @override
  State<CountryListDialog> createState() => _CountryListDialogState();
}

class _CountryListDialogState extends State<CountryListDialog> {
  // int value = 0;
  Country country = Country(countryName: '', countryCode: '');
  List<Country> countryList = [
    Country(countryName: 'All country', countryCode: 'all'),
    Country(countryName: 'Bangladesh', countryCode: 'BD'),
    Country(countryName: 'India', countryCode: 'IN'),
    Country(countryName: 'Canada', countryCode: 'CA'),
    Country(countryName: 'Italy', countryCode: 'IT'),
    Country(countryName: 'Brazil', countryCode: 'BRA'),
    Country(countryName: 'Spain', countryCode: 'ES'),
    Country(countryName: 'Japan', countryCode: 'JP'),
    Country(countryName: 'Pakistan', countryCode: 'PK'),
    Country(countryName: 'Thailand', countryCode: 'TH'),
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
              RadioListTile<Country>(
                value: countryList[index],
                groupValue: country,
                onChanged: (value) {
                  setState(() {
                    country = value!;
                  });
                  print(value!.countryName);
                  print(value.countryCode);
                  widget.onTapChangedCountry(
                    value.countryName,
                    value.countryCode,
                  );
                },
                title: Text(
                  '${countryList[index].countryName}',
                  style: TextStyle(
                    color: AppColor.primaryTextColor,
                  ),
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

class Country {
  String countryName;
  String countryCode;
  Country({
    required this.countryName,
    required this.countryCode,
  });
}
