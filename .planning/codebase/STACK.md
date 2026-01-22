# Technology Stack

**Analysis Date:** 2026-01-22

## Languages

**Primary:**
- Dart 3.x (SDK >=3.0.0 <4.0.0) - All application code (`pubspec.yaml`)

**Secondary:**
- Swift - iOS platform code (`ios/Runner/AppDelegate.swift`, `ios/ImageNotification/NotificationService.swift`)
- Java - Android platform code (`android/app/src/main/java/io/flutter/plugins/GeneratedPluginRegistrant.java`)
- Python - iOS build helper (`ios/Flutter/ephemeral/flutter_lldb_helper.py`)

## Runtime

**Environment:**
- Flutter SDK (stable channel)
- Dart VM 3.x for development
- iOS/Android native runtimes for production

**Package Manager:**
- pub (Dart package manager)
- Lockfile: `pubspec.lock` present

## Frameworks

**Core:**
- Flutter - Cross-platform UI framework (`pubspec.yaml`)
- FlutterFlow - Low-code Flutter development (generates widget/model pairs)

**Navigation:**
- go_router 12.1.3 - Declarative routing (`lib/flutter_flow/nav/nav.dart`)

**State Management:**
- provider 6.1.5 - App state management (`lib/app_state.dart`)

**Testing:**
- flutter_test SDK - Widget testing (`test/widget_test.dart`)

**Build/Dev:**
- flutter_lints 4.0.0 - Static analysis
- lints 4.0.0 - Additional lint rules

## Key Dependencies

**Critical (ML/Embeddings):**
- flutter_gemma - On-device Gemma model for embeddings (`lib/custom_code/actions/initialize_gemma.dart`)

**Database:**
- sqflite 2.3.3+1 - SQLite database (`lib/backend/sqlite/sqlite_manager.dart`)
- sqflite_common_ffi ^2.3.5 - FFI bindings for desktop/non-mobile
- sqlite3 ^2.9.4 - SQLite bindings

**Storage:**
- shared_preferences 2.5.3 - Persisted app state (`lib/app_state.dart`)
- path_provider 2.1.4 - File system paths

**UI:**
- google_fonts 6.3.3 - Typography
- flutter_animate 4.5.0 - Animations
- font_awesome_flutter 10.7.0 - Icons
- lottie 3.1.2 - Lottie animations
- cached_network_image 3.4.1 - Image caching

## Configuration

**Environment:**
- No .env files detected
- Configuration via SharedPreferences (runtime)
- Asset bundles in `assets/` directory

**Build:**
- `pubspec.yaml` - Dependencies and asset configuration
- `analysis_options.yaml` - Dart analyzer settings (excludes `lib/custom_code/**`)

## Platform Requirements

**Development:**
- macOS/Linux/Windows with Flutter SDK
- Xcode for iOS development
- Android Studio for Android development

**Production:**
- iOS: Native iOS app
- Android: Native Android app
- Web: Supported but SQLite disabled (`lib/backend/sqlite/sqlite_manager.dart` line 19-21)

---

*Stack analysis: 2026-01-22*
*Update after major dependency changes*
