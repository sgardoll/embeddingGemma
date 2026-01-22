import '/demo/empty/empty_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'search_model.dart';
export 'search_model.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  static String routeName = 'Search';
  static String routePath = '/search';

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  late SearchModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
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
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,

            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 30.0,
            ),

            onPressed: () async {
              context.safePop();
            },
          ),
          title: Text(
            'Search',

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

          elevation: 4.0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            primary: false,

            child: Column(
              mainAxisSize: MainAxisSize.max,

              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                    16.0,
                    24.0,
                    16.0,
                    0.0,
                  ),
                  child: Container(
                    width: double.infinity,

                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,

                      borderRadius: BorderRadius.circular(12.0),
                    ),

                    child: TextFormField(
                      controller: _model.textController,
                      focusNode: _model.textFieldFocusNode,

                      onChanged: (_) => EasyDebounce.debounce(
                        '_model.textController',
                        Duration(milliseconds: 500),
                        () async {
                          _model.matchedDocs = await actions.findTopMatches(
                            _model.textController.text,
                            FFAppState().allVectors.toList(),
                            5,
                            0.7,
                          );

                          safeSetState(() {});
                        },
                      ),

                      autofocus: false,
                      enabled: true,

                      textInputAction: TextInputAction.search,

                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'Search documents...',
                        hintStyle: FlutterFlowTheme.of(context).labelMedium
                            .override(
                              font: GoogleFonts.inter(
                                fontWeight: FlutterFlowTheme.of(
                                  context,
                                ).labelMedium.fontWeight,
                                fontStyle: FlutterFlowTheme.of(
                                  context,
                                ).labelMedium.fontStyle,
                              ),

                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(
                                context,
                              ).labelMedium.fontWeight,
                              fontStyle: FlutterFlowTheme.of(
                                context,
                              ).labelMedium.fontStyle,
                            ),

                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).alternate,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primary,
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
                        ).primaryBackground,
                        contentPadding: EdgeInsetsDirectional.fromSTEB(
                          16.0,
                          0.0,
                          16.0,
                          0.0,
                        ),

                        prefixIcon: Icon(
                          Icons.search,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 20.0,
                        ),
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

                        fontSize: 16.0,
                        letterSpacing: 0.0,
                        fontWeight: FlutterFlowTheme.of(
                          context,
                        ).bodyMedium.fontWeight,
                        fontStyle: FlutterFlowTheme.of(
                          context,
                        ).bodyMedium.fontStyle,
                      ),

                      cursorColor: FlutterFlowTheme.of(context).primary,
                      enableInteractiveSelection: true,
                      validator: _model.textControllerValidator.asValidator(
                        context,
                      ),
                    ),
                  ),
                ),
                if (valueOrDefault<bool>(
                  (FFAppState().allVectors.isNotEmpty) &&
                      (_model.textController.text != ''),
                  false,
                ))
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                      16.0,
                      24.0,
                      16.0,
                      0.0,
                    ),
                    child: SingleChildScrollView(
                      primary: false,

                      child: Column(
                        mainAxisSize: MainAxisSize.min,

                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Text(
                                'Search Results',

                                style: FlutterFlowTheme.of(context).titleMedium
                                    .override(
                                      font: GoogleFonts.interTight(
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FlutterFlowTheme.of(
                                          context,
                                        ).titleMedium.fontStyle,
                                      ),

                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(
                                        context,
                                      ).titleMedium.fontStyle,
                                    ),
                              ),
                              Text(
                                '${_model.matchedDocs?.length.toString()} Found Items',

                                style: FlutterFlowTheme.of(context).labelMedium
                                    .override(
                                      font: GoogleFonts.inter(
                                        fontWeight: FlutterFlowTheme.of(
                                          context,
                                        ).labelMedium.fontWeight,
                                        fontStyle: FlutterFlowTheme.of(
                                          context,
                                        ).labelMedium.fontStyle,
                                      ),

                                      color: FlutterFlowTheme.of(
                                        context,
                                      ).secondaryText,

                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(
                                        context,
                                      ).labelMedium.fontWeight,
                                      fontStyle: FlutterFlowTheme.of(
                                        context,
                                      ).labelMedium.fontStyle,
                                    ),
                              ),
                            ],
                          ),
                          Builder(
                            builder: (context) {
                              final searchResults = _model.matchedDocs!
                                  .map((e) => e)
                                  .toList();
                              if (searchResults.isEmpty) {
                                return EmptyWidget();
                              }

                              return ListView.separated(
                                padding: EdgeInsets.zero,

                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: searchResults.length,
                                separatorBuilder: (_, __) =>
                                    SizedBox(height: 12.0),
                                itemBuilder: (context, searchResultsIndex) {
                                  final searchResultsItem =
                                      searchResults[searchResultsIndex];
                                  return Container(
                                    width: double.infinity,

                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(
                                        context,
                                      ).secondaryBackground,

                                      borderRadius: BorderRadius.circular(8.0),

                                      border: Border.all(
                                        color: FlutterFlowTheme.of(
                                          context,
                                        ).alternate,
                                        width: 1.0,
                                      ),
                                    ),

                                    child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,

                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,

                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Document',

                                                      maxLines: 2,

                                                      style:
                                                          FlutterFlowTheme.of(
                                                            context,
                                                          ).titleSmall.override(
                                                            font: GoogleFonts.interTight(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                        context,
                                                                      )
                                                                      .titleSmall
                                                                      .fontStyle,
                                                            ),

                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                      context,
                                                                    )
                                                                    .titleSmall
                                                                    .fontStyle,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Icon(
                                                Icons.description,
                                                color: FlutterFlowTheme.of(
                                                  context,
                                                ).secondaryText,
                                                size: 20.0,
                                              ),
                                            ],
                                          ),
                                          Text(
                                            searchResultsItem.text,

                                            maxLines: 3,

                                            style: FlutterFlowTheme.of(context)
                                                .bodySmall
                                                .override(
                                                  font: GoogleFonts.inter(
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).bodySmall.fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).bodySmall.fontStyle,
                                                  ),

                                                  color: FlutterFlowTheme.of(
                                                    context,
                                                  ).secondaryText,
                                                  fontSize: 14.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                        context,
                                                      ).bodySmall.fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                        context,
                                                      ).bodySmall.fontStyle,
                                                ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                  0.0,
                                                  4.0,
                                                  0.0,
                                                  0.0,
                                                ),
                                            child: Text(
                                              searchResultsItem.metadata,

                                              style:
                                                  FlutterFlowTheme.of(
                                                    context,
                                                  ).bodySmall.override(
                                                    font: GoogleFonts.inter(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                context,
                                                              )
                                                              .bodySmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                            context,
                                                          ).bodySmall.fontStyle,
                                                    ),

                                                    color: FlutterFlowTheme.of(
                                                      context,
                                                    ).accent1,

                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).bodySmall.fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                          context,
                                                        ).bodySmall.fontStyle,
                                                  ),
                                            ),
                                          ),
                                        ].divide(SizedBox(height: 8.0)),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
