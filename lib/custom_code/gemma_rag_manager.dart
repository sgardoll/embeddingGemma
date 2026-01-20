import 'gemma_embedder_wrapper.dart';

class GemmaRAGManager {
  static final GemmaRAGManager _instance = GemmaRAGManager._internal();
  static GemmaRAGManager get instance => _instance;

  GemmaRAGManager._internal();

  /// Prepares the environment for RAG operations.
  /// Currently acts as a proxy to initialization logic if needed.
  Future<void> initialize() async {
    // Add any specific RAG initialization logic here.
    // The Wrapper manages the plugin instance, but if you have
    // specific vector DB initialization, do it here.
    print("Gemma RAG Manager Initialized");
  }

  /// Convenience method to get embedding directly via manager
  Future<List<double>> embedText(String text) async {
    return await GemmaEmbedderWrapper.instance.getEmbedding(text);
  }
}
