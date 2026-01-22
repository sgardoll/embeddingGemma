import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      _isModelReady = prefs.getBool('ff_isModelReady') ?? _isModelReady;
    });
    _safeInit(() {
      _documentsToIndex =
          prefs.getStringList('ff_documentsToIndex') ?? _documentsToIndex;
    });
    _safeInit(() {
      _allVectors =
          prefs
              .getStringList('ff_allVectors')
              ?.map((x) {
                try {
                  return VectorDocumentStruct.fromSerializableMap(
                    jsonDecode(x),
                  );
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _allVectors;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  bool _isModelReady = false;
  bool get isModelReady => _isModelReady;
  set isModelReady(bool value) {
    _isModelReady = value;
    prefs.setBool('ff_isModelReady', value);
  }

  List<String> _documentsToIndex = [
    'A common phrase is \"The quick brown fox jumps over the lazy dog\"',
    'Machine learning is a subset of AI\"',
    'Flutter is the best cross-platform framework',
  ];
  List<String> get documentsToIndex => _documentsToIndex;
  set documentsToIndex(List<String> value) {
    _documentsToIndex = value;
    prefs.setStringList('ff_documentsToIndex', value);
  }

  void addToDocumentsToIndex(String value) {
    documentsToIndex.add(value);
    prefs.setStringList('ff_documentsToIndex', _documentsToIndex);
  }

  void removeFromDocumentsToIndex(String value) {
    documentsToIndex.remove(value);
    prefs.setStringList('ff_documentsToIndex', _documentsToIndex);
  }

  void removeAtIndexFromDocumentsToIndex(int index) {
    documentsToIndex.removeAt(index);
    prefs.setStringList('ff_documentsToIndex', _documentsToIndex);
  }

  void updateDocumentsToIndexAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    documentsToIndex[index] = updateFn(_documentsToIndex[index]);
    prefs.setStringList('ff_documentsToIndex', _documentsToIndex);
  }

  void insertAtIndexInDocumentsToIndex(int index, String value) {
    documentsToIndex.insert(index, value);
    prefs.setStringList('ff_documentsToIndex', _documentsToIndex);
  }

  List<VectorDocumentStruct> _allVectors = [];
  List<VectorDocumentStruct> get allVectors => _allVectors;
  set allVectors(List<VectorDocumentStruct> value) {
    _allVectors = value;
    prefs.setStringList(
      'ff_allVectors',
      value.map((x) => x.serialize()).toList(),
    );
  }

  void addToAllVectors(VectorDocumentStruct value) {
    allVectors.add(value);
    prefs.setStringList(
      'ff_allVectors',
      _allVectors.map((x) => x.serialize()).toList(),
    );
  }

  void removeFromAllVectors(VectorDocumentStruct value) {
    allVectors.remove(value);
    prefs.setStringList(
      'ff_allVectors',
      _allVectors.map((x) => x.serialize()).toList(),
    );
  }

  void removeAtIndexFromAllVectors(int index) {
    allVectors.removeAt(index);
    prefs.setStringList(
      'ff_allVectors',
      _allVectors.map((x) => x.serialize()).toList(),
    );
  }

  void updateAllVectorsAtIndex(
    int index,
    VectorDocumentStruct Function(VectorDocumentStruct) updateFn,
  ) {
    allVectors[index] = updateFn(_allVectors[index]);
    prefs.setStringList(
      'ff_allVectors',
      _allVectors.map((x) => x.serialize()).toList(),
    );
  }

  void insertAtIndexInAllVectors(int index, VectorDocumentStruct value) {
    allVectors.insert(index, value);
    prefs.setStringList(
      'ff_allVectors',
      _allVectors.map((x) => x.serialize()).toList(),
    );
  }
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
