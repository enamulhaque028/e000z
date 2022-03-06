import 'package:advanced_app_manager/native_service/native_service.dart';
import 'package:advanced_app_manager/widgets/app_info_view.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class DisplayTab1 extends StatefulWidget {
  const DisplayTab1({
    Key? key,
    required this.appVersion,
    required this.lastUpdate,
    required this.packageName,
  }) : super(key: key);

  final String appVersion;
  final String lastUpdate;
  final String packageName;

  @override
  State<DisplayTab1> createState() => _DisplayTab1State();
}

class _DisplayTab1State extends State<DisplayTab1> {
  late Map permissionList;
  bool isLoading = true;
  @override
  void initState() {
    NativeApiCall()
        .getNativeData(widget.packageName, 'getPermissionList')
        .then((value) {
      setState(() {
        permissionList = value as Map;
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppInfoView(
                    title: 'App version',
                    info: widget.appVersion,
                  ),
                  AppInfoView(
                    title: 'Last update',
                    info: Jiffy(widget.lastUpdate).yMMMMEEEEdjm,
                  ),
                  AppInfoView(
                    title: 'Package name',
                    info: widget.packageName,
                  ),
                  AppInfoView(
                    title: 'Min SDK version',
                    info: permissionList['applicationInfo']['minSdkVersion']
                        .toString(),
                  ),
                  AppInfoView(
                    title: 'Process Name',
                    info: permissionList['applicationInfo']['processName']
                        .toString(),
                  ),
                  AppInfoView(
                    title: 'Target SDK version',
                    info: permissionList['applicationInfo']['targetSdkVersion']
                        .toString(),
                  ),
                  AppInfoView(
                    title: 'App class name',
                    info: permissionList['applicationInfo']['name'].toString(),
                  ),
                  AppInfoView(
                    title: 'Version code',
                    info: permissionList['applicationInfo']['versionCode']
                        .toString(),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
    );
  }
}
