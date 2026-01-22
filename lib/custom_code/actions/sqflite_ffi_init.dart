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

import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as ffi;

/// Initializes sqflite FFI for desktop platforms.
/// Call this in main() before any database operations on Windows/Linux/macOS.
/// On mobile platforms (iOS/Android), this is a no-op as sqflite works natively.
Future<void> sqfliteFfiInit() async {
  // Only initialize FFI on desktop platforms
  if (!kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.linux ||
          defaultTargetPlatform == TargetPlatform.macOS)) {
    // Initialize FFI (only needed for Windows, but safe to call on all desktop)
    ffi.sqfliteFfiInit();
    // Set the database factory to use FFI
    ffi.databaseFactory = ffi.databaseFactoryFfi;
  }
  // On mobile platforms, sqflite works out of the box
}
