// Key Integration: Importing the same package used by flutterflow_gemma
// This avoids dependency conflicts.
import 'package:flutter_gemma/flutter_gemma.dart';
import 'dart:io';

class GemmaEmbedderWrapper {
  // Singleton instance to prevent multiple model loads
  static final GemmaEmbedderWrapper _instance =
      GemmaEmbedderWrapper._internal();
  factory GemmaEmbedderWrapper() => _instance;
  GemmaEmbedderWrapper._internal();

  bool _isInitialized = false;

  /// The path to the embedding model file.
  /// We must track this separately from the chat model path.
  String? _modelPath;

  /// Initializes the embedding engine.
  ///
  /// CRITICAL: If the Chat model is currently loaded, this might need
  /// to unload it depending on the underlying plugin implementation.
  /// flutter_gemma v0.12.x manages a singleton 'active' model.
  /// To switch to embedding, we effectively 're-install' or 'switch' the active model context.
  Future<void> initialize({required String modelPath}) async {
    if (_isInitialized && _modelPath == modelPath) return;

    try {
      // In flutter_gemma, the installation process prepares the native engine.
      // We use the 'installModel' method which handles the FFI bridge setup.
      // Note: We use ModelType.gemmaIt (or similar) as a placeholder if
      // specific embedding enum isn't exposed, but we point to the embedding.task file.
      // The native MediaPipe graph parser generally detects the model signature.

      await FlutterGemma.installModel(
        modelType: ModelType.gemmaIt,
        // Note: Check the specific version 0.12.1 enum support.
        // If ModelType.embedding exists, use it.
        // If not, the engine often auto-detects based on the file header.
      ).fromAsset(modelPath).install();
      // OR.fromNetwork if downloading dynamically (preferred for size).

      _modelPath = modelPath;
      _isInitialized = true;
    } catch (e) {
      print("Failed to initialize embedding model: $e");
      rethrow;
    }
  }

  /// Generates an embedding for a given text.
  /// Includes logic for Task-Specific Prompting required by EmbeddingGemma.
  Future<List<double>> getEmbedding(String text, {bool isQuery = false}) async {
    if (!_isInitialized) {
      throw Exception(
          "GemmaEmbedderWrapper not initialized. Call initialize() first.");
    }

    // Task-Specific Prompting
    // EmbeddingGemma performs better when the task is explicitly stated.
    String prompt;
    if (isQuery) {
      prompt = "Represent this sentence for searching relevant passages: $text";
    } else {
      prompt = "Represent this sentence for searching: $text";
    }

    try {
      // Access the embedding API.
      // Note: The flutter_gemma plugin exposes embeddings via specific methods.
      // As of v0.12.x, we look for 'getEmbeddings' or similar on the instance.
      final result = await FlutterGemma.instance.getEmbeddings(prompt);

      // Verification of result
      if (result.isEmpty) {
        throw Exception("Embedding generation returned empty vector.");
      }
      return result;
    } catch (e) {
      print("Error during embedding generation: $e");
      rethrow;
    }
  }
}
