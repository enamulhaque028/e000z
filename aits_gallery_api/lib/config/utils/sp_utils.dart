import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  /* :::::::::::::::::::::::::::::::: API RESPONSE ::::::::::::::::::::::::::::::::::*/
  Future<bool> setApiResponse(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('API_RESP', value);
  }
  
  Future<String?> getApiResponse() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('API_RESP');
  }
}