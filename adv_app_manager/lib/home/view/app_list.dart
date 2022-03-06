import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import '../../config/presentation/app_color.dart';
import '../../widgets/widgets.dart';
import '../providers/providers.dart';
import 'display_tabs/display_tabs.dart';
import 'view.dart';

class AppListTile extends ConsumerWidget {
  const AppListTile({
    Key? key,
    this.appIcon,
    required this.appName,
    required this.appSize,
    required this.appUpdate,
    required this.onOpen,
    required this.openSetting,
    required this.packageName,
    required this.version,
    required this.appPath,
    required this.isSelected,
  }) : super(key: key);

  final Uint8List? appIcon;
  final String appName;
  final String appSize;
  final String appUpdate;
  final void Function() onOpen;
  final Future<bool> Function() openSetting;
  final String packageName;
  final String version;
  final String appPath;
  final bool isSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selection = ref.watch(selectionProvider);
    return Expandable(
      header: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: appIcon != null
                ? Image.memory(
                    appIcon!,
                    height: 45,
                    width: 45,
                  )
                : Image.asset(
                    'assets/images/app_icon.png',
                    height: 45,
                    width: 45,
                  ),
          ),
          const SizedBox(
            width: 8,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 237,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    text: TextSpan(
                      text: appName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: ' $version',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        appSize,
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                        ),
                      ),
                      Flexible(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3 - 5,
                          child: Text(
                            '  ● Updated on ${Jiffy(appUpdate).MMMd}',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      headerTrailing: selection.state
          ? isSelected
              ? Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.shade400,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.done_sharp,
                    size: 12,
                    color: Colors.white,
                  ),
                )
              : const Icon(
                  Icons.circle_outlined,
                  color: Colors.black26,
                )
          : CustomButton(
              title: 'Open',
              btnTextColor: AppColor.kPrimaryColor,
              onTap: onOpen,
            ),
      children: [
        AppActivity(
          packageName: packageName,
          appPath: appPath,
          version: version,
          openSetting: openSetting,
        ),
        DefaultTabController(
          length: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Material(
                color: Color(0xFFEFF3F7),
                child: TabBar(
                  labelColor: AppColor.kPrimaryColor,
                  indicatorColor: AppColor.kPrimaryColor,
                  labelStyle:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  unselectedLabelStyle:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                  isScrollable: true,
                  unselectedLabelColor: Colors.black54,
                  tabs: [
                    Tab(text: 'Info'),
                    Tab(text: 'Permission List'),
                    Tab(text: 'Activity List'),
                    Tab(text: 'Provider List'),
                    Tab(text: 'Receiver List'),
                    // Tab(text: 'Service Control'),
                    Tab(text: 'App Usage'),
                  ],
                ),
              ),
              SizedBox(
                height: 170, //height of TabBarView
                child: TabBarView(
                  children: <Widget>[
                    DisplayTab1(
                      appVersion: version,
                      lastUpdate: appUpdate,
                      packageName: packageName,
                    ),
                    DisplayTab2(packageName: packageName),
                    DisplayTab3(packageName: packageName),
                    DisplayTab4(packageName: packageName),
                    DisplayTab5(packageName: packageName),
                    // DisplayTab6(
                    //   openSetting: openSetting,
                    //   packageName: packageName,
                    // ),
                    DisplayTab7(
                      packageName: packageName,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
