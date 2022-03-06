import 'dart:io';
import 'dart:math';

import 'package:apk_admin/apk_admin.dart';
import 'package:app_usage/app_usage.dart';
import 'package:cpu_reader/cpu_reader.dart';
import 'package:device_apps/device_apps.dart';
import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:memory_info/memory_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:storage_space/storage_space.dart';

import '../models/models.dart';

enum AppListSort {
  none,
  name,
  size,
  installedDate,
  updatedDate,
}

final appListSort = StateProvider((_) => AppListSort.none);

class AppListNotifier extends StateNotifier<AsyncValue<List<AppData>>> {
  AppListNotifier() : super(const AsyncData([])) {
    getApps();
  }

  Future<void> getApps() async {
    state = const AsyncLoading();
    try {
      final apps = await _getAppList();

      state = AsyncData(apps);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<List<AppData>> _getAppList() async {
    final apps = await ApkScouter().getInstalledApps(
      includeAppIcon: true,
      includeSystemApps: true,
    );

    return Future.wait(
      apps.map((e) async {
        final app = await DeviceApps.getApp(e.packageName!);

        final size = await getFileSize(app!.apkFilePath, 2);
        return AppData(
          app: e,
          size: size,
          appPath: app.apkFilePath,
          openSetting: app.openSettingsScreen,
        );
      }).toList(),
    );
  }

  void updateAppInfo(ApplicationEvent event) {
    state.whenData((apps) async {
      switch (event.event) {
        case ApplicationEventType.uninstalled:
          final tempList = List<AppData>.from(apps);
          final index = tempList.indexWhere(
            (element) => element.app.packageName == event.packageName,
          );
          if (index != -1) {
            tempList.removeAt(index);
            state = AsyncData(tempList);
          }
          break;
        case ApplicationEventType.installed:
          final newList = await _getAppList();
          state = AsyncData(newList);
          break;
        case ApplicationEventType.updated:
          final newList = await _getAppList();
          state = AsyncData(newList);
          break;
        default:
          break;
      }
    });
  }
}

final appListProvider =
    StateNotifierProvider<AppListNotifier, AsyncValue<List<AppData>>>(
  (ref) => AppListNotifier(),
);

final appChangeProvider = StreamProvider.autoDispose<ApplicationEvent>((ref) {
  return DeviceApps.listenToAppsChanges();
});

final sortedAppsProvider = StateProvider<AsyncValue<List<AppData>>>((ref) {
  final sort = ref.watch(appListSort);
  final appsProvider = ref.watch(appListProvider);
  return appsProvider.when(
    data: (apps) {
      switch (sort.state) {
        case AppListSort.none:
          return AsyncData(apps);
        case AppListSort.name:
          final temp = List<AppData>.from(apps);
          return AsyncData(
            temp
              ..sort(
                (a, b) => a.app.appName!.compareTo(b.app.appName!),
              ),
          );
        case AppListSort.size:
          final temp = List<AppData>.from(apps);
          return AsyncData(
            temp
              ..sort(
                (a, b) => double.parse(a.size.split(' ')[0])
                    .compareTo(double.parse(b.size.split(' ')[0])),
              ),
          );
        case AppListSort.installedDate:
          final temp = List<AppData>.from(apps);
          return AsyncData(
            temp
              ..sort(
                (a, b) => b.app.installDate!.compareTo(a.app.installDate!),
              ),
          );
        case AppListSort.updatedDate:
          final temp = List<AppData>.from(apps);
          return AsyncData(
            temp
              ..sort(
                (a, b) =>
                    b.app.lastUpdateDate!.compareTo(a.app.lastUpdateDate!),
              ),
          );
        default:
          return AsyncData(apps);
      }
    },
    loading: () => const AsyncLoading(),
    error: (err, st) => AsyncError(err, st),
  );
});

final searchProvider = StateProvider<String>((ref) {
  return '';
});

final filteredAppsProvider = StateProvider<AsyncValue<List<AppData>>>((ref) {
  final appsProvider = ref.watch(sortedAppsProvider);
  final search = ref.watch(searchProvider).state;
  return appsProvider.state.when(
    data: (apps) {
      if (search.isEmpty) {
        return AsyncData(apps);
      }
      return AsyncData(
        apps
            .where(
              (app) =>
                  app.app.appName!
                      .toLowerCase()
                      .contains(search.toLowerCase()) ||
                  app.app.packageName!
                      .toLowerCase()
                      .contains(search.toLowerCase()),
            )
            .toList(),
      );
    },
    loading: () => const AsyncLoading(),
    error: (err, st) => AsyncError(err, st),
  );
});

class SelectedAppList extends StateNotifier<List<AppData>> {
  SelectedAppList() : super(const []);

  void selectApp(AppData app) {
    final selectedIndex = state.indexWhere(
      (element) => element.app.packageName == app.app.packageName,
    );
    if (selectedIndex == -1) {
      final tempState = List<AppData>.from(state);
      tempState.add(app);
      state = tempState;
    } else {
      final tempState = List<AppData>.from(state);
      tempState.removeAt(selectedIndex);
      state = tempState;
    }
  }
}

final selectedAppListProvider =
    StateNotifierProvider<SelectedAppList, List<AppData>>((ref) {
  return SelectedAppList();
});

final selectionProvider = StateProvider<bool>((ref) {
  return false;
});

final apkProvider = Provider<ApkController>((ref) {
  return ApkController();
});

final apkExportProvider = Provider<ApkExporter>((ref) {
  return ApkExporter();
});

final backupProvider = Provider<ApkBackup>((ref) {
  return ApkBackup();
});

final backupListProvider = FutureProvider<Map?>((ref) {
  return ApkScouter().getBackups();
});

final systemInfoProvider = StreamProvider.autoDispose<SystemInfo>((ref) {
  return CpuReader.cpuStream(2000).asyncMap<SystemInfo>((event) async {
    var maxCpu = 0.0;
    if (event.minMaxFrequencies != null) {
      for (final item in event.minMaxFrequencies!.keys) {
        maxCpu = maxCpu +
            double.parse(
              event.minMaxFrequencies![item]!.max.toString(),
            );
      }
      maxCpu = maxCpu / event.minMaxFrequencies!.keys.length;
    }

    var currentCpu = 0.0;
    if (event.currentFrequencies != null) {
      for (final item in event.currentFrequencies!.keys) {
        currentCpu = currentCpu +
            double.parse(
              event.currentFrequencies![item].toString(),
            );
      }
      currentCpu = currentCpu / event.currentFrequencies!.keys.length;
    }
    final avgCpu = (currentCpu / maxCpu) * 100;
    final cpuTemp = event.cpuTemperature;
    final cpuAbi = event.abi;
    final cpuNumberOfCores = event.numberOfCores;
    final memInfo = await MemoryInfoPlugin().memoryInfo;
    final avgFreeMemory =
        ((memInfo.freeMem ?? 0) / (memInfo.totalMem ?? 1)) * 100;
    final usedMemory = (memInfo.totalMem ?? 0) - (memInfo.freeMem ?? 0);
    final storageSpace = await getStorageSpace(
      lowOnSpaceThreshold: 2 * 1024 * 1024 * 1024,
      fractionDigits: 1,
    ).then((value) => value);

    return SystemInfo(
      cpuUsage: avgCpu,
      totalCpu: maxCpu,
      cpuTemperature: cpuTemp!,
      cpuAbi: cpuAbi!,
      cpuNumberOfCores: cpuNumberOfCores!,
      totalDisk: storageSpace.totalSize,
      totalMemory: (memInfo.totalMem ?? 0) / 1024,
      freeDisk: storageSpace.freeSize,
      cpuFrequency: '$currentCpu Mhz',
      usedMemory: ' ${(usedMemory / 1024).toStringAsFixed(1)} GB',
      memoryUsage: 100 - avgFreeMemory,
      diskUsage: storageSpace.usagePercent.toDouble(),
    );
  });
});

class AppUsageNotifier extends StateNotifier<AsyncValue<AppUsageInfo?>> {
  AppUsageNotifier() : super(const AsyncData(null));

  Future<void> getusage({
    required String packageName,
    required DateTime beginTime,
    required DateTime endTime,
  }) async {
    state = const AsyncLoading();
    try {
      final appInfos = await AppUsage.getAppUsage(beginTime, endTime);
      final index =
          appInfos.indexWhere((element) => element.packageName == packageName);
      if (index != -1) {
        state = AsyncData(appInfos[index]);
      } else {
        state = const AsyncData(null);
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

// final appUsageProvider =
//     FutureProvider.family<AppUsageInfo?, IAppUsageParameter>(
//         (ref, params) async {
//   final appInfos = await AppUsage.getAppUsage(params.beginTime, params.endTime);
//   // developer.log(appInfos.toString());
//   final index = appInfos
//       .indexWhere((element) => element.packageName == params.packageName);
//   if (index != -1) {
//     return appInfos[index];
//   } else {
//     return null;
//   }
// });

final appUsageProvider = StateNotifierProvider.family<AppUsageNotifier,
    AsyncValue<AppUsageInfo?>, IAppUsageParameter>((ref, params) {
  return AppUsageNotifier()
    ..getusage(
      packageName: params.packageName,
      beginTime: params.beginTime,
      endTime: params.endTime,
    );
});

Future<String> getFileSize(String filepath, int decimals) async {
  final file = File(filepath);
  final bytes = await file.length();
  if (bytes <= 0) return "0 B";
  // const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  // final i = (log(bytes) / log(1024)).floor();
  // debugPrint(i.toString());
  return '${(bytes / pow(1024, 2)).toStringAsFixed(decimals)}  MB';
}

Future<void> deleteCache(String packageName) async {
  final cachePath =
      '${(await getTemporaryDirectory()).parent.parent.path}/$packageName/cache';

  final cacheDir = Directory(cachePath);
  if (cacheDir.existsSync()) {
    cacheDir.deleteSync(recursive: true);
  }
}

Future<File> copyFile(File sourceFile, String name) async {
  final path = await createFolder('com.ar.aam');
  final orginalName = sourceFile.path.split('/').last;
  final newFile =
      await sourceFile.copy('$path/$name.${orginalName.split('.').last}');
  return newFile;
}

Future<String> createFolder(String folderName) async {
  //Get this App Document Directory
  final root =
      (await getExternalStorageDirectory())!.parent.parent.parent.parent;
  //App Document Directory + folder name
  final Directory _appDocDirFolder = Directory('${root.path}/$folderName/');

  if (await _appDocDirFolder.exists()) {
    //if folder already exists return path
    return _appDocDirFolder.path;
  } else {
    //if folder not exists create folder and then return its path
    final Directory _appDocDirNewFolder =
        await _appDocDirFolder.create(recursive: true);
    return _appDocDirNewFolder.path;
  }
}

class SystemInfo {
  SystemInfo({
    required this.cpuUsage,
    required this.totalCpu,
    required this.cpuFrequency,
    required this.freeDisk,
    required this.totalDisk,
    required this.usedMemory,
    required this.diskUsage,
    required this.memoryUsage,
    required this.totalMemory,
    required this.cpuTemperature,
    required this.cpuAbi,
    required this.cpuNumberOfCores,
  });

  final double cpuUsage;
  final double totalCpu;
  final String cpuFrequency;
  final String freeDisk;
  final String totalDisk;
  final String usedMemory;
  final double diskUsage;
  final double memoryUsage;
  final double totalMemory;
  final double cpuTemperature;
  final String cpuAbi;
  final int cpuNumberOfCores;
}

class IAppUsageParameter extends Equatable {
  const IAppUsageParameter({
    required this.packageName,
    required this.beginTime,
    required this.endTime,
  });

  final String packageName;
  final DateTime beginTime;
  final DateTime endTime;

  @override
  List<Object> get props => [packageName, beginTime, endTime];
}
