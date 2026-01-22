import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'start_download_model.dart';
export 'start_download_model.dart';

/// A page indicating that an embedding model is being downloaded
class StartDownloadWidget extends StatefulWidget {
  const StartDownloadWidget({super.key});

  static String routeName = 'StartDownload';
  static String routePath = '/startDownload';

  @override
  State<StartDownloadWidget> createState() => _StartDownloadWidgetState();
}

class _StartDownloadWidgetState extends State<StartDownloadWidget> {
  late StartDownloadModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StartDownloadModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.downloadResult = await actions.downloadEmbeddingModel(
        valueOrDefault<String>(
          FFLibraryValues().modelUrl,
          'https://huggingface.co/litert-community/Gecko-110m-en/resolve/main/Gecko_256_quant.tflite',
        ),
        valueOrDefault<String>(
          FFLibraryValues().tokenizerUrl,
          'https://huggingface.co/litert-community/Gecko-110m-en/resolve/main/sentencepiece.model',
        ),
      );

      context.pushNamed(GenerateEmbeddingsWidget.routeName);
    });
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

        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      // Opener Loading by RGB4Media on IconScout
                      // (https://iconscout.com/free-lottie-animation/free-opener-loading-animation_3162481)
                      Lottie.asset(
                        'assets/jsons/opener-loading.json',
                        width: 200.0,
                        height: 200.0,
                        fit: BoxFit.contain,
                        frameRate: FrameRate(30.0),

                        animate: true,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,

                        children: [
                          Text(
                            'Downloading Model',
                            textAlign: TextAlign.center,

                            style: FlutterFlowTheme.of(context).headlineMedium
                                .override(
                                  font: GoogleFonts.interTight(
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(
                                      context,
                                    ).headlineMedium.fontStyle,
                                  ),

                                  fontSize: 28.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(
                                    context,
                                  ).headlineMedium.fontStyle,
                                ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                              16.0,
                              0.0,
                              16.0,
                              0.0,
                            ),
                            child: Text(
                              'We\'re downloading the embedding model. This may take a few minutes depending on your connection.',
                              textAlign: TextAlign.center,

                              style: FlutterFlowTheme.of(context).bodyLarge
                                  .override(
                                    font: GoogleFonts.inter(
                                      fontWeight: FlutterFlowTheme.of(
                                        context,
                                      ).bodyLarge.fontWeight,
                                      fontStyle: FlutterFlowTheme.of(
                                        context,
                                      ).bodyLarge.fontStyle,
                                    ),

                                    color: FlutterFlowTheme.of(
                                      context,
                                    ).secondaryText,

                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(
                                      context,
                                    ).bodyLarge.fontWeight,
                                    fontStyle: FlutterFlowTheme.of(
                                      context,
                                    ).bodyLarge.fontStyle,

                                    lineHeight: 1.4,
                                  ),
                            ),
                          ),
                        ].divide(SizedBox(height: 16.0)),
                      ),
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Container(
                            width: double.infinity,
                            constraints: BoxConstraints(minHeight: 60.0),
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).accent1,

                              borderRadius: BorderRadius.circular(12.0),
                            ),

                            child: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,

                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 20.0,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'The model will be cached locally for faster performance in future sessions.',

                                      maxLines: 2,

                                      style: FlutterFlowTheme.of(context)
                                          .bodySmall
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight: FlutterFlowTheme.of(
                                                context,
                                              ).bodySmall.fontWeight,
                                              fontStyle: FlutterFlowTheme.of(
                                                context,
                                              ).bodySmall.fontStyle,
                                            ),

                                            color: FlutterFlowTheme.of(
                                              context,
                                            ).primaryText,

                                            letterSpacing: 0.0,
                                            fontWeight: FlutterFlowTheme.of(
                                              context,
                                            ).bodySmall.fontWeight,
                                            fontStyle: FlutterFlowTheme.of(
                                              context,
                                            ).bodySmall.fontStyle,

                                            lineHeight: 1.3,
                                          ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 12.0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ].divide(SizedBox(height: 32.0)),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 32.0, 0.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      context.pushNamed(GenerateEmbeddingsWidget.routeName);
                    },
                    text: 'Cancel Download',

                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 48.0,
                      padding: EdgeInsets.all(8.0),

                      iconPadding: EdgeInsetsDirectional.fromSTEB(
                        0.0,
                        0.0,
                        0.0,
                        0.0,
                      ),

                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      textStyle: FlutterFlowTheme.of(context).titleSmall
                          .override(
                            font: GoogleFonts.interTight(
                              fontWeight: FlutterFlowTheme.of(
                                context,
                              ).titleSmall.fontWeight,
                              fontStyle: FlutterFlowTheme.of(
                                context,
                              ).titleSmall.fontStyle,
                            ),

                            color: FlutterFlowTheme.of(context).secondaryText,

                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(
                              context,
                            ).titleSmall.fontWeight,
                            fontStyle: FlutterFlowTheme.of(
                              context,
                            ).titleSmall.fontStyle,
                          ),
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).alternate,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
