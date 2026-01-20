// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class VectorDocumentStruct extends BaseStruct {
  VectorDocumentStruct({
    String? text,
    List<double>? vector,
    String? id,
    String? metadata,
  })  : _text = text,
        _vector = vector,
        _id = id,
        _metadata = metadata;

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  set text(String? val) => _text = val;

  bool hasText() => _text != null;

  // "vector" field.
  List<double>? _vector;
  List<double> get vector => _vector ?? const [];
  set vector(List<double>? val) => _vector = val;

  void updateVector(Function(List<double>) updateFn) {
    updateFn(_vector ??= []);
  }

  bool hasVector() => _vector != null;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "metadata" field.
  String? _metadata;
  String get metadata => _metadata ?? '';
  set metadata(String? val) => _metadata = val;

  bool hasMetadata() => _metadata != null;

  static VectorDocumentStruct fromMap(Map<String, dynamic> data) =>
      VectorDocumentStruct(
        text: data['text'] as String?,
        vector: getDataList(data['vector']),
        id: data['id'] as String?,
        metadata: data['metadata'] as String?,
      );

  static VectorDocumentStruct? maybeFromMap(dynamic data) => data is Map
      ? VectorDocumentStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'text': _text,
        'vector': _vector,
        'id': _id,
        'metadata': _metadata,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'text': serializeParam(
          _text,
          ParamType.String,
        ),
        'vector': serializeParam(
          _vector,
          ParamType.double,
          isList: true,
        ),
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'metadata': serializeParam(
          _metadata,
          ParamType.String,
        ),
      }.withoutNulls;

  static VectorDocumentStruct fromSerializableMap(Map<String, dynamic> data) =>
      VectorDocumentStruct(
        text: deserializeParam(
          data['text'],
          ParamType.String,
          false,
        ),
        vector: deserializeParam<double>(
          data['vector'],
          ParamType.double,
          true,
        ),
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
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
        text == other.text &&
        listEquality.equals(vector, other.vector) &&
        id == other.id &&
        metadata == other.metadata;
  }

  @override
  int get hashCode => const ListEquality().hash([text, vector, id, metadata]);
}

VectorDocumentStruct createVectorDocumentStruct({
  String? text,
  String? id,
  String? metadata,
}) =>
    VectorDocumentStruct(
      text: text,
      id: id,
      metadata: metadata,
    );
