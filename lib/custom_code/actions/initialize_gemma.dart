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

import 'index.dart'; // Imports other custom actions

import 'package:flutter_gemma/flutter_gemma.dart';

/// Initializes the FlutterGemma plugin.
///
/// This MUST be called in main() before runApp() and before any other
/// FlutterGemma operations (like downloadEmbeddingModel).
///
/// Usage in main.dart: ```dart void main() async {
/// WidgetsFlutterBinding.ensureInitialized(); await
/// actions.initializeGemma(); // ... rest of your initialization
/// runApp(MyApp()); } ```
Future initializeGemma() async {
  await FlutterGemma.initialize();
}
