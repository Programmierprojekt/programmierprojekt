import 'package:flutter/material.dart';
import 'package:programmierprojekt/Util/constants.dart';

//TODO: In den ganzen Abfragen etc. sollten die Enums verwendet werden
/// Algorithmustypen
enum AlgorithmType { kMeans, decisionTree }

/// Operationsmodus
enum OperatingMode { local, server }

/// Diese Klasse soll dabei helfen zu tracken:
///   1. in welchem Operationsmodus man sich befindet (Server oder Lokal)
///   2. welcher Algorithmus ausgeführt werden soll
class SystemManager with ChangeNotifier {

  String _cartOutput = "";
  String get cartOutput => _cartOutput;

  /// Der Algorithmustyp, welcher ausgeführt werden soll
  int _algorithmType =
      0; //TODO: Hier muss der OperatingMode enum verwendet werden

  /// Navigationsindex für die untere Leiste
  int _bottomNavigationIndex = 0;

  int get bottomNavigationIndex => _bottomNavigationIndex;

  bool _calculateFinished = false;
  bool get calculateFinished => _calculateFinished;

  /// Der Operationsmodus
  bool _isLocal =
      false; //TODO: Hier muss das AlgorithmType enum verwendet werden

  int get algorithmType => _algorithmType;

  bool get operatingMode => _isLocal;

  ///Parameter für die Verarbeitung von KMeans serverseitig
  int _distanceMetric = 0;

  int get choosenDistanceMetric => _distanceMetric;

  int _clusterDetermination = 0;

  int get choosenClusterDetermination => _clusterDetermination;

  int _kCluster = 0;

  int get kClusterController => _kCluster;

  String _basicUrl = "";
  String get choosenBasicUrl => _basicUrl;

  String _fileKmeansDimensionType = "";
  String get choosenfileKmeansDimensionType => _fileKmeansDimensionType;

  String _firstHeadFileName = "";
  String get choosenCsvDelimiter => _firstHeadFileName;

  SystemManager(
      this._isLocal,
      this._algorithmType,
      this._bottomNavigationIndex,
      this._clusterDetermination,
      this._distanceMetric,
      this._kCluster,
      this._calculateFinished);

  /// Algorithmustypen wechseln
  /// newVal ist der neue Wert
  ///       0 = KMeans
  ///       1 = Decision Tree
  void changeAlgorithmType(int newVal) {
    _algorithmType = newVal;
    notifyListeners();
  }

  /// Den Modus wechseln zwischen Lokal und Server Modus
  /// operatingMode:
  ///                 true    Lokal
  ///                 false   Server
  void changeOperatingMode(bool operatingMode) {
    _isLocal = operatingMode;
    notifyListeners();
  }

  void changeCartOutput(String json) {
    _cartOutput = json;
    notifyListeners();
  }

  /// Wechselt direkt zur Ausgabe
  void startLocalCalculation() {
    _bottomNavigationIndex = 1;
    notifyListeners();
  }

  /// Die Navigation ändern
  void changeBottomNavigationIndex(int index) {
    _bottomNavigationIndex = index;
    notifyListeners();
  }

  void callDistanceMetric(int newValue) {
    _distanceMetric = newValue;
    notifyListeners();
  }

  void callClusterDetermination(int newValue) {
    _clusterDetermination = newValue;
    notifyListeners();
  }

  void callKCluster(int newValue) {
    _kCluster = newValue;
    notifyListeners();
  }

  void setCalculateFinished(bool finished) {
    _calculateFinished = finished;
    notifyListeners();
  }

  void changeBasicUrl(String value) {
    _basicUrl = value;
    notifyListeners();
  }

  void changefileKmeansDimensionType(int value) {
    if (value == 2) {
      _fileKmeansDimensionType = Constants.SERVER_CALLS_KMEANS[0];
    } else if (value == 3) {
      _fileKmeansDimensionType = Constants.SERVER_CALLS_KMEANS[1];
    } else {
      _fileKmeansDimensionType = Constants.SERVER_CALLS_KMEANS[2];
    }
  }

  void changeFirstHeadFileName(String value) {
    _firstHeadFileName = value;
  }
}
