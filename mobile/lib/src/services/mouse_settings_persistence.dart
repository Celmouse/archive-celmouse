import 'dart:convert';

import 'package:controller/src/configs/mouse_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MouseSettingsPersistence {
  static const String _key = 'current_mouse_settings';

  Future<void> saveSettings(MouseSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, jsonEncode(settings.toJson()));
  }

  Future<MouseSettings> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_key);
    if (json == null) return MouseSettings();
    return MouseSettings.fromJson(jsonDecode(json));
  }
}
