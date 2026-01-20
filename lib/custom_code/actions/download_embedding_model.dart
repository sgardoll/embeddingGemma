// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart'; // Imports other custom actions

import 'package:flutter_gemma/flutter_gemma.dart';

/// Downloads and installs the embedding model and tokenizer.
///
/// For embedding models, you need BOTH:
/// - The model file (.tflite)
/// - The tokenizer file (sentencepiece.model)
///
/// Example URLs (Gecko - no auth required):
/// - modelUrl: https://huggingface.co/litert-community/Gecko-110m-en/resolve/main/Gecko_256_quant.tflite
/// - tokenizerUrl: https://huggingface.co/litert-community/Gecko-110m-en/resolve/main/sentencepiece.model
Future<String> downloadEmbeddingModel(
  String modelUrl,
  String tokenizerUrl,
) async {
  try {
    // Install embedding model using the correct API
    await FlutterGemma.installEmbedder()
        .modelFromNetwork(modelUrl)
        .tokenizerFromNetwork(tokenizerUrl)
        .install();

    return "Success";
  } catch (e) {
    return "Error: $e";
  }
}
