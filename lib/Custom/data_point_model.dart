import 'package:flutter/material.dart';

/// Diese Klasse ist zuständig für die Verwaltung von Datenpunkten.
/// Die Klasse ist Listenable
class DataPoints with ChangeNotifier {
  /// Die Datenpunkte als Liste
  final List<DataPointModel> _points;

  // ignore: prefer_final_fields
  List<DataPointModel> _centroids = [];

  /// Getter für die Datenpunkte
  List<DataPointModel> get points => _points;
  List<DataPointModel> get centroids => _centroids;

  /// Konstruktor
  DataPoints(this._points);

  /// Ändert die Werte eines Datenpunktes an einer bestimmmten Stelle
  void modify(index, List<double> coords) {
    points[index].coords = coords;
    notifyListeners();
  }

  /// Fügt einen Centroid ein
  void addCentroid(clusterNr, List<double> coords) {
    centroids.add(DataPointModel(clusterNr, coords));
    notifyListeners();
  }

  void clearCentroids() {
    centroids.clear();
    notifyListeners();
  }

  /// Fügt Datenpunkte aus einer anderen Liste hinzu
  void addAll(List<DataPointModel> data) {
    for (var d in data) {
      points.add(d);
    }
    notifyListeners();
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
  List<double> coords;
  int clusterNumber;

  DataPointModel(this.clusterNumber, this.coords);
}
