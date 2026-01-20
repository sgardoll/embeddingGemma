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
  Future<List<double>> getEmbedding(String text) async {
    try {
      // Create embedding model if not already created
      _embeddingModel ??=
          await FlutterGemmaPlugin.instance.createEmbeddingModel();

      // Generate embedding using the model
      final result = await _embeddingModel!.generateEmbedding(text);
      return result;
    } catch (e) {
      print('Error generating embedding for text: "$text". Error: $e');
      // Return an empty list or rethrow depending on error handling strategy
      return [];
    }
  }
}
