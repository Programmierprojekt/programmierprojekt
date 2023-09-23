import 'package:kmeans/kmeans.dart';
import 'package:programmierprojekt/Custom/DataPointModel.dart';

/// Anwenden der Clustering-Algorithmen lokal
class AlgorithmHelper {
  /// Wandelt DataPointModel so um, dass diese verwendet werden kann für kmeans
  List<List<double>> _convertDataPointListToKMeansList(
      List<DataPointModel> dpl) {
    List<List<double>> data = [[]];
    dpl.map((e) => data.add(e.toKMeansList()));
    return data;
  }

  /// Führt KMeans lokal aus.
  /// dataPoints:    Die Datenpunkte. Muss konvertiert werden!
  /// searchBest:    Suche nach bestmöglichen Clustern?
  ///    true:         minK und maxK angeben
  ///    false:        kCount angeben
  ///
  /// kCount:        Anzahl der K, wenn searchBest false ist!
  /// minK:          Für die Suche nach den besten K
  /// maxK:          Für die Suche nach den besten K
  Clusters kmeans(List<DataPointModel> dataPoints,
      {bool searchBest = false, int kCount = 1, int minK = 3, int maxK = 10}) {
    var convertedData = _convertDataPointListToKMeansList(dataPoints);
    var kmeans = KMeans(convertedData);
    return searchBest
        ? kmeans.bestFit(minK: minK, maxK: maxK)
        : kmeans.fit(kCount);
  }
}
