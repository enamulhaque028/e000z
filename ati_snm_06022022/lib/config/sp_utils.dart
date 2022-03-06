import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  /* :::::::::::::::::::::::::::::::: from login response ::::::::::::::::::::::::::::::::::*/
  Future<bool> setCompanyId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('companyId', value);
  }

  Future<String> geCompanyId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('companyId');
  }

  Future<bool> setCBranchId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('cbranchId', value);
  }

  Future<String> getCBranchId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('cbranchId');
  }

  Future<bool> setCobUnitId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('cobUnitId', value);
  }

  Future<String> getCobUnitId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('cobUnitId');
  }

  Future<bool> setPtgUnitId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('ptgUnitId', value);
  }

  Future<String> getPtgUnitId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('ptgUnitId');
  }
}
