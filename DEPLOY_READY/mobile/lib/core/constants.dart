class AppConstants {
  // API Configuration
  static const String baseUrl = 'https://11112222333333445445566767777-production-698f.up.railway.app';

  // API Endpoints
  static const String registerEndpoint = '/api/users/register';
  static const String checkStatusEndpoint = '/api/users/status';
  static const String getSignalEndpoint = '/api/users/signal';

  // External URLs
  static const String registrationUrl = 'https://broker-qx.pro/?lid=1635606';
  static const String quotexWebUrl = 'https://qxbroker.com/en/';
  static const String supportTelegram = 'http://t.me/el_fer3oon';
  static const String tradingUrl = 'https://qxbroker.com/en/';
  static const String supportUrl = 'http://t.me/el_fer3oon';

  // Colors
  static const int primaryBlack = 0xFF000000;
  static const int darkGray = 0xFF1A1A1A;
  static const int mediumGray = 0xFF2D2D2D;
  static const int gold = 0xFFFFD700;
  static const int goldAccent = 0xFFFFA500;

  // Local Storage Keys
  static const String keyUID = 'user_uid';
  static const String keyDeviceID = 'device_id';
  static const String keyDeviceId = 'device_id';
  static const String keyUserStatus = 'user_status';
  static const String keyIsLoggedIn = 'is_logged_in';

  // App Settings
  static const int splashDuration = 3;
  static const int signalDuration = 60;
  static const int signalStartWindow = 5;

  // App Info
  static const String appName = 'FER3OON';
  static const String appVersion = '1.0.0';

  // User Status
  static const String statusPending = 'PENDING';
  static const String statusApproved = 'APPROVED';
  static const String statusBlocked = 'BLOCKED';

  // URL Validation
  static bool isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && uri.host.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
