import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/schema/structs/index.dart';
import '/backend/sqlite/sqlite_manager.dart';

/// This function iterates through the knowledgeBase, computes the similarity
/// score for each, sorts by score descending, and returns the top $K$ text
/// chunks.
double cosineSimilarity(
  List<double> a,
  List<double> b,
) {
  // double cosineSimilarity(List<double> a, List<double> b) {  double dotProduct = 0.0;  double normA = 0.0;  double normB = 0.0;  for (int i = 0; i < a.length; i++) {    dotProduct += a[i] * b[i];    normA += a[i] * a[i];    normB += b[i] * b[i];  }  return dotProduct / (math.sqrt(normA) * math.sqrt(normB));}

  double dotProduct = 0.0;
  double normA = 0.0;
  double normB = 0.0;
  for (int i = 0; i < a.length; i++) {
    dotProduct += a[i] * b[i];
    normA += a[i] * a[i];
    normB += b[i] * b[i];
  }
  return dotProduct / (math.sqrt(normA) * math.sqrt(normB));
}
