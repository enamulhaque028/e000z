import 'dart:convert';
// import 'dart:developer';
import 'package:flutter/services.dart';

class NativeApiCall {
  //method name
  //getPermissionList,getActivityList,getProviderList,getReceiverList
  MethodChannel platform = const MethodChannel('com.aos.aam/appinfo');

  Future getNativeData(String packageName, String methodName) async {
    try {
      final dynamic result =
          await platform.invokeMethod(methodName, {"packageName": packageName});
      // log(result.toString());
      return jsonDecode(result.toString());
    } catch (e, stacktrace) {
      // ignore: avoid_print
      print(e);

      // ignore: avoid_print
      print(stacktrace);
    }
  }
}
