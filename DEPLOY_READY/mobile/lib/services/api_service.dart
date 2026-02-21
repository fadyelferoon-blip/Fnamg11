import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constants.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  final String baseUrl = AppConstants.baseUrl;

  // Register or login user
  Future<Map<String, dynamic>> registerUser(String uid, String deviceId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'uid': uid,
          'deviceId': deviceId,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'data': jsonDecode(response.body),
        };
      } else if (response.statusCode == 403) {
        // Blocked
        final data = jsonDecode(response.body);
        return {
          'success': false,
          'error': 'BLOCKED',
          'message': data['message'] ?? 'Account blocked',
        };
      } else {
        final data = jsonDecode(response.body);
        return {
          'success': false,
          'error': data['error'] ?? 'Registration failed',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Network error: $e',
      };
    }
  }

  // Check user status
  Future<Map<String, dynamic>> checkStatus(String uid, String deviceId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/users/status?uid=$uid&deviceId=$deviceId'),
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': jsonDecode(response.body),
        };
      } else {
        final data = jsonDecode(response.body);
        return {
          'success': false,
          'error': data['error'] ?? 'Failed to check status',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Network error: $e',
      };
    }
  }

  // Generate signal
  Future<Map<String, dynamic>> generateSignal(String uid, String deviceId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users/signal'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'uid': uid,
          'deviceId': deviceId,
        }),
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': jsonDecode(response.body),
        };
      } else if (response.statusCode == 400) {
        final data = jsonDecode(response.body);
        return {
          'success': false,
          'error': data['error'],
          'waitSeconds': data['waitSeconds'],
        };
      } else {
        final data = jsonDecode(response.body);
        return {
          'success': false,
          'error': data['error'] ?? 'Failed to generate signal',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Network error: $e',
      };
    }
  }

  // Health check
  Future<bool> checkConnection() async {
    try {
      final response = await http.get(
        Uri.parse('${AppConstants.baseUrl.replaceAll('/api', '')}/health'),
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
