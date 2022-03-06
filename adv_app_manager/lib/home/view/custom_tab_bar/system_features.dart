import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemFeatures extends StatefulWidget {
  const SystemFeatures({
    Key? key,
  }) : super(key: key);

  @override
  State<SystemFeatures> createState() => _SystemFeaturesState();
}

class _SystemFeaturesState extends State<SystemFeatures> {
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
        : ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            itemCount: androidInfo.systemFeatures.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: InkWell(
                  onTap: () {
                    Clipboard.setData(
                      ClipboardData(text: androidInfo.systemFeatures[index]),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('copied to clipboard'),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        color: index % 2 == 0
                            ? const Color(0xFFF0F4F8)
                            : Colors.transparent,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Image.asset(
                                'assets/images/arrow.png',
                                height: 24,
                                width: 24,
                              ),
                            ),
                            Text(
                              androidInfo.systemFeatures[index],
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }
}
