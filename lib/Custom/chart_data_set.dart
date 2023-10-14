import 'package:flutter/material.dart';
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
  InputDataPoints points;

  Cluster({
    required this.clusterNr,
    required this.centroid,
    required this.points,
  });

  Color getClusterColor() {
    final hue = (clusterNr / 50) * 360;
    return HSVColor.fromAHSV(1.0, hue, 1.0, 1.0).toColor();
  }
}
