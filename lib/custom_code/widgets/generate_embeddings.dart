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

import 'index.dart'; // Imports other custom widgets

/// A widget that generates embeddings from documents and saves them to
/// SQLite.
///
/// This widget provides a UI for: - Displaying progress during embedding
/// generation - Showing status of the embedding pipeline - Triggering
/// embedding generation and database storage
class GenerateEmbeddings extends StatefulWidget {
  const GenerateEmbeddings({
    super.key,
    this.width,
    this.height,
    this.documents,
    this.onComplete,
    this.onError,
  });

  final double? width;
  final double? height;

  /// List of text documents to generate embeddings for
  final List<String>? documents;

  /// Callback when embedding generation and storage is complete
  final Future Function(int count)? onComplete;

  /// Callback when an error occurs
  final Future Function(String error)? onError;

  @override
  State<GenerateEmbeddings> createState() => _GenerateEmbeddingsState();
}

class _GenerateEmbeddingsState extends State<GenerateEmbeddings> {
  bool _isProcessing = false;
  String _status = 'Ready';
  int _processedCount = 0;
  int _totalCount = 0;

  @override
  void initState() {
    super.initState();
    _totalCount = widget.documents?.length ?? 0;
  }

  @override
  void didUpdateWidget(GenerateEmbeddings oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.documents != oldWidget.documents) {
      _totalCount = widget.documents?.length ?? 0;
    }
  }

  Future<void> _generateAndSaveEmbeddings() async {
    if (_isProcessing) return;
    if (widget.documents == null || widget.documents!.isEmpty) {
      setState(() => _status = 'No documents provided');
      return;
    }

    setState(() {
      _isProcessing = true;
      _status = 'Generating embeddings...';
      _processedCount = 0;
    });

    try {
      // Generate embeddings using the existing action
      final vectors = await processDocumentsToVectors(widget.documents!);

      setState(() {
        _processedCount = vectors.length;
        _status = 'Saving to database...';
      });

      // Save to SQLite using the existing action
      await saveVectorsToDb(vectors);

      setState(() {
        _status = 'Complete! Saved $_processedCount vectors';
        _isProcessing = false;
      });

      // Notify completion
      await widget.onComplete?.call(vectors.length);
    } catch (e) {
      setState(() {
        _status = 'Error: $e';
        _isProcessing = false;
      });

      await widget.onError?.call(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Status display
          Text(
            _status,
            style: FlutterFlowTheme.of(context).bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          // Progress indicator
          if (_isProcessing) ...[
            LinearProgressIndicator(
              value: _totalCount > 0 ? _processedCount / _totalCount : null,
              backgroundColor: FlutterFlowTheme.of(context).alternate,
              valueColor: AlwaysStoppedAnimation<Color>(
                FlutterFlowTheme.of(context).primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '$_processedCount / $_totalCount documents',
              style: FlutterFlowTheme.of(context).labelSmall,
              textAlign: TextAlign.center,
            ),
          ],

          const SizedBox(height: 16),

          // Generate button
          ElevatedButton(
            onPressed: _isProcessing ? null : _generateAndSaveEmbeddings,
            style: ElevatedButton.styleFrom(
              backgroundColor: FlutterFlowTheme.of(context).primary,
              foregroundColor: FlutterFlowTheme.of(context).info,
              disabledBackgroundColor: FlutterFlowTheme.of(
                context,
              ).secondaryBackground,
            ),
            child: Text(
              _isProcessing ? 'Processing...' : 'Generate Embeddings',
            ),
          ),
        ],
      ),
    );
  }
}
