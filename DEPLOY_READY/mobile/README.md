# FER3OON Mobile App

## Setup Instructions

### Prerequisites
- Flutter SDK (latest stable version)
- Android Studio or VS Code
- Android SDK
- Java JDK 11 or higher

### 1. Install Flutter
Follow the official Flutter installation guide:
https://docs.flutter.dev/get-started/install

### 2. Configure API URL
Edit `lib/core/constants.dart` and update:
```dart
static const String baseUrl = 'https://your-backend-url.up.railway.app/api';
```

### 3. Install Dependencies
```bash
flutter pub get
```

### 4. Run on Device/Emulator
```bash
# Check connected devices
flutter devices

# Run debug version
flutter run

# Run release version
flutter run --release
```

### 5. Build APK

#### Build Release APK
```bash
flutter build apk --release
```

The APK will be located at:
`build/app/outputs/flutter-apk/app-release.apk`

#### Build Split APKs (smaller size)
```bash
flutter build apk --split-per-abi --release
```

This creates separate APKs for different architectures:
- `app-armeabi-v7a-release.apk` (32-bit ARM)
- `app-arm64-v8a-release.apk` (64-bit ARM - recommended)
- `app-x86_64-release.apk` (64-bit Intel)

### 6. Build App Bundle (for Play Store)
```bash
flutter build appbundle --release
```

The AAB will be located at:
`build/app/outputs/bundle/release/app-release.aab`

## PowerShell Build Commands

If using PowerShell on Windows:

```powershell
# Check Flutter
flutter doctor

# Get dependencies
flutter pub get

# Build APK
flutter build apk --release

# Build for specific architecture
flutter build apk --target-platform android-arm64 --release
```

## App Structure

```
lib/
├── main.dart                 # Entry point
├── core/
│   ├── constants.dart        # Configuration
│   ├── theme.dart           # App theme
│   └── animation.dart       # Animations
├── services/
│   ├── api_service.dart     # Backend API
│   ├── auth_server.dart     # Authentication
│   └── storage_server.dart  # Local storage
├── screens/
│   ├── splash_screen.dart
│   ├── welcome_screen.dart
│   ├── uid_input_screen.dart
│   ├── pending_screen.dart
│   └── trading_screen.dart
└── widgets/
    ├── signal_button.dart
    ├── support_button.dart
    └── animated_background.dart
```

## Configuration Checklist

Before building:
- [ ] Update backend URL in `constants.dart`
- [ ] Test on physical device
- [ ] Verify WebView loads correctly
- [ ] Test signal generation
- [ ] Test support button
- [ ] Check permissions

## Testing

```bash
# Run tests
flutter test

# Run integration tests
flutter drive --target=test_driver/app.dart
```

## Troubleshooting

### WebView not loading
- Ensure `usesCleartextTraffic="true"` in AndroidManifest.xml
- Check internet permission
- Verify backend URL is accessible

### Build errors
```bash
# Clean build
flutter clean

# Get dependencies again
flutter pub get

# Rebuild
flutter build apk --release
```

### Gradle errors
- Update Android Studio
- Update Gradle in `android/gradle/wrapper/gradle-wrapper.properties`
- Sync project with Gradle files

## Features

✅ Splash screen with animation
✅ Welcome screen with registration
✅ UID input and device registration
✅ Pending approval screen
✅ Trading screen with WebView
✅ Signal generation system
✅ Support button
✅ Auto-block on multiple devices
✅ Session persistence
✅ Professional dark theme

## Requirements Met

✅ Black & Gold premium design
✅ Smooth animations
✅ WebView for Quotex (90% screen)
✅ Fixed bottom buttons
✅ Hour-based signal distribution
✅ 60-second signal duration
✅ Device ID tracking
✅ Backend API integration
✅ Support link
✅ No re-login required
