// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EmbeddingConfigStruct extends BaseStruct {
  EmbeddingConfigStruct({
    String? modelUrl,
    bool? isInitialized,
  })  : _modelUrl = modelUrl,
        _isInitialized = isInitialized;

  // "modelUrl" field.
  String? _modelUrl;
  String get modelUrl => _modelUrl ?? '';
  set modelUrl(String? val) => _modelUrl = val;

  bool hasModelUrl() => _modelUrl != null;

  // "isInitialized" field.
  bool? _isInitialized;
  bool get isInitialized => _isInitialized ?? false;
  set isInitialized(bool? val) => _isInitialized = val;

  bool hasIsInitialized() => _isInitialized != null;

  static EmbeddingConfigStruct fromMap(Map<String, dynamic> data) =>
      EmbeddingConfigStruct(
        modelUrl: data['modelUrl'] as String?,
        isInitialized: data['isInitialized'] as bool?,
      );

  static EmbeddingConfigStruct? maybeFromMap(dynamic data) => data is Map
      ? EmbeddingConfigStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'modelUrl': _modelUrl,
        'isInitialized': _isInitialized,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'modelUrl': serializeParam(
          _modelUrl,
          ParamType.String,
        ),
        'isInitialized': serializeParam(
          _isInitialized,
          ParamType.bool,
        ),
      }.withoutNulls;

  static EmbeddingConfigStruct fromSerializableMap(Map<String, dynamic> data) =>
      EmbeddingConfigStruct(
        modelUrl: deserializeParam(
          data['modelUrl'],
          ParamType.String,
          false,
        ),
        isInitialized: deserializeParam(
          data['isInitialized'],
          ParamType.bool,
          false,
        ),
      );

  @override
  String toString() => 'EmbeddingConfigStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is EmbeddingConfigStruct &&
        modelUrl == other.modelUrl &&
        isInitialized == other.isInitialized;
  }

  @override
  int get hashCode => const ListEquality().hash([modelUrl, isInitialized]);
}

EmbeddingConfigStruct createEmbeddingConfigStruct({
  String? modelUrl,
  bool? isInitialized,
}) =>
    EmbeddingConfigStruct(
      modelUrl: modelUrl,
      isInitialized: isInitialized,
    );
