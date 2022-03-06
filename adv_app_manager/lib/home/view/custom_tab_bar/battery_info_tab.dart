// import 'package:advanced_app_manager/config/presentation/app_color.dart';
// import 'package:advanced_app_manager/widgets/widgets.dart';
// import 'package:battery_indicator/battery_indicator.dart';
// import 'package:battery_info/battery_info_plugin.dart';
// import 'package:battery_info/model/android_battery_info.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';

// class BatteryInfoTab extends HookConsumerWidget {
//   const BatteryInfoTab({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final batteryLevel = useState(0);
//     final batteryHealth = useState('');
//     final voltage = useState(0);
//     final chargingStatus = useState('');
//     final batteryCapacity = useState(0);
//     final technology = useState('');
//     final isLoading = useState(true);
//     useEffect(
//       () {
//         Future.microtask(() {
//           BatteryInfoPlugin()
//               .androidBatteryInfoStream
//               .listen((AndroidBatteryInfo? batteryInfo) {
//             batteryLevel.value = batteryInfo!.batteryLevel!;
//             batteryHealth.value = batteryInfo.health!;
//             voltage.value = batteryInfo.voltage!;
//             chargingStatus.value = batteryInfo.chargingStatus!.toString();
//             batteryCapacity.value = batteryInfo.batteryCapacity!;
//             technology.value = batteryInfo.technology!;
//           });
//           isLoading.value = false;
//         });
//       },
//       [
//         batteryLevel.value,
//         batteryHealth.value,
//         voltage.value,
//         chargingStatus.value,
//         batteryCapacity.value,
//         technology.value,
//       ],
//     );
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: isLoading.value
//           ? const Center(
//               child: CircularProgressIndicator(),
//             )
//           : Row(
//               children: [
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     RotatedBox(
//                       quarterTurns: -1,
//                       child: BatteryIndicator(
//                         style: BatteryIndicatorStyle.values[1],
//                         mainColor: AppColor.kPrimaryColor,
//                         size: 40,
//                         colorful: false,
//                         showPercentNum: false,
//                         percentNumSize: 16,
//                       ),
//                     ),
//                     const SizedBox(height: 3),
//                     Text(
//                       "${batteryLevel.value}%",
//                       style: const TextStyle(color: AppColor.kPrimaryColor),
//                     )
//                   ],
//                 ),
//                 const SizedBox(width: 20),
//                 SingleChildScrollView(
//                   child: SizedBox(
//                     width: MediaQuery.of(context).size.width - 110,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         AppInfoView(
//                           title: 'Battery Level:',
//                           info: "${batteryLevel.value}%",
//                         ),
//                         AppInfoView(
//                           title: 'Battery Health:',
//                           info: batteryHealth.value.toUpperCase(),
//                         ),
//                         AppInfoView(
//                           title: 'Voltage:',
//                           info: "${voltage.value} mV",
//                         ),
//                         AppInfoView(
//                           title: 'Charging Status:',
//                           info: (chargingStatus.value).split(".")[1],
//                         ),
//                         AppInfoView(
//                           title: 'Battery Capacity:',
//                           info: "${batteryCapacity.value / 1000} mAh",
//                         ),
//                         AppInfoView(
//                           title: 'Technology:',
//                           info: technology.value,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }

import 'package:advanced_app_manager/config/presentation/app_color.dart';
import 'package:advanced_app_manager/widgets/widgets.dart';
import 'package:battery_indicator/battery_indicator.dart';
import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/model/android_battery_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BatteryInfoTab extends HookConsumerWidget {
  const BatteryInfoTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final batteryLevel = useState(0);
    final batteryHealth = useState('');
    final voltage = useState(0);
    final chargingStatus = useState('');
    final batteryCapacity = useState(0);
    final technology = useState('');
    final isLoading = useState(true);
    useEffect(
      () {
        Future.microtask(() {
          BatteryInfoPlugin()
              .androidBatteryInfoStream
              .listen((AndroidBatteryInfo? batteryInfo) {
            batteryLevel.value = batteryInfo!.batteryLevel!;
            batteryHealth.value = batteryInfo.health!;
            voltage.value = batteryInfo.voltage!;
            chargingStatus.value = batteryInfo.chargingStatus!.toString();
            batteryCapacity.value = batteryInfo.batteryCapacity!;
            technology.value = batteryInfo.technology!;
          });
          isLoading.value = false;
        });
      },
      [
        batteryLevel.value,
        batteryHealth.value,
        voltage.value,
        chargingStatus.value,
        batteryCapacity.value,
        technology.value,
      ],
    );
    return isLoading.value
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 30.0,
                  bottom: 20.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RotatedBox(
                      quarterTurns: 0,
                      child: BatteryIndicator(
                        style: BatteryIndicatorStyle.values[1],
                        mainColor: AppColor.kPrimaryColor,
                        size: 50,
                        colorful: false,
                        showPercentNum: false,
                        percentNumSize: 16,
                      ),
                    ),
                    Text(
                      "${batteryLevel.value}%",
                      style: const TextStyle(
                        color: AppColor.kPrimaryColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        AppInfoView(
                          title: 'Battery Level',
                          info: "${batteryLevel.value}%",
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: VerticalDivider(),
                        ),
                        AppInfoView(
                          title: 'Battery Health',
                          info: batteryHealth.value.toUpperCase(),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: VerticalDivider(),
                        ),
                        AppInfoView(
                          title: 'Voltage',
                          info: "${voltage.value} mV",
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: VerticalDivider(),
                        ),
                        AppInfoView(
                          title: 'Charging Status',
                          info: (chargingStatus.value).split(".")[1],
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: VerticalDivider(),
                        ),
                        AppInfoView(
                          title: 'Battery Capacity',
                          info: "${batteryCapacity.value / 1000} mAh",
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: VerticalDivider(),
                        ),
                        AppInfoView(
                          title: 'Technology',
                          info: technology.value,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
  }
}
