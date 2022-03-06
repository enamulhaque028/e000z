// class LoginResponseModel {
//   final String token;
//   final String error;

//   LoginResponseModel({this.token, this.error});

//   factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
//     return LoginResponseModel(
//       token: json["token"] != null ? json["token"] : "",
//       error: json["error"] != null ? json["error"] : "",
//     );
//   }
// }

class LoginRequestModel {
  String email;
  String password;
  String fcmRegId;

  LoginRequestModel({
    this.email,
    this.password,
    this.fcmRegId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email': email.trim(),
      'password': password.trim(),
      'fcm_reg_id': fcmRegId.toString(),
      'ATIAPPL_ID': '5',
    };

    return map;
  }
}
