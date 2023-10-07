import 'package:programmierprojekt/Custom/data_point_model.dart';

class ChartDataSet {
  List<Cluster> clusters;
  String xLabel;
  String yLabel;

  ChartDataSet({
    required this.clusters,
    required this.xLabel,
    required this.yLabel,
  });
}

class Cluster {
  int clusterNr;
  DataPointModel centroid;
  DataPoints points;

  Cluster({
    required this.clusterNr,
    required this.centroid,
    required this.points,
  });
}
