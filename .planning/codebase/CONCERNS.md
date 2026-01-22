# Codebase Concerns

**Analysis Date:** 2026-01-22

## Tech Debt

**Empty table name in SQL INSERT:**
- Issue: `save_vectors_to_db.dart` has empty table name in INSERT statement
- File: `lib/custom_code/actions/save_vectors_to_db.dart` (line 28-30)
- Code: `INSERT OR REPLACE INTO "" (id, content, embedding, metadata)`
- Why: Likely placeholder never filled in
- Impact: SQL INSERT will fail at runtime
- Fix approach: Replace `""` with actual table name (e.g., `embeddings` or `vector_documents`)

**Duplicate index.dart imports:**
- Issue: Multiple redundant `import 'index.dart'` statements in custom action files
- Files: `lib/custom_code/actions/initialize_gemma.dart` (lines 6, 11, 13), `lib/custom_code/actions/find_top_matches.dart` (lines 6, 11, 13), others
- Why: FlutterFlow generates these, developers added more
- Impact: No runtime impact, but code noise
- Fix approach: Remove duplicate imports after `// Begin custom action code`

**Silent error handling returns empty:**
- Issue: Errors caught and logged but return empty results
- File: `lib/custom_code/gemma_embedder_wrapper.dart` (lines 30-34)
- Why: Defensive coding to prevent crashes
- Impact: Silent failures hard to debug; user doesn't know why search returns nothing
- Fix approach: Consider Result<T, Error> pattern or error callbacks

## Known Bugs

**Empty table name will cause runtime crash:**
- Symptoms: App crashes when saving embeddings to database
- Trigger: User generates embeddings and attempts to save
- File: `lib/custom_code/actions/save_vectors_to_db.dart` line 29
- Workaround: None - critical bug
- Root cause: Empty string `""` as table name in SQL
- Fix: Replace with correct table name

## Security Considerations

**Print statements include user data:**
- Risk: Document text and errors printed to console/logs
- Files: `lib/custom_code/gemma_embedder_wrapper.dart` line 31, `lib/custom_code/actions/process_documents_to_vectors.dart` line 45
- Current mitigation: None
- Recommendations: Remove or redact sensitive data from logs in production

**No input validation on documents:**
- Risk: Malformed or excessively large documents could cause OOM
- File: `lib/custom_code/actions/process_documents_to_vectors.dart`
- Current mitigation: Empty check only (line 25)
- Recommendations: Add document size limits, sanitization

## Performance Bottlenecks

**Sequential embedding generation:**
- Problem: Documents processed one at a time in for loop
- File: `lib/custom_code/actions/process_documents_to_vectors.dart` (lines 24-47)
- Measurement: Not measured, but linear with document count
- Cause: Sequential await in for loop
- Improvement path: Batch processing or parallel futures (with concurrency limit)

**Full list cosine similarity scan:**
- Problem: Every search scans all documents
- File: `lib/custom_code/actions/find_top_matches.dart` (lines 45-51)
- Measurement: O(n) per query
- Cause: No indexing or approximation
- Improvement path: Add HNSW index or partition by metadata

## Fragile Areas

**GemmaEmbedderWrapper singleton state:**
- File: `lib/custom_code/gemma_embedder_wrapper.dart`
- Why fragile: Cached model reference assumes model never changes
- Common failures: Stale model reference if model updated
- Safe modification: Call `clearCache()` when model changes
- Test coverage: None

**Initialization order dependency:**
- File: `lib/main.dart` lines 16-21
- Why fragile: sqfliteFfiInit → initializeGemma → SQLiteManager.initialize must run in order
- Common failures: FlutterGemma operations before initialization
- Safe modification: Add initialization guards/flags
- Test coverage: None

## Test Coverage Gaps

**No tests for core embedding pipeline:**
- What's not tested: `processDocumentsToVectors`, `findTopMatches`, `saveVectorsToDb`
- Risk: Embedding generation could silently break
- Priority: High
- Difficulty to test: Requires mocking flutter_gemma plugin

**No tests for cosine similarity:**
- What's not tested: `_cosineSimilarity` helper function
- File: `lib/custom_code/actions/find_top_matches.dart` lines 71-89
- Risk: Math errors in similarity calculation
- Priority: High (pure function, easy to test)
- Difficulty to test: Low - pure function, no dependencies

**Widget tests minimal:**
- What's not tested: All custom widgets, all screens
- Risk: UI regressions undetected
- Priority: Medium
- Difficulty to test: Requires widget test setup with mocked dependencies

## Missing Critical Features

**No error UI feedback:**
- Problem: Errors logged to console but user sees nothing
- Current workaround: User retries blindly
- Blocks: Production readiness
- Implementation complexity: Low - add snackbar/dialog on error callbacks

**No document management UI:**
- Problem: Can't view/delete stored embeddings
- Current workaround: Clear app data
- Blocks: User document management
- Implementation complexity: Medium - add list view with delete

**Web platform disabled:**
- Problem: SQLite operations fail silently on web
- File: `lib/backend/sqlite/sqlite_manager.dart` lines 19-21
- Current workaround: Use mobile app only
- Blocks: Web deployment
- Implementation complexity: High - need web-compatible storage (IndexedDB)

---

*Concerns audit: 2026-01-22*
*Update as issues are fixed or new ones discovered*
