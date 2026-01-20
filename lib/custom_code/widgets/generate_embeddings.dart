// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/backend/sqlite/sqlite_manager.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class GenerateEmbeddings extends StatefulWidget {
  const GenerateEmbeddings({
    super.key,
    this.width,
    this.height,
    this.vectors,
  });

  final double? width;
  final double? height;
  final VectorDocumentStruct? vectors;

  @override
  State<GenerateEmbeddings> createState() => _GenerateEmbeddingsState();
}

class _GenerateEmbeddingsState extends State<GenerateEmbeddings> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
