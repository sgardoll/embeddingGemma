# Codebase Structure

**Analysis Date:** 2026-01-22

## Directory Layout

```
embedding-gemma/
├── lib/                     # Dart source code
│   ├── main.dart           # App entry point
│   ├── app_state.dart      # Global state
│   ├── index.dart          # Barrel exports
│   ├── library_values.dart # Library constants
│   ├── demo/               # FlutterFlow demo screens
│   │   ├── empty/          # Empty placeholder screen
│   │   ├── start_download/ # Model download screen
│   │   ├── generate_embeddings/ # Embedding generation screen
│   │   ├── demo_document/  # Document demo screen
│   │   └── search/         # Search screen
│   ├── flutter_flow/       # FlutterFlow utilities
│   │   ├── nav/            # Navigation/routing
│   │   └── *.dart          # Theme, utils, widgets
│   ├── custom_code/        # Custom business logic
│   │   ├── actions/        # Action functions
│   │   └── widgets/        # Custom widgets
│   └── backend/            # Data layer
│       ├── sqlite/         # Database management
│       └── schema/         # Data structures
├── assets/                 # Static assets
│   ├── fonts/              # Custom fonts
│   ├── images/             # Images
│   ├── jsons/              # JSON files
│   └── sqlite_db_files/    # Pre-bundled DB files
├── test/                   # Test files
├── android/                # Android platform code
├── ios/                    # iOS platform code
├── web/                    # Web platform code
├── pubspec.yaml            # Dependencies
└── analysis_options.yaml   # Analyzer config
```

## Directory Purposes

**lib/demo/:**
- Purpose: FlutterFlow-generated screen pages
- Contains: Widget/Model pairs per screen
- Key files: `start_download/start_download_widget.dart`, `generate_embeddings/generate_embeddings_widget.dart`, `search/search_widget.dart`
- Subdirectories: One per screen, each with `*_widget.dart` and `*_model.dart`

**lib/flutter_flow/:**
- Purpose: FlutterFlow framework utilities
- Contains: Theme, utilities, navigation, common widgets
- Key files: `flutter_flow_theme.dart`, `flutter_flow_util.dart`, `nav/nav.dart`
- Subdirectories: `nav/` for routing

**lib/custom_code/actions/:**
- Purpose: Custom action functions for ML pipeline
- Contains: Exported action functions
- Key files: `initialize_gemma.dart`, `process_documents_to_vectors.dart`, `save_vectors_to_db.dart`, `find_top_matches.dart`, `download_embedding_model.dart`
- Subdirectories: None

**lib/custom_code/widgets/:**
- Purpose: Custom Flutter widgets
- Contains: Reusable custom widgets
- Key files: `generate_embeddings.dart`
- Subdirectories: None

**lib/backend/sqlite/:**
- Purpose: SQLite database management
- Contains: Manager, init, queries
- Key files: `sqlite_manager.dart`, `init.dart`, `queries/read.dart`, `queries/update.dart`
- Subdirectories: `queries/`

**lib/backend/schema/structs/:**
- Purpose: Data structure definitions
- Contains: FlutterFlow struct classes
- Key files: `vector_document_struct.dart`, `embedding_config_struct.dart`
- Subdirectories: None

## Key File Locations

**Entry Points:**
- `lib/main.dart` - App bootstrap, initialization sequence

**Configuration:**
- `pubspec.yaml` - Dependencies, assets, SDK version
- `analysis_options.yaml` - Dart analyzer configuration (excludes custom_code)

**Core Logic:**
- `lib/custom_code/gemma_embedder_wrapper.dart` - Gemma model wrapper singleton
- `lib/custom_code/gemma_rag_manager.dart` - RAG pipeline manager
- `lib/custom_code/actions/process_documents_to_vectors.dart` - Embedding generation
- `lib/custom_code/actions/find_top_matches.dart` - Similarity search

**State:**
- `lib/app_state.dart` - FFAppState with persistence

**Testing:**
- `test/widget_test.dart` - Basic widget smoke test

## Naming Conventions

**Files:**
- snake_case.dart for all Dart files
- *_widget.dart for screen widgets
- *_model.dart for FlutterFlow screen models
- *_struct.dart for data structures

**Directories:**
- snake_case for all directories
- Singular names (demo, not demos)
- Screen directories match screen name

**Special Patterns:**
- index.dart for barrel exports in each module
- FlutterFlow header comments: `// Automatic FlutterFlow imports` + `// DO NOT REMOVE OR MODIFY THE CODE ABOVE!`

## Where to Add New Code

**New Screen:**
- Primary code: `lib/demo/{screen_name}/{screen_name}_widget.dart`
- Model: `lib/demo/{screen_name}/{screen_name}_model.dart`
- Route: Add to `lib/flutter_flow/nav/nav.dart`

**New Custom Action:**
- Implementation: `lib/custom_code/actions/{action_name}.dart`
- Export: Add to `lib/custom_code/actions/index.dart`

**New Custom Widget:**
- Implementation: `lib/custom_code/widgets/{widget_name}.dart`
- Export: Add to `lib/custom_code/widgets/index.dart`

**New Data Structure:**
- Implementation: `lib/backend/schema/structs/{struct_name}_struct.dart`
- Export: Add to `lib/backend/schema/structs/index.dart`

**Database Queries:**
- Read queries: `lib/backend/sqlite/queries/read.dart`
- Update queries: `lib/backend/sqlite/queries/update.dart`

## Special Directories

**lib/custom_code/:**
- Purpose: Custom code that FlutterFlow preserves on regeneration
- Source: Hand-written by developers
- Note: Excluded from dart analyzer in `analysis_options.yaml`

**assets/sqlite_db_files/:**
- Purpose: Pre-bundled SQLite database files
- Source: Development/seed data
- Committed: Yes

**.serena/:**
- Purpose: Serena AI assistant cache and memories
- Source: Auto-generated
- Committed: May be gitignored

---

*Structure analysis: 2026-01-22*
*Update when directory structure changes*
