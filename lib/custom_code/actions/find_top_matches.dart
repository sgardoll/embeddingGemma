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

import 'dart:math' as math;
import '../gemma_embedder_wrapper.dart';

Future<List<VectorDocumentStruct>> findTopMatches(
  String query,
  List<VectorDocumentStruct> documents,
  int? topK,
) async {
  if (query.trim().isEmpty || documents.isEmpty) {
    return [];
  }

  final int limit = topK ?? 5;
  final embedder = GemmaEmbedderWrapper.instance;

  // 1. Generate embedding for the query string
  List<double> queryVector;
  try {
    queryVector = await embedder.getEmbedding(query);
    if (queryVector.isEmpty) return [];
  } catch (e) {
    print('Error embedding query: $e');
    return [];
  }

  // 2. Calculate Cosine Similarity for each document
  List<Map<String, dynamic>> scoredDocuments = [];

  for (var doc in documents) {
    // Ensure the document has a valid vector
    if (doc.vector.isEmpty) continue;

    double score = _cosineSimilarity(queryVector, doc.vector);
    scoredDocuments.add({
      'doc': doc,
      'score': score,
    });
  }

  // 3. Sort by score descending (highest similarity first)
  scoredDocuments
      .sort((a, b) => (b['score'] as double).compareTo(a['score'] as double));

  // 4. Return top K results
  return scoredDocuments
      .take(limit)
      .map((entry) => entry['doc'] as VectorDocumentStruct)
      .toList();
}

/// Helper function to calculate cosine similarity between two vectors
double _cosineSimilarity(List<double> vecA, List<double> vecB) {
  if (vecA.length != vecB.length) return 0.0;

  double dotProduct = 0.0;
  double magnitudeA = 0.0;
  double magnitudeB = 0.0;

  for (int i = 0; i < vecA.length; i++) {
    dotProduct += vecA[i] * vecB[i];
    magnitudeA += vecA[i] * vecA[i];
    magnitudeB += vecB[i] * vecB[i];
  }

  magnitudeA = math.sqrt(magnitudeA);
  magnitudeB = math.sqrt(magnitudeB);

  if (magnitudeA == 0 || magnitudeB == 0) return 0.0;

  return dotProduct / (magnitudeA * magnitudeB);
}
