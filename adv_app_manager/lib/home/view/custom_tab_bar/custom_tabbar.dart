import 'package:advanced_app_manager/config/presentation/app_color.dart';
import 'package:advanced_app_manager/home/providers/providers.dart';
import 'package:advanced_app_manager/home/view/custom_tab_bar/cpu_info.dart';
import 'package:advanced_app_manager/home/view/custom_tab_bar/sensor_info/sensor_info_tab.dart';
import 'package:advanced_app_manager/home/view/custom_tab_bar/system_features.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'battery_info_tab.dart';
import 'os_info_tab.dart';
import 'system_info_tab.dart';

class CustomTabBar extends StatefulWidget {
  const CustomTabBar({Key? key, required this.systemInfo}) : super(key: key);
  final AsyncValue<SystemInfo> systemInfo;
  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 6, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(
              25.0,
            ),
          ),
          child: TabBar(
            isScrollable: true,
            controller: _tabController,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(
                25.0,
              ),
              color: AppColor.kPrimaryColor,
            ),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            tabs: const [
              Tab(
                text: 'System Info',
              ),
              Tab(
                text: 'OS Info',
              ),
              Tab(
                text: 'Battery Info',
              ),
              Tab(
                text: 'CPU Info',
              ),
              Tab(
                text: 'Sensor Info',
              ),
              Tab(
                text: 'System Features',
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 12.0),
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
            child: SizedBox(
              height: 200,
              child: TabBarView(
                controller: _tabController,
                children: [
                  SystemInfoTab(widget: widget),
                  const OsInfoTab(),
                  const BatteryInfoTab(),
                  CpuInfoTab(
                    widget: widget,
                  ),
                  const SensorInfoTab(),
                  const SystemFeatures(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
