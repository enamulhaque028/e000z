import 'package:advanced_app_manager/widgets/widgets.dart';
import 'package:app_usage/app_usage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../config/presentation/app_color.dart';

class DisplayTab7 extends HookConsumerWidget {
  const DisplayTab7({
    Key? key,
    required this.packageName,
  }) : super(key: key);

  final String packageName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customUsage = useState<AppUsageInfo?>(null);
    final dailyUsage = useState<AppUsageInfo?>(null);
    final yesterdayUsage = useState<AppUsageInfo?>(null);
    final monthyUsage = useState<AppUsageInfo?>(null);
    final startDate = useState(
      DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
      ),
    );
    final endDate = useState(DateTime.now());
    useEffect(
      () {
        Future.microtask(() async {
          final appUsage = await getAppUsage(
            startDate: startDate.value,
            endDate: endDate.value,
            packageName: packageName,
          );
          if (appUsage != null) {
            customUsage.value = appUsage;
          }

          final todayEnd = DateTime.now();
          final todayStart = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          );
          dailyUsage.value = await getAppUsage(
            startDate: todayStart,
            endDate: todayEnd,
            packageName: packageName,
          );

          final yesterDayStart = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day - 1,
          );
          final yesterDayEnd = yesterDayStart.add(
            const Duration(
              hours: 23,
              minutes: 59,
              seconds: 59,
              milliseconds: 999,
            ),
          );
          yesterdayUsage.value = await getAppUsage(
            startDate: yesterDayStart,
            endDate: yesterDayEnd,
            packageName: packageName,
          );

          final monthStart = DateTime(
            DateTime.now().year,
            DateTime.now().month,
          );
          final monthEnd = DateTime(
            DateTime.now().year,
            monthStart.month + 1,
            0,
            23,
            59,
            59,
            999,
          );
          monthyUsage.value = await getAppUsage(
            startDate: monthStart,
            endDate: monthEnd,
            packageName: packageName,
          );
        });
      },
      [startDate.value, endDate.value],
    );

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppInfoView(
              title: 'Today',
              info: '${dailyUsage.value?.usage.inMinutes ?? 0} Minutes',
            ),
            AppInfoView(
              title: 'Yesterday',
              info: '${yesterdayUsage.value?.usage.inMinutes ?? 0} Minutes',
            ),
            AppInfoView(
              title: 'Current Month',
              info: '${monthyUsage.value?.usage.inMinutes ?? 0} Minutes',
            ),
            const Text(
              'Custom',
              style: TextStyle(
                fontSize: 14,
                color: AppColor.kPrimaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            FittedBox(
              child: InkWell(
                onTap: () {
                  showDialog(
                    barrierColor: Colors.transparent,
                    context: context,
                    builder: (ctx) => AlertDialog(
                      content: Container(
                        width: double.maxFinite,
                        height: 250,
                        alignment: Alignment.center,
                        child: SfDateRangePicker(
                          showNavigationArrow: true,
                          selectionColor: AppColor.kPrimaryColor,
                          maxDate: DateTime.now(),
                          onSelectionChanged:
                              (DateRangePickerSelectionChangedArgs args) {
                            final range = args.value as PickerDateRange;
                            if (range.startDate != null) {
                              startDate.value = range.startDate!;
                            }
                            if (range.endDate != null) {
                              endDate.value = range.endDate!;
                            }
                          },
                          selectionMode: DateRangePickerSelectionMode.range,
                          headerHeight: 60,
                          headerStyle: const DateRangePickerHeaderStyle(
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${Jiffy(startDate.value).yMMMdjm} - ${Jiffy(endDate.value).yMMMdjm}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColor.kPrimaryColor,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                '${customUsage.value?.usage.inMinutes ?? 0} Minutes',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  // fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<AppUsageInfo?> getAppUsage({
  required DateTime startDate,
  required DateTime endDate,
  required String packageName,
}) async {
  final appInfos = await AppUsage.getAppUsage(
    startDate,
    endDate,
  );
  // developer.log(appInfos.toString());
  final index =
      appInfos.indexWhere((element) => element.packageName == packageName);
  if (index != -1) {
    return appInfos[index];
  }
  return null;
}

// class AppUsageView extends StatelessWidget {
//   const AppUsageView({
//     Key? key,
//     required this.title,
//     required this.info,
//   }) : super(key: key);

//   final String title;
//   final String info;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: 16,
//             color: Colors.black.withOpacity(0.7),
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//         Text(
//           info == 'null' ? '' : info,
//           style: const TextStyle(
//             fontSize: 14,
//             color: Colors.grey,
//           ),
//         ),
//         const SizedBox(
//           height: 16,
//         ),
//       ],
//     );
//   }
// }
