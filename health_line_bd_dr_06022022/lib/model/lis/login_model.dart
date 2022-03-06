//login request model[ati_lis]
class LoginRequestModelLIS {
  String email;
  String password;
  int appVersionCode;
  String deviceModel;
  String osVersion;
  String fcmToken;

  LoginRequestModelLIS({
    this.email,
    this.password,
    this.appVersionCode,
    this.deviceModel,
    this.osVersion,
    this.fcmToken,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "P_MOBIAPS_ID": "31",
      "P_USRLOGINID": email.trim(),
      "P_UPASSWORDS": password.trim(),
      "P_MA_VERSION": appVersionCode.toString() ?? '',
      "P_MDEV_MODEL": deviceModel ?? '',
      "P_OS_VERSION": osVersion ?? '',
      "P_FCM_REG_ID": fcmToken ?? '',
    };

    return map;
  }
}

//login request model[healthline bd]
class LoginRequestModel {
  int androidApiLvl;
  String androidVersion;
  String fcmToken;
  String manufacture;
  String mobileNo;
  String phoneModel;
  String userPass;

  LoginRequestModel({
    this.androidApiLvl,
    this.androidVersion,
    this.fcmToken,
    this.manufacture,
    this.mobileNo,
    this.phoneModel,
    this.userPass,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "androidApiLvl": androidApiLvl ?? "",
      "androidVersion": androidVersion ?? "",
      "fcmToken": fcmToken ?? "",
      "manufacture": manufacture ?? "",
      "mobileNo": mobileNo ?? "",
      "phoneModel": phoneModel ?? "",
      "userAppVersion": 22,
      "userPass": userPass ?? "",
      "userType": "D"
    };

    return map;
  }
}
