import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // UID
  Future<void> saveUID(String uid) async {
    await _prefs?.setString(AppConstants.keyUID, uid);
  }

  String? getUID() {
    return _prefs?.getString(AppConstants.keyUID);
  }

  // Device ID
  Future<void> saveDeviceId(String deviceId) async {
    await _prefs?.setString(AppConstants.keyDeviceId, deviceId);
  }

  String? getDeviceId() {
    return _prefs?.getString(AppConstants.keyDeviceId);
  }

  // User Status
  Future<void> saveUserStatus(String status) async {
    await _prefs?.setString(AppConstants.keyUserStatus, status);
  }

  String? getUserStatus() {
    return _prefs?.getString(AppConstants.keyUserStatus);
  }

  // Login Status
  Future<void> setLoggedIn(bool value) async {
    await _prefs?.setBool(AppConstants.keyIsLoggedIn, value);
  }

  bool isLoggedIn() {
    return _prefs?.getBool(AppConstants.keyIsLoggedIn) ?? false;
  }

  // Clear all data
  Future<void> clearAll() async {
    await _prefs?.clear();
  }

  // Check if user data exists
  bool hasUserData() {
    return getUID() != null && getDeviceId() != null;
  }
}
