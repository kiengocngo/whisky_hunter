import 'package:shared_preferences/shared_preferences.dart';
import 'package:whisky_hunter/src/constant/constant.dart';

class AppManager {
  static String firstOpenApp = 'FirstOpenApp';
  final String _languageKey = "LangugeKey";

  Future<String> getLanguageKey() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_languageKey) ?? TMLanguage.vi.toString();
  }

  Future<bool> saveLanguageKey({required String language}) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(_languageKey, language);
  }
}
