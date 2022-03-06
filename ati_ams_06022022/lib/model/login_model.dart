class LoginRequestModel {
  String email;
  String password;
  int appVersionCode;
  String deviceModel;
  String osVersion;

  LoginRequestModel({
    this.email,
    this.password,
    this.appVersionCode,
    this.deviceModel,
    this.osVersion,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "email": email.trim(),
      "password": password.trim(),
      "app_id": "1",
      "pkg_name": "net.ati.ams",
      "mobile_manufacture": deviceModel.toString() ?? '',
      "os_version": osVersion.toString() ?? '',
      "os_type": "android",
      "app_version": appVersionCode.toString() ?? '',
      "fcm_reg_id": "1"
    };

    return map;
  }
}
