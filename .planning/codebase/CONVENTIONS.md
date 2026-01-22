# Coding Conventions

**Analysis Date:** 2026-01-22

## Naming Patterns

**Files:**
- snake_case.dart for all Dart source files
- *_widget.dart for FlutterFlow page widgets (`start_download_widget.dart`)
- *_model.dart for FlutterFlow page models (`start_download_model.dart`)
- *_struct.dart for data structures (`vector_document_struct.dart`)
- index.dart for barrel exports

**Classes:**
- PascalCase for all classes (`VectorDocumentStruct`, `GemmaEmbedderWrapper`)
- *Widget suffix for StatefulWidget classes (`StartDownloadWidget`)
- *Model suffix for FlutterFlow models (`StartDownloadModel`)
- *Struct suffix for data structures (`VectorDocumentStruct`)

**Functions:**
- camelCase for all functions (`processDocumentsToVectors`, `findTopMatches`)
- _underscore prefix for private functions (`_cosineSimilarity`, `_safeInit`)
- Async functions use Future<T> return type

**Variables:**
- camelCase for local variables and parameters
- _underscore prefix for private instance fields (`_isProcessing`, `_embeddingModel`)
- No prefix for public properties

## Code Style

**Formatting:**
- 2-space indentation (Dart default)
- Single quotes for strings
- Trailing commas in multi-line parameter lists
- 80-character line length (Dart default)

**Linting:**
- `analysis_options.yaml` with flutter_lints 4.0.0
- Custom code directory (`lib/custom_code/**`) excluded from analysis
- `lib/flutter_flow/custom_functions.dart` excluded from analysis

## Import Organization

**Order (observed pattern):**
1. Package imports (`package:flutter/material.dart`)
2. Backend imports (`/backend/schema/structs/index.dart`)
3. FlutterFlow imports (`/flutter_flow/flutter_flow_theme.dart`)
4. Custom code imports (`/custom_code/actions/index.dart`)
5. Relative imports (`../gemma_embedder_wrapper.dart`)

**FlutterFlow Auto-imports:**
```dart
// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!
```

**Path Style:**
- Absolute paths from lib root: `/backend/`, `/flutter_flow/`, `/custom_code/`
- Relative paths for same-directory imports: `./`, `../`

## Error Handling

**Patterns:**
- Try-catch in async action functions
- Print errors to console: `print('Error: $e')`
- Return empty collections on failure rather than throwing
- Callback-based error propagation for widgets

**Example (from `lib/custom_code/gemma_embedder_wrapper.dart`):**
```dart
try {
  _embeddingModel ??= await FlutterGemma.getActiveEmbedder(...);
  final result = await _embeddingModel!.generateEmbedding(text);
  return result;
} catch (e) {
  print('Error generating embedding for text: "$text". Error: $e');
  return []; // Return empty list on failure
}
```

## Logging

**Framework:**
- print() statements for debugging and errors
- No structured logging library

**Patterns:**
- Format: `print('Context message: $variableOrError')`
- Log on errors: `print('Failed to process document: $docText. Error: $e')`
- No logging in hot paths (production performance)

## Comments

**When to Comment:**
- FlutterFlow header blocks (required, do not modify)
- Function-level documentation for public APIs
- Inline comments for complex logic

**Documentation Style:**
```dart
/// Initializes the FlutterGemma plugin.
///
/// This MUST be called in main() before runApp() and before any other
/// FlutterGemma operations (like downloadEmbeddingModel).
Future initializeGemma() async {
```

**FlutterFlow Preservation Comments:**
```dart
// Automatic FlutterFlow imports
// ...
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!
```

## Function Design

**Size:**
- Keep functions focused, typically <50 lines
- Extract helper functions (e.g., `_cosineSimilarity` in `find_top_matches.dart`)

**Parameters:**
- Use optional named parameters with defaults: `{int? topK, double threshold}`
- Nullable types for optional inputs

**Return Values:**
- Explicit return types for all functions
- Use Future<T> for async, List<T> for collections
- Return empty collections rather than null on failure

## Module Design

**Exports:**
- Barrel files (index.dart) export public APIs
- Named exports: `export 'file.dart' show functionName;`

**FlutterFlow Widget Pattern:**
Each screen has paired files:
- `screen_widget.dart` - StatefulWidget with UI
- `screen_model.dart` - FlutterFlowModel with state

**Singleton Pattern (observed):**
```dart
class GemmaEmbedderWrapper {
  static final GemmaEmbedderWrapper _instance = GemmaEmbedderWrapper._internal();
  static GemmaEmbedderWrapper get instance => _instance;
  GemmaEmbedderWrapper._internal();
  // ...
}
```

---

*Convention analysis: 2026-01-22*
*Update when patterns change*
