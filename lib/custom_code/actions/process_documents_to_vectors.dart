// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '../gemma_embedder_wrapper.dart';

Future<List<VectorDocumentStruct>> processDocumentsToVectors(
  List<String> documents,
) async {
  // Initialize the list to hold the structured vector data
  List<VectorDocumentStruct> vectorDocuments = [];

  // Access the singleton wrapper
  final embedder = GemmaEmbedderWrapper.instance;

  for (String docText in documents) {
    if (docText.trim().isEmpty) continue;

    try {
      // Generate embedding for the current document
      final List<double> embedding = await embedder.getEmbedding(docText);

      if (embedding.isNotEmpty) {
        // Create the struct. Assuming 'id' is generated or not needed strictly for this step.
        // You might want to generate a UUID here if your struct requires a unique ID.
        final vectorDoc = VectorDocumentStruct(
          id: DateTime.now()
              .millisecondsSinceEpoch
              .toString(), // Simple ID generation
          text: docText,
          vector: embedding,
          metadata: "Ingested via Gemma", // Optional metadata
        );

        vectorDocuments.add(vectorDoc);
      }
    } catch (e) {
      print('Failed to process document: $docText. Error: $e');
    }
  }

  return vectorDocuments;
}
