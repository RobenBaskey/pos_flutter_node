import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/app_keys.dart';

class SharedPreferenceService {
  static SharedPreferenceService? _instance;
  static SharedPreferencesWithCache? _preferences;

  SharedPreferenceService._internal();

  @visibleForTesting
  SharedPreferenceService.test(SharedPreferencesWithCache prefs) {
    _preferences = prefs;
  }

  static Future<SharedPreferenceService> getInstance() async {
    _instance ??= SharedPreferenceService._internal();
    _preferences = await SharedPreferencesWithCache.create(
      cacheOptions: SharedPreferencesWithCacheOptions(allowList: AppKeys.keys),
    );
    return _instance!;
  }

  // Setters
  Future<void> setString(String key, String value) async {
    return await _preferences!.setString(key, value);
  }

  Future setBool(String key, bool value) async {
    return await _preferences!.setBool(key, value);
  }

  Future setInt(String key, int value) async {
    return await _preferences!.setInt(key, value);
  }

  Future setDouble(String key, double value) async {
    return await _preferences!.setDouble(key, value);
  }

  Future setStringList(String key, List<String> value) async {
    return await _preferences!.setStringList(key, value);
  }

  // Getters
  String? getString(String key) => _preferences!.getString(key);
  bool? getBool(String key) => _preferences!.getBool(key);
  int? getInt(String key) => _preferences!.getInt(key);
  double? getDouble(String key) => _preferences!.getDouble(key);
  List<String>? getStringList(String key) => _preferences!.getStringList(key);

  // Remove a specific key
  Future remove(String key) async {
    return await _preferences!.remove(key);
  }

  // Clear all preferences
  Future clear() async {
    if (_preferences != null) {
      var phone = _preferences!.getString(AppKeys.phoneKey);
      var rememberPhone = _preferences!.getString(AppKeys.rememberPhoneKey);
      var rememberPassword = _preferences!.getString(
        AppKeys.rememberPasswordKey,
      );

      await _preferences!.clear();
      _preferences!.setString(AppKeys.phoneKey, phone ?? "");
      if (rememberPhone != null && rememberPassword != null) {
        _preferences!.setString(AppKeys.rememberPhoneKey, rememberPhone);
        _preferences!.setString(AppKeys.rememberPasswordKey, rememberPassword);
      }
    }
  }

  // Check if key exists
  bool containsKey(String key) {
    return _preferences!.containsKey(key);
  }

  String getToken() {
    return _preferences!.getString(AppKeys.tokenKey) ?? "";
  }
}
