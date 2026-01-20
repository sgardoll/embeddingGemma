import 'package:flutter_gemma/flutter_gemma.dart';

class GemmaEmbedderWrapper {
  // Singleton pattern to ensure a single instance manages the model
  static final GemmaEmbedderWrapper _instance =
      GemmaEmbedderWrapper._internal();
  static GemmaEmbedderWrapper get instance => _instance;

  GemmaEmbedderWrapper._internal();

  // Cached embedding model instance
  EmbeddingModel? _embeddingModel;

  /// Retrieves the embedding vector for a given input text.
  /// This wrapper abstracts the underlying plugin call.
  ///
  /// IMPORTANT: You must call downloadEmbeddingModel() first to install
  /// the embedding model and tokenizer before calling this method.
  Future<List<double>> getEmbedding(String text) async {
    try {
      // Get the active embedder if not already cached
      // This requires the model to be installed via FlutterGemma.installEmbedder()
      _embeddingModel ??= await FlutterGemma.getActiveEmbedder(
        preferredBackend: PreferredBackend.cpu,
      );

      // Generate embedding using the model
      final result = await _embeddingModel!.generateEmbedding(text);
      return result;
    } catch (e) {
      print('Error generating embedding for text: "$text". Error: $e');
      // Return an empty list or rethrow depending on error handling strategy
      return [];
    }
  }

  /// Clears the cached embedding model.
  /// Call this if you need to switch to a different model.
  void clearCache() {
    _embeddingModel?.close();
    _embeddingModel = null;
  }
}
