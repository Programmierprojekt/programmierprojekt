import 'package:flutter/material.dart';

/// Diese Klasse ist zuständig für die Verwaltung von Datenpunkten.
/// Die Klasse ist Listenable
class DataPoints with ChangeNotifier {
  /// Die Datenpunkte als Liste
  List<DataPointModel> _points;

  /// Getter für die Datenpunkte
  List<DataPointModel> get points => _points;

  /// Konstruktor
  DataPoints(this._points);

  /// Ändert die Werte eines Datenpunktes an einer bestimmmten Stelle
  void modify(index, double x, double y) {
    points[index].x = x;
    points[index].y = y;
    notifyListeners();
  }

  /// Fügt Datenpunkte aus einer anderen Liste hinzu
  void addAll(List<DataPointModel> data) {
    for (var d in data) {
      points.add(d);
      notifyListeners();
    }
  }

  /// Füge ein neuen Datenpunkt an einer bestimmten Stelle hinzu
  void insert(position, DataPointModel point) {
    points.insert(position, point);
    notifyListeners();
  }

  /// Füge einen Datenpunkt am Ende der Liste hinzu
  void add(DataPointModel point) {
    points.add(point);
    notifyListeners();
  }

  /// Lösche einen Datenpunkt an einer bestimmten Stelle
  void removeAt(index) {
    points.removeAt(index);
    notifyListeners();
  }

  /// Löscht alle Datenpunkte
  void clearAllPoints() {
    points.clear();
    notifyListeners();
  }
}

/// Klasse für die Datenpunkte.
/// Beinhaltet die X- und Y-Werte eines Punktes.
class DataPointModel {
  ///X-Position
  double x;

  ///Y-Position
  double y;

  DataPointModel({required this.x, required this.y});

  /// Gibt eine Liste für KMeans zurück
  List<double> toKMeansList() => [x, y];
}
