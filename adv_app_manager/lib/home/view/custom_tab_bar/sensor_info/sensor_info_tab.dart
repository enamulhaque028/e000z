import 'dart:developer';

import 'package:advanced_app_manager/config/presentation/app_color.dart';
import 'package:advanced_app_manager/home/view/custom_tab_bar/sensor_info/sensor_details.dart';
import 'package:advanced_app_manager/native_service/native_service.dart';
import 'package:flutter/material.dart';

class SensorInfoTab extends StatefulWidget {
  const SensorInfoTab({
    Key? key,
  }) : super(key: key);

  @override
  State<SensorInfoTab> createState() => _SensorInfoTab();
}

class _SensorInfoTab extends State<SensorInfoTab> {
  List sensorList = [];
  bool isLoading = true;
  @override
  void initState() {
    NativeApiCall().getNativeData('', 'getSensorList').then((value) {
      setState(() {
        sensorList = value as List;
        isLoading = false;
      });
      log(value.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            itemCount: sensorList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SensorDetails(
                          index: index,
                          sensorList: sensorList,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        color: index % 2 == 0
                            ? const Color(0xFFF0F4F8)
                            : Colors.transparent,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Image.asset(
                                'assets/images/arrow.png',
                                height: 24,
                                width: 24,
                              ),
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SensorInfo(
                                    title: 'Name: ',
                                    info: sensorList[index]['mName'].toString(),
                                  ),
                                  SensorInfo(
                                    title: 'Vendor: ',
                                    info:
                                        sensorList[index]['mVendor'].toString(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }
}

class SensorInfo extends StatelessWidget {
  final String title;
  final String info;
  const SensorInfo({
    Key? key,
    required this.info,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: title,
        style: const TextStyle(
          color: AppColor.kPrimaryColor,
          fontWeight: FontWeight.w500,
        ),
        children: <TextSpan>[
          TextSpan(
            text: info,
            style: TextStyle(
              color: Colors.black.withOpacity(0.7),
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
