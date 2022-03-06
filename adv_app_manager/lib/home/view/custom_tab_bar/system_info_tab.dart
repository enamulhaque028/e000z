import 'package:advanced_app_manager/config/presentation/app_color.dart';
import 'package:advanced_app_manager/home/view/view.dart';
import 'package:flutter/material.dart';
import 'custom_tabbar.dart';

class SystemInfoTab extends StatelessWidget {
  const SystemInfoTab({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final CustomTabBar widget;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: widget.systemInfo.when(
        data: (data) => SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 105,
                  child: SystemInfoIndicator(
                    title: 'CPU info',
                    info: RichText(
                      text: TextSpan(
                        text: data.cpuFrequency,
                        style: const TextStyle(
                          color: AppColor.kPrimaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '/\n${data.totalCpu.toStringAsFixed(2)} Mhz',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    pointerValue: data.cpuUsage,
                  ),
                ),
                SizedBox(
                  width: 105,
                  child: SystemInfoIndicator(
                    title: 'RAM info',
                    info: RichText(
                      text: TextSpan(
                        text: '      ${data.usedMemory}',
                        style: const TextStyle(
                          color: AppColor.kPrimaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                '/\n       ${data.totalMemory.toStringAsFixed(1)} GB',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    pointerValue: data.memoryUsage,
                  ),
                ),
                SizedBox(
                  width: 105,
                  child: SystemInfoIndicator(
                    title: 'Disk info',
                    info: RichText(
                      text: TextSpan(
                        text: '      ${data.totalDisk}',
                        style: const TextStyle(
                          color: AppColor.kPrimaryColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: '/\n      ${data.diskUsage} GB',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                    pointerValue: data.diskUsage,
                  ),
                ),
              ],
            ),
          ),
        ),
        loading: () => const ShimerSystemInfo(),
        error: (err, st) => const Center(
          child: Text('Error fetching system Info'),
        ),
      ),
    );
  }
}
