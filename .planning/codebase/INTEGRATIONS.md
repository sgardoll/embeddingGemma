# External Integrations

**Analysis Date:** 2026-01-22

## APIs & External Services

**ML Model:**
- flutter_gemma - On-device Gemma model for embeddings
  - SDK/Client: flutter_gemma package (`pubspec.yaml`)
  - Auth: None (on-device, no API keys)
  - Model download: Via `FlutterGemma.installEmbedder()` (`lib/custom_code/actions/download_embedding_model.dart`)
  - Initialization: `FlutterGemma.initialize()` in `lib/main.dart`

**No Cloud Services:**
- This app is designed for fully on-device operation
- No external API calls
- No authentication services
- No analytics or monitoring

## Data Storage

**Databases:**
- SQLite via sqflite - Local vector and document storage
  - Connection: `SQLiteManager.instance.database` (`lib/backend/sqlite/sqlite_manager.dart`)
  - Client: sqflite 2.3.3+1 + sqflite_common_ffi for desktop
  - Initialization: `initializeDatabaseFromDbFile()` in `lib/backend/sqlite/init.dart`
  - Pre-bundled DB: `assets/sqlite_db_files/embeddings.db`

**Caching:**
- SharedPreferences - App state persistence
  - Client: shared_preferences 2.5.3 (`lib/app_state.dart`)
  - Persisted keys: `ff_isModelReady`, `ff_documentsToIndex`, `ff_allVectors`

**File Storage:**
- path_provider - Access to app directories
  - Used for: Model file storage, database file location
  - No cloud storage integration

## Authentication & Identity

**Auth Provider:**
- None - App does not require authentication
- No user accounts
- No OAuth integrations

## Monitoring & Observability

**Error Tracking:**
- None - Errors logged to console only via print()

**Analytics:**
- None

**Logs:**
- Console output only (print statements)
- No structured logging service

## CI/CD & Deployment

**Hosting:**
- Not configured (source code repository only)

**CI Pipeline:**
- Not configured
- Manual builds via Flutter CLI

**Build Commands:**
```bash
flutter build ios        # iOS release
flutter build apk        # Android APK
flutter build appbundle  # Android App Bundle
```

## Environment Configuration

**Development:**
- No .env files required
- No secrets management
- Configuration via pubspec.yaml only

**Staging:**
- Not applicable (no external services)

**Production:**
- Same as development
- All processing on-device

## Platform-Specific Integrations

**iOS:**
- NotificationService extension (`ios/ImageNotification/`) - For rich notifications
- Standard Flutter iOS runner

**Android:**
- Standard Flutter Android runner
- GeneratedPluginRegistrant for plugin loading

**Web:**
- Supported but limited
- SQLite disabled on web (`lib/backend/sqlite/sqlite_manager.dart` lines 19-21)

## Webhooks & Callbacks

**Incoming:**
- None

**Outgoing:**
- None

## Package Dependencies (Third-Party)

**UI/UX:**
- google_fonts 6.3.3 - Font loading from Google Fonts
- cached_network_image 3.4.1 - Network image caching
- flutter_animate 4.5.0 - Animation utilities
- lottie 3.1.2 - Lottie animation support
- url_launcher 6.3.1 - External URL handling

**Utilities:**
- intl 0.20.2 - Internationalization
- timeago 3.7.1 - Relative time formatting
- json_path 0.7.2 - JSON navigation

---

*Integration audit: 2026-01-22*
*Update when adding/removing external services*
