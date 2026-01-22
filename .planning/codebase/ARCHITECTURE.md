# Architecture

**Analysis Date:** 2026-01-22

## Pattern Overview

**Overall:** FlutterFlow-Generated Mobile App with Custom ML Pipeline

**Key Characteristics:**
- FlutterFlow low-code generation for UI scaffolding
- Custom code for ML/embedding pipeline
- On-device processing (no cloud dependencies)
- SQLite for local vector storage
- Provider-based state management

## Layers

**Presentation Layer (FlutterFlow):**
- Purpose: UI widgets and navigation
- Contains: Screen widgets, models, theme definitions
- Location: `lib/demo/*/`, `lib/flutter_flow/`
- Depends on: Custom actions, app state, theme
- Used by: Router, user interaction

**Custom Code Layer:**
- Purpose: ML pipeline and business logic
- Contains: Gemma embeddings, vector processing, search
- Location: `lib/custom_code/actions/`, `lib/custom_code/widgets/`
- Depends on: flutter_gemma, SQLite, data structures
- Used by: Presentation layer via actions

**Backend/Data Layer:**
- Purpose: Data persistence and schemas
- Contains: SQLite manager, data structures
- Location: `lib/backend/sqlite/`, `lib/backend/schema/`
- Depends on: sqflite, schema utilities
- Used by: Custom actions, app state

**State Layer:**
- Purpose: Global app state and persistence
- Contains: FFAppState with SharedPreferences
- Location: `lib/app_state.dart`
- Depends on: SharedPreferences, schema structs
- Used by: All layers via Provider

## Data Flow

**Embedding Generation Flow:**

1. User triggers embedding via `GenerateEmbeddings` widget (`lib/custom_code/widgets/generate_embeddings.dart`)
2. Widget calls `processDocumentsToVectors()` action (`lib/custom_code/actions/process_documents_to_vectors.dart`)
3. Action uses `GemmaEmbedderWrapper` singleton (`lib/custom_code/gemma_embedder_wrapper.dart`)
4. Wrapper calls flutter_gemma for vector generation
5. Results stored via `saveVectorsToDb()` (`lib/custom_code/actions/save_vectors_to_db.dart`)
6. SQLite batch insert to embeddings table

**Search Flow:**

1. User enters query on Search screen (`lib/demo/search/search_widget.dart`)
2. Query passed to `findTopMatches()` action (`lib/custom_code/actions/find_top_matches.dart`)
3. Query embedded via `GemmaEmbedderWrapper`
4. Cosine similarity calculated against stored vectors
5. Top K results returned above threshold

**State Management:**
- FFAppState singleton with SharedPreferences persistence (`lib/app_state.dart`)
- ChangeNotifier pattern for reactive updates
- Persisted fields: `isModelReady`, `documentsToIndex`, `allVectors`

## Key Abstractions

**VectorDocumentStruct:**
- Purpose: Data structure for text + embedding pair
- Location: `lib/backend/schema/structs/vector_document_struct.dart`
- Fields: id, text, vector (List<double>), metadata
- Pattern: FlutterFlow struct with serialization support

**GemmaEmbedderWrapper:**
- Purpose: Singleton wrapper around flutter_gemma
- Location: `lib/custom_code/gemma_embedder_wrapper.dart`
- Pattern: Lazy-loaded singleton with cached model reference

**SQLiteManager:**
- Purpose: Database initialization and access
- Location: `lib/backend/sqlite/sqlite_manager.dart`
- Pattern: Singleton with static database reference

**FFAppState:**
- Purpose: Global reactive state container
- Location: `lib/app_state.dart`
- Pattern: ChangeNotifier singleton with persistence

## Entry Points

**App Entry:**
- Location: `lib/main.dart`
- Triggers: App launch
- Responsibilities:
  1. Initialize sqflite FFI bindings
  2. Initialize Gemma plugin
  3. Initialize SQLite database
  4. Initialize theme
  5. Load persisted app state
  6. Run app with Provider

**Navigation:**
- Location: `lib/flutter_flow/nav/nav.dart`
- Triggers: Route changes
- Responsibilities: GoRouter configuration, route definitions

## Error Handling

**Strategy:** Try-catch at action level, print errors to console

**Patterns:**
- Actions catch exceptions and print to console (`lib/custom_code/actions/process_documents_to_vectors.dart` line 44-46)
- Widget callbacks for error propagation (`lib/custom_code/widgets/generate_embeddings.dart` line 104)
- Silent failures return empty lists rather than throwing

## Cross-Cutting Concerns

**Logging:**
- print() statements for errors and debugging
- No structured logging framework

**Initialization:**
- FlutterGemma must be initialized before model operations
- SQLite must be initialized before database operations
- Both happen in `main()` before `runApp()`

**Theme:**
- FlutterFlowTheme provides consistent styling
- Light/dark mode support via MaterialApp.router

---

*Architecture analysis: 2026-01-22*
*Update when major patterns change*
