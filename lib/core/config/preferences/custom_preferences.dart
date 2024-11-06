import 'package:shared_preferences/shared_preferences.dart';

class CustomPreferences {
  static final CustomPreferences _singleton = CustomPreferences._();

  factory CustomPreferences() => _singleton;

  CustomPreferences._();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> _setBool(String key, bool value) async {
    await _prefs?.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs?.getBool(key);
  }

  Future<void> clear() async {
    await _prefs?.clear();
  }

  Future<void> setValue(
    String key,
    dynamic value,
  ) async {
    if (value is bool) {
      await _setBool(key, value);
    } else {
      throw Exception('Invalid value type');
    }
  }
}
