import 'package:challenge_fd/core/config/preferences/preferences.dart';
import 'package:flutter/material.dart';

class Config {
  static void init() async {
    WidgetsFlutterBinding.ensureInitialized();

    final prefs = Preferences();
    await prefs.init();
  }
}
