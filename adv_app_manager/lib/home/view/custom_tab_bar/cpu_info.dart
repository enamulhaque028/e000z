import 'package:advanced_app_manager/config/presentation/app_color.dart';
import 'package:flutter/material.dart';
import '../view.dart';
import 'custom_tabbar.dart';

class CpuInfoTab extends StatelessWidget {
  const CpuInfoTab({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final CustomTabBar widget;

  @override
  Widget build(BuildContext context) {
    return widget.systemInfo.when(
      loading: () => const ShimerSystemInfo(),
      error: (err, st) => const Center(
        child: Text('Error fetching system Info'),
      ),
      data: (data) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CpuInfoView(
              title: 'CPU abi: ',
              info: data.cpuAbi,
              isColoured: false,
            ),
            CpuInfoView(
              title: 'Number of Cores: ',
              info: data.cpuNumberOfCores.toString(),
              isColoured: true,
            ),
            CpuInfoView(
              title: 'CPU Temprature: ',
              info: '${data.cpuTemperature.toString()} °C',
              isColoured: false,
            ),
            CpuInfoView(
              title: 'Current Frequency: ',
              info: data.cpuFrequency,
              isColoured: true,
            ),
            CpuInfoView(
              title: 'Total CPU: ',
              info: '${data.totalCpu.toString()} Mhz',
              isColoured: false,
            ),
          ],
        ),
      ),
    );
  }
}

class CpuInfoView extends StatelessWidget {
  const CpuInfoView({
    Key? key,
    required this.title,
    required this.info,
    required this.isColoured,
  }) : super(key: key);

  final String title;
  final String info;
  final bool isColoured;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          color: isColoured ? const Color(0xFFF0F4F8) : Colors.transparent,
        ),
        child: Row(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Image.asset(
                'assets/images/arrow.png',
                height: 24,
                width: 24,
              ),
            ),
            RichText(
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
            )
          ],
        ),
      ),
    );
  }
}
