import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'generate_embeddings_widget.dart' show GenerateEmbeddingsWidget;
import 'package:flutter/material.dart';

class GenerateEmbeddingsModel
    extends FlutterFlowModel<GenerateEmbeddingsWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for InputTextField widget.
  FocusNode? inputTextFieldFocusNode;
  TextEditingController? inputTextFieldTextController;
  String? Function(BuildContext, String?)?
  inputTextFieldTextControllerValidator;
  // Stores action output result for [Custom Action - processDocumentsToVectors] action in Button widget.
  List<VectorDocumentStruct>? vectorDocs;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    inputTextFieldFocusNode?.dispose();
    inputTextFieldTextController?.dispose();
  }
}
