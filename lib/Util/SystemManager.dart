import 'package:flutter/material.dart';

//TODO: In den ganzen Abfragen etc. sollten die Enums verwendet werden
/// Algorithmustypen
enum AlgorithmType { kMeans, decisionTree }

/// Operationsmodus
enum OperatingMode { local, server }

/// Diese Klasse soll dabei helfen zu tracken:
///   1. in welchem Operationsmodus man sich befindet (Server oder Lokal)
///   2. welcher Algorithmus ausgeführt werden soll
class SystemManager with ChangeNotifier {
  /// Der Algorithmustyp, welcher ausgeführt werden soll
  int _algorithmType =
      0; //TODO: Hier muss der OperatingMode enum verwendet werden

  /// Der Operationsmodus
  bool _isLocal =
      false; //TODO: Hier muss das AlgorithmType enum verwendet werden

  int get algorithmType => _algorithmType;

  bool get operatingMode => _isLocal;

  SystemManager(this._isLocal, this._algorithmType);

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
}
