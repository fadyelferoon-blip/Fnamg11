# FER3OON Mobile App - Build Guide

## 📱 Update Backend URL

### Step 1: Edit Constants
Open `lib/core/constants.dart` and update:
```dart
static const String baseUrl = 'https://YOUR-BACKEND-URL.up.railway.app';
```
**Replace with your actual backend URL!**

## 🔨 Build APK

### Prerequisites
- Flutter SDK installed
- Android Studio or VS Code
- Android SDK

### Build Commands
```bash
# Install dependencies
flutter pub get

# Clean project
flutter clean

# Build release APK
flutter build apk --release
```

### APK Location
After successful build:
```
build/app/outputs/flutter-apk/app-release.apk
```

### Build for specific architecture (smaller size)
```bash
flutter build apk --target-platform android-arm64 --release
```

## 📲 Install on Device
1. Enable "Unknown Sources" on Android device
2. Transfer APK to device
3. Install APK

## ✅ App Features
- ✅ Splash screen
- ✅ Registration flow
- ✅ UID input
- ✅ Pending approval screen
- ✅ Trading WebView (Quotex)
- ✅ Signal generation
- ✅ Support button (Telegram)
- ✅ Auto-block on multiple devices
- ✅ Session persistence

## 🎨 App Design
- Primary: Black & Dark Gray
- Accent: Gold (#FFD700)
- Professional premium theme
- Smooth animations

## 🔧 Troubleshooting

### WebView not loading
- Check internet permission in AndroidManifest.xml
- Verify backend URL is correct

### Build errors
```bash
flutter clean
flutter pub get
flutter build apk --release
```

### API connection errors
- Verify backend is running
- Check backend URL in constants.dart
- Test backend health: `https://your-backend/health`
