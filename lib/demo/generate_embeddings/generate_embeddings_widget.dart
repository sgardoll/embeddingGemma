import '/backend/schema/structs/index.dart';
import '/demo/demo_document/demo_document_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/index.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'generate_embeddings_model.dart';
export 'generate_embeddings_model.dart';

class GenerateEmbeddingsWidget extends StatefulWidget {
  const GenerateEmbeddingsWidget({super.key});

  static String routeName = 'GenerateEmbeddings';
  static String routePath = '/generateEmbeddings';

  @override
  State<GenerateEmbeddingsWidget> createState() =>
      _GenerateEmbeddingsWidgetState();
}

class _GenerateEmbeddingsWidgetState extends State<GenerateEmbeddingsWidget> {
  late GenerateEmbeddingsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GenerateEmbeddingsModel());

    _model.inputTextFieldTextController ??= TextEditingController();
    _model.inputTextFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,

        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,

        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,

          automaticallyImplyLeading: false,

          title: Text(
            'Generate Embeddings',

            style: FlutterFlowTheme.of(context).headlineMedium.override(
              font: GoogleFonts.interTight(
                fontWeight: FlutterFlowTheme.of(
                  context,
                ).headlineMedium.fontWeight,
                fontStyle: FlutterFlowTheme.of(
                  context,
                ).headlineMedium.fontStyle,
              ),

              letterSpacing: 0.0,
              fontWeight: FlutterFlowTheme.of(
                context,
              ).headlineMedium.fontWeight,
              fontStyle: FlutterFlowTheme.of(context).headlineMedium.fontStyle,
            ),
          ),
          actions: [],

          centerTitle: false,

          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,

              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: Text(
                    'Add documents to your vector database collection. Each entry represents a document that can be searched and analyzed.',

                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(
                        fontWeight: FlutterFlowTheme.of(
                          context,
                        ).bodyMedium.fontWeight,
                        fontStyle: FlutterFlowTheme.of(
                          context,
                        ).bodyMedium.fontStyle,
                      ),

                      color: FlutterFlowTheme.of(context).secondaryText,

                      letterSpacing: 0.0,
                      fontWeight: FlutterFlowTheme.of(
                        context,
                      ).bodyMedium.fontWeight,
                      fontStyle: FlutterFlowTheme.of(
                        context,
                      ).bodyMedium.fontStyle,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: Container(
                    width: double.infinity,

                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,

                      borderRadius: BorderRadius.circular(12.0),
                    ),

                    child: Column(
                      mainAxisSize: MainAxisSize.max,

                      children: [
                        Builder(
                          builder: (context) {
                            final documents = FFAppState().documentsToIndex
                                .toList();

                            return ListView.separated(
                              padding: EdgeInsets.zero,

                              primary: false,

                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: documents.length,
                              separatorBuilder: (_, __) =>
                                  SizedBox(height: 12.0),
                              itemBuilder: (context, documentsIndex) {
                                final documentsItem = documents[documentsIndex];
                                return Container(
                                  width: double.infinity,

                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(
                                      context,
                                    ).primaryBackground,

                                    borderRadius: BorderRadius.circular(8.0),

                                    border: Border.all(
                                      color: FlutterFlowTheme.of(
                                        context,
                                      ).alternate,
                                      width: 1.0,
                                    ),
                                  ),

                                  child: Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,

                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                12.0,
                                                0.0,
                                                12.0,
                                                0.0,
                                              ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Document ${documentsIndex.toString()}',

                                                style:
                                                    FlutterFlowTheme.of(
                                                      context,
                                                    ).labelSmall.override(
                                                      font: GoogleFonts.inter(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                  context,
                                                                )
                                                                .labelSmall
                                                                .fontStyle,
                                                      ),

                                                      color:
                                                          FlutterFlowTheme.of(
                                                            context,
                                                          ).primary,

                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                context,
                                                              )
                                                              .labelSmall
                                                              .fontStyle,
                                                    ),
                                              ),
                                              Align(
                                                alignment: AlignmentDirectional(
                                                  0.0,
                                                  0.0,
                                                ),
                                                child: FlutterFlowIconButton(
                                                  borderRadius: 12.0,

                                                  buttonSize: 24.0,

                                                  icon: Icon(
                                                    Icons.close_rounded,
                                                    color: FlutterFlowTheme.of(
                                                      context,
                                                    ).error,
                                                    size: 16.0,
                                                  ),

                                                  onPressed: () async {
                                                    FFAppState()
                                                        .removeAtIndexFromDocumentsToIndex(
                                                          documentsIndex,
                                                        );
                                                    safeSetState(() {});
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        DemoDocumentWidget(
                                          key: Key(
                                            'Keyqoh_${documentsIndex}_of_${documents.length}',
                                          ),
                                          input: documentsItem,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ].divide(SizedBox(height: 12.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: TextFormField(
                    controller: _model.inputTextFieldTextController,
                    focusNode: _model.inputTextFieldFocusNode,

                    onChanged: (_) => EasyDebounce.debounce(
                      '_model.inputTextFieldTextController',
                      Duration(milliseconds: 0),
                      () => safeSetState(() {}),
                    ),
                    onFieldSubmitted: (_) async {
                      FFAppState().addToDocumentsToIndex(
                        _model.inputTextFieldTextController.text,
                      );
                      safeSetState(() {});
                      safeSetState(() {
                        _model.inputTextFieldTextController?.clear();
                      });
                    },
                    autofocus: false,
                    enabled: true,

                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.done,

                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Add new document and hit enter',
                      hintStyle: FlutterFlowTheme.of(context).bodyMedium
                          .override(
                            font: GoogleFonts.inter(
                              fontWeight: FlutterFlowTheme.of(
                                context,
                              ).bodyMedium.fontWeight,
                              fontStyle: FlutterFlowTheme.of(
                                context,
                              ).bodyMedium.fontStyle,
                            ),

                            color: FlutterFlowTheme.of(context).secondaryText,

                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(
                              context,
                            ).bodyMedium.fontWeight,
                            fontStyle: FlutterFlowTheme.of(
                              context,
                            ).bodyMedium.fontStyle,
                          ),

                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).primary,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).tertiary,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      filled: true,
                      fillColor: FlutterFlowTheme.of(
                        context,
                      ).secondaryBackground,

                      suffixIcon:
                          _model.inputTextFieldTextController!.text.isNotEmpty
                          ? InkWell(
                              onTap: () async {
                                _model.inputTextFieldTextController?.clear();
                                safeSetState(() {});
                              },
                              child: Icon(
                                Icons.clear,
                                color: FlutterFlowTheme.of(context).error,
                                size: 16.0,
                              ),
                            )
                          : null,
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.inter(
                        fontWeight: FlutterFlowTheme.of(
                          context,
                        ).bodyMedium.fontWeight,
                        fontStyle: FlutterFlowTheme.of(
                          context,
                        ).bodyMedium.fontStyle,
                      ),

                      fontSize: 14.0,
                      letterSpacing: 0.0,
                      fontWeight: FlutterFlowTheme.of(
                        context,
                      ).bodyMedium.fontWeight,
                      fontStyle: FlutterFlowTheme.of(
                        context,
                      ).bodyMedium.fontStyle,
                    ),

                    maxLines: 3,
                    minLines: 1,

                    cursorColor: FlutterFlowTheme.of(context).primary,
                    enableInteractiveSelection: true,
                    validator: _model.inputTextFieldTextControllerValidator
                        .asValidator(context),
                    inputFormatters: [
                      if (!isAndroid && !isiOS)
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          return TextEditingValue(
                            selection: newValue.selection,
                            text: newValue.text.toCapitalization(
                              TextCapitalization.sentences,
                            ),
                          );
                        }),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      _model.vectorDocs = await actions
                          .processDocumentsToVectors(
                            FFAppState().documentsToIndex.toList(),
                          );
                      await actions.saveVectorsToDb(
                        _model.vectorDocs!.toList(),
                      );
                      FFAppState().allVectors = _model.vectorDocs!
                          .toList()
                          .cast<VectorDocumentStruct>();
                      safeSetState(() {});
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Saved documents to database',
                            style: GoogleFonts.interTight(
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                          ),
                          duration: Duration(milliseconds: 4000),
                          backgroundColor: FlutterFlowTheme.of(
                            context,
                          ).secondary,
                        ),
                      );

                      context.pushNamed(SearchWidget.routeName);

                      safeSetState(() {});
                    },
                    text: 'Generate Embeddings',

                    options: FFButtonOptions(
                      width: double.infinity,
                      height: 50.0,
                      padding: EdgeInsets.all(8.0),

                      iconPadding: EdgeInsetsDirectional.fromSTEB(
                        0.0,
                        0.0,
                        0.0,
                        0.0,
                      ),

                      color: FlutterFlowTheme.of(context).primary,
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

                            color: FlutterFlowTheme.of(context).info,

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
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
              ].divide(SizedBox(height: 16.0)).addToStart(SizedBox(height: 16.0)).addToEnd(SizedBox(height: 24.0)),
            ),
          ),
        ),
      ),
    );
  }
}
