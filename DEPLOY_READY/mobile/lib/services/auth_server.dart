import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
import 'storage_server.dart';
import 'api_service.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final StorageService _storage = StorageService();
  final ApiService _api = ApiService();

  // Get device ID
  Future<String> getDeviceId() async {
    // Check if already saved
    String? savedDeviceId = _storage.getDeviceId();
    if (savedDeviceId != null) {
      return savedDeviceId;
    }

    // Generate new device ID
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String deviceId = '';

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.id; // Unique Android ID
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor ?? '';
      }
    } catch (e) {
      // Fallback to timestamp-based ID
      deviceId = 'device_${DateTime.now().millisecondsSinceEpoch}';
    }

    // Save device ID
    await _storage.saveDeviceId(deviceId);
    return deviceId;
  }

  // Register user
  Future<Map<String, dynamic>> register(String uid) async {
    try {
      String deviceId = await getDeviceId();
      
      final result = await _api.registerUser(uid, deviceId);
      
      if (result['success']) {
        await _storage.saveUID(uid);
        await _storage.saveDeviceId(deviceId);
        
        final userData = result['data']['user'];
        await _storage.saveUserStatus(userData['status']);
        
        if (userData['status'] == 'APPROVED') {
          await _storage.setLoggedIn(true);
        }
        
        return result;
      }
      
      return result;
    } catch (e) {
      return {
        'success': false,
        'error': 'Registration error: $e',
      };
    }
  }

  // Check status
  Future<Map<String, dynamic>> checkUserStatus() async {
    try {
      String? uid = _storage.getUID();
      String? deviceId = _storage.getDeviceId();
      
      if (uid == null || deviceId == null) {
        return {
          'success': false,
          'error': 'No user data found',
        };
      }
      
      final result = await _api.checkStatus(uid, deviceId);
      
      if (result['success']) {
        String status = result['data']['status'];
        await _storage.saveUserStatus(status);
        
        if (status == 'APPROVED') {
          await _storage.setLoggedIn(true);
        } else {
          await _storage.setLoggedIn(false);
        }
      }
      
      return result;
    } catch (e) {
      return {
        'success': false,
        'error': 'Status check error: $e',
      };
    }
  }

  // Logout
  Future<void> logout() async {
    await _storage.clearAll();
  }

  // Get current status
  String? getCurrentStatus() {
    return _storage.getUserStatus();
  }

  // Check if logged in
  bool isLoggedIn() {
    return _storage.isLoggedIn();
  }

  // Has user data
  bool hasUserData() {
    return _storage.hasUserData();
  }
}
