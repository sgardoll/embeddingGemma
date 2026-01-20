import '/flutter_flow/flutter_flow_util.dart';
import 'demo_document_widget.dart' show DemoDocumentWidget;
import 'package:flutter/material.dart';

class DemoDocumentModel extends FlutterFlowModel<DemoDocumentWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
