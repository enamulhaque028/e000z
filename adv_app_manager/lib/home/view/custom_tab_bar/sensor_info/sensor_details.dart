import 'dart:developer';

import 'package:advanced_app_manager/config/presentation/app_color.dart';
import 'package:advanced_app_manager/widgets/widgets.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';

// import 'sensor_info_tab.dart';

class SensorDetails extends StatelessWidget {
  final int index;
  final List sensorList;
  const SensorDetails({
    Key? key,
    required this.index,
    required this.sensorList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFf0f4f8),
      appBar: AppBar(
        backgroundColor: AppColor.kPrimaryColor,
        elevation: 1.0,
        centerTitle: true,
        title: const Text(
          'Advance App Manager',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: width,
            height: height * 0.70,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.1),
                  blurRadius: 25.0,
                  spreadRadius: -25.0,
                  offset: const Offset(
                    25.0,
                    25.0,
                  ),
                ),
              ],
            ),
            child: Card(
              color: const Color(0xFFFFFFFF),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppInfoView(
                        title: 'Fifo Max Event Count',
                        info:
                            sensorList[index]['mFifoMaxEventCount'].toString(),
                      ),
                      AppInfoView(
                        title: 'Fifo Reserved Event Count',
                        info: sensorList[index]['mFifoReservedEventCount']
                            .toString(),
                      ),
                      AppInfoView(
                        title: 'Flags',
                        info: sensorList[index]['mFlags'].toString(),
                      ),
                      AppInfoView(
                        title: 'Handle',
                        info: sensorList[index]['mHandle'].toString(),
                      ),
                      AppInfoView(
                        title: 'Id',
                        info: sensorList[index]['mId'].toString(),
                      ),
                      AppInfoView(
                        title: 'Max Delay',
                        info: sensorList[index]['mMaxDelay'].toString(),
                      ),
                      AppInfoView(
                        title: 'Max Range',
                        info: sensorList[index]['mMaxRange'].toString(),
                      ),
                      AppInfoView(
                        title: 'Min Delay',
                        info: sensorList[index]['mMinDelay'].toString(),
                      ),
                      AppInfoView(
                        title: 'Name',
                        info: sensorList[index]['mName'].toString(),
                      ),
                      AppInfoView(
                        title: 'Power',
                        info: sensorList[index]['mPower'].toString(),
                      ),
                      AppInfoView(
                        title: 'Required Permission',
                        info:
                            sensorList[index]['mRequiredPermission'].toString(),
                      ),
                      AppInfoView(
                        title: 'Resolution',
                        info: sensorList[index]['mResolution'].toString(),
                      ),
                      AppInfoView(
                        title: 'String Type',
                        info: sensorList[index]['mStringType'].toString(),
                      ),
                      AppInfoView(
                        title: 'Type',
                        info: sensorList[index]['mType'].toString(),
                      ),
                      AppInfoView(
                        title: 'Vendor',
                        info: sensorList[index]['mVendor'].toString(),
                      ),
                      AppInfoView(
                        title: 'Version',
                        info: sensorList[index]['mVersion'].toString(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          FacebookNativeAd(
            placementId: "385452763235730_385458733235133",
            adType: NativeAdType.NATIVE_AD,
            width: double.maxFinite,
            height: height * 0.2,
            backgroundColor: Colors.blue,
            titleColor: Colors.white,
            descriptionColor: Colors.white,
            buttonColor: AppColor.kPrimaryColor,
            buttonTitleColor: Colors.white,
            buttonBorderColor: Colors.white,
            keepAlive:
                true, //set true if you do not want adview to refresh on widget rebuild
            keepExpandedWhileLoading:
                false, // set false if you want to collapse the native ad view when the ad is loading
            expandAnimationDuraion:
                300, //in milliseconds. Expands the adview with animation when ad is loaded
            listener: (result, value) {
              switch (result) {
                case NativeAdResult.ERROR:
                  log("Native Error: $value");
                  break;
                case NativeAdResult.LOADED:
                  log("Loaded: $value");
                  break;
                case NativeAdResult.CLICKED:
                  log("Clicked: $value");
                  break;
                case NativeAdResult.LOGGING_IMPRESSION:
                  log("Logging Impression: $value");
                  break;
                case NativeAdResult.MEDIA_DOWNLOADED:
                  log("Media Downloaded: $value");
                  break;
              }
            },
          ),
        ],
      ),
    );
  }
}
