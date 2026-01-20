// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class VectorDocumentStruct extends BaseStruct {
  VectorDocumentStruct({
    String? content,
    List<double>? vector,
    String? metadata,
  })  : _content = content,
        _vector = vector,
        _metadata = metadata;

  // "content" field.
  String? _content;
  String get content => _content ?? '';
  set content(String? val) => _content = val;

  bool hasContent() => _content != null;

  // "vector" field.
  List<double>? _vector;
  List<double> get vector => _vector ?? const [];
  set vector(List<double>? val) => _vector = val;

  void updateVector(Function(List<double>) updateFn) {
    updateFn(_vector ??= []);
  }

  bool hasVector() => _vector != null;

  // "metadata" field.
  String? _metadata;
  String get metadata => _metadata ?? '';
  set metadata(String? val) => _metadata = val;

  bool hasMetadata() => _metadata != null;

  static VectorDocumentStruct fromMap(Map<String, dynamic> data) =>
      VectorDocumentStruct(
        content: data['content'] as String?,
        vector: getDataList(data['vector']),
        metadata: data['metadata'] as String?,
      );

  static VectorDocumentStruct? maybeFromMap(dynamic data) => data is Map
      ? VectorDocumentStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'content': _content,
        'vector': _vector,
        'metadata': _metadata,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'content': serializeParam(
          _content,
          ParamType.String,
        ),
        'vector': serializeParam(
          _vector,
          ParamType.double,
          isList: true,
        ),
        'metadata': serializeParam(
          _metadata,
          ParamType.String,
        ),
      }.withoutNulls;

  static VectorDocumentStruct fromSerializableMap(Map<String, dynamic> data) =>
      VectorDocumentStruct(
        content: deserializeParam(
          data['content'],
          ParamType.String,
          false,
        ),
        vector: deserializeParam<double>(
          data['vector'],
          ParamType.double,
          true,
        ),
        metadata: deserializeParam(
          data['metadata'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'VectorDocumentStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is VectorDocumentStruct &&
        content == other.content &&
        listEquality.equals(vector, other.vector) &&
        metadata == other.metadata;
  }

  @override
  int get hashCode => const ListEquality().hash([content, vector, metadata]);
}

VectorDocumentStruct createVectorDocumentStruct({
  String? content,
  String? metadata,
}) =>
    VectorDocumentStruct(
      content: content,
      metadata: metadata,
    );
