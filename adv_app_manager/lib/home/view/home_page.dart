import 'dart:developer';
import 'dart:io';

import 'package:device_apps/device_apps.dart';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../config/presentation/app_color.dart';
import '../providers/providers.dart';
import 'custom_tab_bar/custom_tabbar.dart';
import 'view.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(
      () {
        // InterstitialAd.load(
        //   adUnitId: 'ca-app-pub-2701467906190135/8650962396',
        //   request: const AdRequest(),
        //   adLoadCallback: InterstitialAdLoadCallback(
        //     onAdLoaded: (InterstitialAd ad) {
        //       // Keep a reference to the ad so you can show it later.
        //       final interstitialAd = ad;
        //       interstitialAd.fullScreenContentCallback =
        //           FullScreenContentCallback(
        //         onAdShowedFullScreenContent: (InterstitialAd ad) =>
        //             log('$ad onAdShowedFullScreenContent.'),
        //         onAdDismissedFullScreenContent: (InterstitialAd ad) {
        //           log('$ad onAdDismissedFullScreenContent.');
        //           ad.dispose();
        //         },
        //         onAdFailedToShowFullScreenContent:
        //             (InterstitialAd ad, AdError error) {
        //           log('$ad onAdFailedToShowFullScreenContent: $error');
        //           ad.dispose();
        //         },
        //         onAdImpression: (InterstitialAd ad) =>
        //             log('$ad impression occurred.'),
        //       );
        //       interstitialAd.show();
        //     },
        //     onAdFailedToLoad: (LoadAdError error) {
        //       log('InterstitialAd failed to load: $error');
        //     },
        //   ),
        // );

        Future.microtask(() async {
          await FacebookAudienceNetwork.init();
          _loadRewardedVideoAd();
        });
      },
      [],
    );
    final size = MediaQuery.of(context).size;
    final apps = ref.watch(filteredAppsProvider);
    final selectedApps = ref.watch(selectedAppListProvider);
    final apk = ref.watch(apkProvider);
    final isSelected = ref.watch(selectionProvider);
    final systemInfo = ref.watch(systemInfoProvider);
    ref.listen<AsyncValue<ApplicationEvent>>(appChangeProvider, (event) {
      event.whenData((value) {
        ref.read(appListProvider.notifier).updateAppInfo(value);
      });
    });

    return WillPopScope(
      onWillPop: () async {
        if (isSelected.state) {
          // ignore: invalid_use_of_protected_member
          ref.read(selectedAppListProvider.notifier).state = const [];
          isSelected.state = false;
          return false;
        }
        return exitDialog(context);
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFf0f4f8),
        appBar: AppBar(
          backgroundColor: AppColor.kPrimaryColor,
          elevation: 1.0,
          title: const Center(
            child: Text(
              'Advance App Manager',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
              SliverPadding(
                padding: const EdgeInsets.only(
                  top: 16,
                  left: 12,
                  right: 12,
                  bottom: 12,
                ),
                sliver: SliverList(
                  delegate: SliverChildListDelegate.fixed(
                    [
                      CustomTabBar(
                        systemInfo: systemInfo,
                      ),
                    ],
                  ),
                ),
              ),
              const SliverAppBar(
                elevation: 0,
                pinned: true,
                centerTitle: false,
                backgroundColor: Color(0xFFf0f4f8),
                title: SearchBar(),
              ),
              SliverAppBar(
                elevation: 0,
                pinned: true,
                centerTitle: false,
                backgroundColor: const Color(0xFFf0f4f8),
                title: FacebookBannerAd(
                  placementId: '385452763235730_385458376568502',
                  listener: (result, value) {
                    switch (result) {
                      case BannerAdResult.ERROR:
                        log("Error: $value");
                        break;
                      case BannerAdResult.LOADED:
                        log("Loaded: $value");
                        break;
                      case BannerAdResult.CLICKED:
                        log("Clicked: $value");
                        break;
                      case BannerAdResult.LOGGING_IMPRESSION:
                        log("Logging Impression: $value");
                        break;
                    }
                  },
                ),
              )
            ];
          },
          body: Padding(
            padding:
                const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
            child: Card(
              color: const Color(0xFFFFFFFF),
              // elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.only(top: 16),
                    sliver: apps.state.when(
                      data: (data) {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              var tempIndex = index;
                              if (index == 0) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Apps(${data.length})',
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          const PopupMenu()
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1.3,
                                      color: Colors.grey.withOpacity(0.2),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                );
                              }
                              tempIndex = tempIndex - 1;
                              final item = data[tempIndex];
                              final version = item.app.versionName;
                              final selectedIndex = selectedApps.indexWhere(
                                (element) =>
                                    element.app.packageName ==
                                    item.app.packageName,
                              );
                              return InkWell(
                                onLongPress: isSelected.state
                                    ? null
                                    : () {
                                        isSelected.state = true;
                                        ref
                                            .read(
                                              selectedAppListProvider.notifier,
                                            )
                                            .selectApp(item);
                                      },
                                onTap: isSelected.state
                                    ? () {
                                        ref
                                            .read(
                                              selectedAppListProvider.notifier,
                                            )
                                            .selectApp(item);
                                      }
                                    : null,
                                child: Column(
                                  children: [
                                    AppListTile(
                                      key: Key('${item.app.packageName}'),
                                      packageName: item.app.packageName ?? '',
                                      appIcon: item.app.decodedIcon,
                                      appPath: item.appPath,
                                      isSelected: selectedIndex != -1,
                                      version:
                                          'v${version?.substring(0, version.length < 6 ? null : 6)}',
                                      appName: '${item.app.appName}',
                                      appSize: item.size,
                                      appUpdate: item.app.lastUpdateDate ??
                                          DateTime.now().toIso8601String(),
                                      onOpen: () =>
                                          apk.launchApp(item.app.packageName!),
                                      openSetting: item.openSetting,
                                    ),
                                    if (index % 9 == 0) ...[
                                      if (index % 12 != 0)
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0,
                                          ),
                                          child: FacebookBannerAd(
                                            placementId:
                                                '385452763235730_385458376568502',
                                            listener: (result, value) {
                                              switch (result) {
                                                case BannerAdResult.ERROR:
                                                  log("Error: $value");
                                                  break;
                                                case BannerAdResult.LOADED:
                                                  log("Loaded: $value");
                                                  break;
                                                case BannerAdResult.CLICKED:
                                                  log("Clicked: $value");
                                                  break;
                                                case BannerAdResult
                                                    .LOGGING_IMPRESSION:
                                                  log("Logging Impression: $value");
                                                  break;
                                              }
                                            },
                                          ),
                                        ),
                                      if (index % 12 == 0)
                                        FacebookNativeAd(
                                          placementId:
                                              "385452763235730_385456819901991",
                                          adType: NativeAdType.NATIVE_AD,
                                          width: double.maxFinite,
                                          height: 200,
                                          backgroundColor: Colors.blue,
                                          titleColor: Colors.white,
                                          descriptionColor: Colors.white,
                                          buttonColor: AppColor.kPrimaryColor,
                                          buttonTitleColor: Colors.white,
                                          buttonBorderColor: Colors.white,
                                          keepAlive:
                                              true, //set true if you do not want adview to refresh on widget rebuild
                                          keepExpandedWhileLoading:
                                              false, // set false if you want to collapse the native ad view when the ad is loading
                                          expandAnimationDuraion:
                                              300, //in milliseconds. Expands the adview with animation when ad is loaded
                                          listener: (result, value) {
                                            switch (result) {
                                              case NativeAdResult.ERROR:
                                                log("Native Error: $value");
                                                break;
                                              case NativeAdResult.LOADED:
                                                log("Loaded: $value");
                                                break;
                                              case NativeAdResult.CLICKED:
                                                log("Clicked: $value");
                                                break;
                                              case NativeAdResult
                                                  .LOGGING_IMPRESSION:
                                                log("Logging Impression: $value");
                                                break;
                                              case NativeAdResult
                                                  .MEDIA_DOWNLOADED:
                                                log("Media Downloaded: $value");
                                                break;
                                            }
                                          },
                                        ),
                                    ],
                                  ],
                                ),
                              );
                            },
                            childCount: data.length + 1,
                          ),
                        );
                      },
                      loading: () => SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate.fixed(
                            [
                              const ShimerListTitle(),
                              for (var i = 0;
                                  i < (size.height / 100).floor();
                                  i++)
                                const ShimerListTile()
                            ],
                          ),
                        ),
                      ),
                      error: (error, st) => SliverList(
                        delegate: SliverChildListDelegate([
                          const Center(child: Text('Something went wrong!')),
                        ]),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void _loadRewardedVideoAd() {
  FacebookInterstitialAd.loadInterstitialAd(
    placementId: "385452763235730_385456819901991",
    listener: (result, value) {
      if (result == InterstitialAdResult.LOADED) {
        FacebookInterstitialAd.showInterstitialAd(delay: 5000);
      }
    },
  );
}
