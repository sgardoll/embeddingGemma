# PROJECT KNOWLEDGE BASE

**Generated:** 2026-01-22 12:26 AEDT
**Commit:** e2bc5ab
**Branch:** master

## OVERVIEW
FlutterFlow-generated Flutter app for on-device Gemma embeddings with local SQLite storage and demo flows.

## STRUCTURE
```
embedding-gemma-75wa0w/
├── lib/                     # Dart source (FlutterFlow + custom actions/widgets)
├── assets/                  # fonts/images/jsons/sqlite_db_files
├── android/                 # Android wrapper
├── ios/                     # iOS wrapper + Pods
├── web/                     # Web target
├── test/                    # Widget tests
├── FLUTTERFLOW_*_GUIDE.md   # Usage/setup docs
├── pubspec.yaml             # deps + assets
└── analysis_options.yaml    # analyzer config
```

## WHERE TO LOOK
| Task | Location | Notes |
|------|----------|-------|
| App bootstrap | lib/main.dart | Calls sqfliteFfiInit + initializeGemma before app start |
| Routes | lib/flutter_flow/nav/nav.dart | GoRouter + FFRoute mapping |
| Custom actions | lib/custom_code/actions | Embedding pipeline actions |
| Custom widget | lib/custom_code/widgets/generate_embeddings.dart | Embeddings UI + save flow |
| SQLite manager | lib/backend/sqlite/sqlite_manager.dart | DB init + query hooks |
| Demo screens | lib/demo | StartDownload, GenerateEmbeddings, Search |
| Docs | FLUTTERFLOW_*_GUIDE.md | FlutterFlow setup + usage guides |

## CODE MAP
| Symbol | Type | Location | Refs | Role |
|--------|------|----------|------|------|
| main | function | lib/main.dart | n/a | app bootstrap + init |
| MyApp | class | lib/main.dart | n/a | MaterialApp.router |
| createRouter | function | lib/flutter_flow/nav/nav.dart | n/a | route definitions |
| SQLiteManager | class | lib/backend/sqlite/sqlite_manager.dart | n/a | sqlite init + exports |
| GenerateEmbeddings | class | lib/custom_code/widgets/generate_embeddings.dart | n/a | widget pipeline |

## CONVENTIONS
- FlutterFlow pages pair `*_widget.dart` with `*_model.dart` for state.
- Custom actions are exported via lib/custom_code/actions/index.dart.
- App state access commonly uses `FFAppState` + `context.watch<FFAppState>()`.

## ANTI-PATTERNS (THIS PROJECT)
- Do not remove or modify the FlutterFlow header blocks in custom code files.

## UNIQUE STYLES
- GoRouter routes are wrapped in FFRoute for transition and param handling.

## COMMANDS
```bash
flutter pub get
flutter run
flutter test
flutter analyze
```

## NOTES
- SQLiteManager.initialize is a no-op on web.
- Startup initializes sqflite FFI and Gemma in lib/main.dart.
