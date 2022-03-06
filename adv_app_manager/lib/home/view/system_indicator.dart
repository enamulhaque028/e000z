import 'package:advanced_app_manager/config/presentation/app_color.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SystemInfoIndicator extends StatelessWidget {
  const SystemInfoIndicator({
    Key? key,
    required this.title,
    required this.pointerValue,
    required this.info,
    // this.heightFactor = 0.12,
  }) : super(key: key);

  final String title;
  final double pointerValue;
  // final double heightFactor;
  final Widget info;

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SfRadialGauge(
          title: GaugeTitle(
            text: title,
            textStyle: const TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
          enableLoadingAnimation: true,
          axes: [
            RadialAxis(
              startAngle: 270,
              endAngle: 270,
              interval: 50,
              canScaleToFit: true,
              showLabels: false,
              showTicks: false,
              pointers: [
                RangePointer(
                  // width: 5,
                  value: pointerValue,
                  gradient: SweepGradient(
                    colors: <Color>[
                      AppColor.kPrimaryColor,
                      AppColor.kPrimaryColor.withAlpha(170),
                    ],
                    stops: const [0.25, 0.8],
                  ),
                ),
              ],
            ),
          ],
        ),
        Positioned(
          top: 66.0,
          left: 16.0,
          child: Image.asset(
            'assets/images/swell.png',
            height: 73,
            width: 73,
          ),
        ),
        Positioned(
          top: 90,
          left: 20,
          child: info,
        ),
      ],
    );
  }
}
