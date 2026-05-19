# SAA 2025 — Branding & identifiers

| Item | Value |
|------|--------|
| Product name | **SAA 2025** |
| Dart package | `saa2025` (`import 'package:saa2025/...'`) |
| Android applicationId | `com.sunasterisk.saa2025` |
| iOS bundle ID | `com.sunasterisk.saa2025` |
| Display name (iOS/Android) | SAA 2025 |

## Firebase / Google

Sau khi đổi bundle ID, cần:

1. Thêm app Android/iOS mới trên Firebase Console với `com.sunasterisk.saa2025`
2. Tải lại `google-services.json` và `GoogleService-Info.plist`
3. Chạy `flutterfire configure` hoặc cập nhật `lib/firebase_options.dart`

## Chạy app

```bash
cd app/app
flutter pub get
flutter run
```

Melos: `melos bootstrap` — scope package `saa2025`.
