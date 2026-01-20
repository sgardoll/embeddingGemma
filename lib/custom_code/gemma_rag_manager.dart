// Custom Imports
import 'package:flutter_gemma/flutter_gemma.dart';

class GemmaRagManager {
  static final GemmaRagManager _instance = GemmaRagManager._internal();
  factory GemmaRagManager() => _instance;
  GemmaRagManager._internal();

  bool _isEmbeddingLoaded = false;

  /// Initializes the dedicated Embedding Model (distinct from Chat model)
  /// Using the 300M parameter model via MediaPipe
  Future<void> loadEmbedder() async {
    if (_isEmbeddingLoaded) return;

    try {
      // Install the specific embedding model bundle
      // Note: You must host this.task file or use the Google public URL
      await FlutterGemma.installEmbedder()
          .modelFromNetwork(
            'https://huggingface.co/google/embedding-gemma-300m-cpu/resolve/main/embedding-gemma-300m-cpu.task',
            // Add token parameter if using a gated repo
          )
          .install();

      _isEmbeddingLoaded = true;
    } catch (e) {
      print("Error loading embedder: $e");
      rethrow;
    }
  }

  /// Ingests a document into the local Vector Store (SQLite)
  Future<void> ingestDocument(String docId, String content) async {
    if (!_isEmbeddingLoaded) await loadEmbedder();

    // The plugin automatically handles chunking and vector generation
    // and stores it in the local SQLite database managed by the plugin
    await FlutterGemma.instance.addDocument(
      id: docId,
      content: content,
      // Metadata allows you to filter later (e.g., by user ID or topic)
      metadata: {'source': 'user_upload'},
    );
  }

  /// Semantic Search
  Future<String> retrieveContext(String query) async {
    if (!_isEmbeddingLoaded) await loadEmbedder();

    // Perform cosine similarity search
    final results = await FlutterGemma.instance.searchSimilar(
      query: query,
      topK: 3, // Fetch top 3 most relevant chunks
      threshold: 0.7, // Minimum similarity score
    );

    // Combine results into a single context block
    return results.map((r) => r.content).join("\n\n");
  }
}
