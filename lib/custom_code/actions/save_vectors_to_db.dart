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

import 'dart:typed_data';

Future saveVectorsToDb(List<VectorDocumentStruct> vectors) async {
  final db = SQLiteManager.instance.database;

  // Use a batch for efficient bulk insert
  final batch = db.batch();

  for (final vector in vectors) {
    // Convert List<double> to BLOB (binary format)
    final Float64List floatList = Float64List.fromList(vector.vector);
    final Uint8List embeddingBlob = floatList.buffer.asUint8List();

    batch.rawInsert(
      '''INSERT OR REPLACE INTO "" (id, content, embedding, metadata)
         VALUES (?, ?, ?, ?)''',
      [
        vector.id.isNotEmpty
            ? vector.id
            : DateTime.now().millisecondsSinceEpoch.toString(),
        vector.text,
        embeddingBlob,
        vector.metadata.isNotEmpty ? vector.metadata : null,
      ],
    );
  }

  await batch.commit(noResult: true);
}
