library mobile_client_preferences;

import 'package:challenge_fd/core/config/preferences/custom_preferences.dart';

class Preferences {
  static final Preferences _singleton = Preferences._();

  factory Preferences() => _singleton;

  Preferences._();

  CustomPreferences? _prefs;

  Future<void> init() async {
    _prefs = CustomPreferences();

    await _prefs?.init();
  }

  final String _isAuthenticated = 'isAuthenticated';
  bool get isAuthenticated => _prefs?.getBool(_isAuthenticated) ?? false;
  set isAuthenticated(bool value) => _prefs?.setValue(_isAuthenticated, value);

  Future<void> clear() async {
    await _prefs?.clear();
  }
}
