import 'package:shared_preferences/shared_preferences.dart';
class AppManager {
  final String _firstTimeOpenAppKey = 'firstTimeOpenAppKey';

  AppManager();

  Future<bool> isFirstTimeOpenApp() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getBool(_firstTimeOpenAppKey) ?? true;
    return data;
  }
}