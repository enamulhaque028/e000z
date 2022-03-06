import 'package:apk_admin/models/app.dart';
import 'package:flutter/foundation.dart';

@immutable
class AppData {
  const AppData({
    required this.app,
    required this.appPath,
    required this.size,
    required this.openSetting,
  });

  final App app;
  final String appPath;
  final String size;
  final Future<bool> Function() openSetting;

  AppData copyWith({
    App? app,
    String? appPath,
    String? size,
    bool? isSelected,
    Future<bool> Function()? openSetting,
  }) {
    return AppData(
      app: app ?? this.app,
      appPath: appPath ?? this.appPath,
      size: size ?? this.size,
      openSetting: openSetting ?? this.openSetting,
    );
  }
}
