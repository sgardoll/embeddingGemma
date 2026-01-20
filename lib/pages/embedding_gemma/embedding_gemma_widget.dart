import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'embedding_gemma_model.dart';
export 'embedding_gemma_model.dart';

class EmbeddingGemmaWidget extends StatefulWidget {
  const EmbeddingGemmaWidget({super.key});

  static String routeName = 'EmbeddingGemma';
  static String routePath = '/embeddingGemma';

  @override
  State<EmbeddingGemmaWidget> createState() => _EmbeddingGemmaWidgetState();
}

class _EmbeddingGemmaWidgetState extends State<EmbeddingGemmaWidget> {
  late EmbeddingGemmaModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmbeddingGemmaModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      ),
    );
  }
}
