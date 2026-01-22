# Testing Patterns

**Analysis Date:** 2026-01-22

## Test Framework

**Runner:**
- flutter_test SDK (built into Flutter)
- No additional test runner configuration

**Assertion Library:**
- flutter_test built-in matchers
- Standard expect() assertions

**Run Commands:**
```bash
flutter test                          # Run all tests
flutter test test/widget_test.dart    # Single file
flutter test --coverage               # Coverage report
```

## Test File Organization

**Location:**
- `test/` directory at project root
- Currently minimal: only `test/widget_test.dart` exists

**Naming:**
- *_test.dart suffix for test files
- No distinction between unit/integration in naming

**Structure:**
```
test/
└── widget_test.dart    # Basic smoke test
```

## Test Structure

**Suite Organization:**
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:embedding_gemma/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
  });
}
```

**Patterns:**
- testWidgets() for widget tests
- WidgetTester for interaction simulation
- Basic smoke test pattern (build and verify no crash)

## Mocking

**Framework:**
- Not currently used (no mock packages in dependencies)

**Patterns:**
- No mocking infrastructure observed
- Tests are minimal smoke tests only

**What Would Need Mocking (if tests added):**
- flutter_gemma plugin
- SQLite database
- SharedPreferences

## Fixtures and Factories

**Test Data:**
- No test fixtures currently exist
- Sample documents hardcoded in `lib/app_state.dart`:
```dart
List<String> _documentsToIndex = [
  'A common phrase is "The quick brown fox jumps over the lazy dog"',
  'Machine learning is a subset of AI"',
  'Flutter is the best cross-platform framework',
];
```

**Location:**
- No dedicated fixtures directory

## Coverage

**Requirements:**
- No enforced coverage target
- Coverage not currently tracked

**Configuration:**
- Built-in flutter test --coverage support
- No coverage configuration file

**View Coverage:**
```bash
flutter test --coverage
# Generates coverage/lcov.info
```

## Test Types

**Unit Tests:**
- Not currently implemented
- Would test: `_cosineSimilarity`, vector processing functions

**Widget Tests:**
- Minimal: single smoke test exists
- Tests that MyApp widget builds without error

**Integration Tests:**
- Not implemented
- Would test: embedding pipeline, SQLite storage

**E2E Tests:**
- Not implemented
- Would use flutter_driver or integration_test package

## Common Patterns

**Widget Testing:**
```dart
testWidgets('description', (WidgetTester tester) async {
  await tester.pumpWidget(MyApp());
  // Could add: expect(find.text('...'), findsOneWidget);
});
```

**Current Gaps:**
- No unit tests for custom actions
- No integration tests for embedding pipeline
- No tests for SQLite operations
- No tests for GemmaEmbedderWrapper

## Recommendations

**Priority Test Areas:**
1. `_cosineSimilarity()` in `lib/custom_code/actions/find_top_matches.dart` - Pure function, easy to unit test
2. `VectorDocumentStruct` serialization - Data integrity critical
3. Widget tests for GenerateEmbeddings custom widget

**Mocking Strategy Needed:**
- Mock flutter_gemma for embedding generation
- Mock SQLiteManager for database operations
- Use ProviderScope override for FFAppState

---

*Testing analysis: 2026-01-22*
*Update when test patterns change*
