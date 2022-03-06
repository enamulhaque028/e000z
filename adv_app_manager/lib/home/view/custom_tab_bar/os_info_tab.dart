import 'package:advanced_app_manager/widgets/widgets.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';

class OsInfoTab extends StatefulWidget {
  const OsInfoTab({
    Key? key,
  }) : super(key: key);

  @override
  State<OsInfoTab> createState() => _OsInfoTabState();
}

class _OsInfoTabState extends State<OsInfoTab> {
  late AndroidDeviceInfo androidInfo;
  bool isLoading = true;
  @override
  void initState() {
    getInfo();
    super.initState();
  }

  Future<AndroidDeviceInfo> getInfo() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    androidInfo = await deviceInfo.androidInfo;
    setState(() {
      isLoading = false;
    });
    return androidInfo;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 16.0,
                  // bottom: 8.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/android.png',
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppInfoView(
                          title: 'Android Version',
                          info: androidInfo.version.release,
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        AppInfoView(
                          title: 'API Level',
                          info: androidInfo.version.sdkInt.toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    // bottom: 16.0,
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        AppInfoView(
                          title: 'Security Patch',
                          info: androidInfo.version.securityPatch.toString(),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: VerticalDivider(),
                        ),
                        AppInfoView(
                          title: 'Brand',
                          info: androidInfo.brand.toUpperCase(),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: VerticalDivider(),
                        ),
                        AppInfoView(
                          title: 'Manufacturer',
                          info: androidInfo.manufacturer.toUpperCase(),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: VerticalDivider(),
                        ),
                        AppInfoView(
                          title: 'Model',
                          info: androidInfo.model.toUpperCase(),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: VerticalDivider(),
                        ),
                        AppInfoView(
                          title: 'Product',
                          info: androidInfo.product.toUpperCase(),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: VerticalDivider(),
                        ),
                        AppInfoView(
                          title: 'Android ID',
                          info: androidInfo.androidId.toUpperCase(),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: VerticalDivider(),
                        ),
                        AppInfoView(
                          title: 'Board',
                          info: androidInfo.board.toUpperCase(),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: VerticalDivider(),
                        ),
                        AppInfoView(
                          title: 'Bootloader',
                          info: androidInfo.bootloader.toUpperCase(),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: VerticalDivider(),
                        ),
                        AppInfoView(
                          title: 'Display',
                          info: androidInfo.display.toUpperCase(),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: VerticalDivider(),
                        ),
                        AppInfoView(
                          title: 'Hardware',
                          info: androidInfo.hardware.toUpperCase(),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: VerticalDivider(),
                        ),
                        AppInfoView(
                          title: 'Host',
                          info: androidInfo.host.toUpperCase(),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: VerticalDivider(),
                        ),
                        AppInfoView(
                          title: 'ID',
                          info: androidInfo.id.toUpperCase(),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: VerticalDivider(),
                        ),
                        AppInfoView(
                          title: 'Physical Device',
                          info: androidInfo.isPhysicalDevice
                              .toString()
                              .toUpperCase(),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: VerticalDivider(),
                        ),
                        AppInfoView(
                          title: 'Supported 32 Bit Abis',
                          info: androidInfo.supported32BitAbis.toString(),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: VerticalDivider(),
                        ),
                        AppInfoView(
                          title: 'Supported 64 Bit Abis',
                          info: androidInfo.supported64BitAbis
                              .toString()
                              .toUpperCase(),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: VerticalDivider(),
                        ),
                        AppInfoView(
                          title: 'Supported Abis',
                          info: androidInfo.supportedAbis
                              .toString()
                              .toUpperCase(),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: VerticalDivider(),
                        ),
                        AppInfoView(
                          title: 'Tags',
                          info: androidInfo.tags.toUpperCase(),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5.0),
                          child: VerticalDivider(),
                        ),
                        AppInfoView(
                          title: 'Type',
                          info: androidInfo.type.toUpperCase(),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
  }
}
