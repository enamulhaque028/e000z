import 'dart:io';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share/share.dart';
import 'package:store_redirect/store_redirect.dart';

import '../../widgets/widgets.dart';
import '../providers/providers.dart';

class AppActivity extends HookConsumerWidget {
  const AppActivity({
    Key? key,
    required this.packageName,
    required this.version,
    required this.appPath,
    required this.openSetting,
  }) : super(key: key);

  final String packageName;
  final String version;
  final String appPath;
  final Future<bool> Function() openSetting;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apk = ref.watch(apkProvider);

    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 8.0),
      child: SizedBox(
        height: 60,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AppAction(
                imagePath: 'assets/images/trash.png',
                activityName: 'Uninstall',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CustomDialog(
                        title: 'Are you sure to uninstall?',
                        onTapYes: () async {
                          await apk.uninstallApp(packageName);
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  );
                },
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 12.0),
                child: VerticalDivider(),
              ),
              AppAction(
                imagePath: 'assets/images/force_stop.png',
                activityName: 'Force Stop',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CustomDialog(
                        title: 'Are you sure to force stop?',
                        onTapYes: () {
                          openSetting();
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  );
                },
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 12.0),
                child: VerticalDivider(),
              ),
              AppAction(
                imagePath: 'assets/images/backup.png',
                activityName: 'Backup',
                onTap: () async {
                  final status = await Permission.storage.request();

                  if (status.isGranted || status.isLimited) {
                    final file = File(appPath);
                    await copyFile(file, '$packageName-$version');
                    return CoolAlert.show(
                      context: context,
                      type: CoolAlertType.success,
                      text: "Backed up apk to app directory",
                      onConfirmBtnTap: () {
                        Navigator.of(context).pop();
                      },
                    );
                  }
                  return CoolAlert.show(
                    context: context,
                    type: CoolAlertType.info,
                    text: "Please give storage permission and try again",
                    onConfirmBtnTap: () {
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 12.0),
                child: VerticalDivider(),
              ),
              AppAction(
                imagePath: 'assets/images/cleaning.png',
                activityName: 'Cache Clear',
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CustomDialog(
                        title: 'Are you sure to clear cache?',
                        onTapYes: () {
                          openSetting();
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  );
                },
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 12.0),
                child: VerticalDivider(),
              ),
              AppAction(
                imagePath: 'assets/images/share.png',
                activityName: 'Share',
                onTap: () {
                  Share.shareFiles([appPath], text: 'Share Apk');
                },
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 12.0),
                child: VerticalDivider(),
              ),
              AppAction(
                imagePath: 'assets/images/playstore.png',
                activityName: 'Open in Store',
                onTap: () {
                  StoreRedirect.redirect(androidAppId: packageName);
                },
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 12.0),
                child: VerticalDivider(),
              ),
              AppAction(
                imagePath: 'assets/images/settings.png',
                activityName: 'Settings',
                onTap: () {
                  openSetting();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
