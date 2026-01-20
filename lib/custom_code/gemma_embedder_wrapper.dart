import 'package:flutter_gemma/flutter_gemma.dart';

class GemmaEmbedderWrapper {
  // Singleton pattern to ensure a single instance manages the model
  static final GemmaEmbedderWrapper _instance =
      GemmaEmbedderWrapper._internal();
  static GemmaEmbedderWrapper get instance => _instance;

  GemmaEmbedderWrapper._internal();

  /// Retrieves the embedding vector for a given input text.
  /// This wrapper abstracts the underlying plugin call.
  Future<List<double>> getEmbedding(String text) async {
    try {
      // Calls the flutter_gemma plugin to generate embeddings
      // Ensure your model (e.g., gemma-2b-it-gpu-int4.bin or specifically embedding-gemma)
      // is correctly loaded in main.dart or via the plugin's init method before this is called.
      final result = await FlutterGemmaPlugin.instance.getEmbedding(text);
      return result;
    } catch (e) {
      print('Error generating embedding for text: "$text". Error: $e');
      // Return an empty list or rethrow depending on error handling strategy
      return [];
    }
  }
}
