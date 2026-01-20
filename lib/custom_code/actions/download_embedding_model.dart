// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter_gemma/flutter_gemma.dart';

/// Before any embedding can happen, the 300MB model file must be present.
///
/// We create a Custom Action downloadEmbeddingModel that utilizes
/// flutter_gemma's built-in download capability (which handles resume support
/// and path management).
Future<String> downloadEmbeddingModel(String url) async {
  try {
    // We use the download facility.
    // This allows us to show a progress bar in the UI via AppState updates if we wired it up,
    // but for a simple action, we await completion.
    await FlutterGemma.installModel(
      modelType: ModelType.gemmaIt, // Adapting to available enums
    ).fromNetwork(url).install();

    return "Success";
  } catch (e) {
    return "Error: $e";
  }
}
