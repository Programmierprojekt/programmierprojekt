
import 'package:programmierprojekt/Custom/data_point_model.dart';
import 'dart:math';

bool doubleEquals(double x, double y, double delta) {
  return delta < (x - y).abs();
}

List<List<double>> calcBoundaries(DataPoints? dataPoints) {
  List<List<double>> boundaries = [];

  for(int i = 0; i < dataPoints!.points[0].coords.length; i++) {
    boundaries.add(<double>[0.0, 0.0]);
  }

  for(int i = 0; i < dataPoints.points.length; i++) {
    for(int j = 0; j < dataPoints.points[i].coords.length; j++) {
      if(boundaries[j][0] > dataPoints.points[i].coords[j]) {
        boundaries[j][0] = dataPoints.points[i].coords[j];
      }

      if(boundaries[j][1] < dataPoints.points[i].coords[j]) {
        boundaries[j][1] = dataPoints.points[i].coords[j];
      }
    }
  }

  return boundaries;
}

DataPoints kmeans(DataPoints? dataPoints, int kCluster, List<List<double>> boundaries) {
  List<DataPointModel> l = [];

  for(int i = 0; i < dataPoints!.points.length; i++) {
    l.add(DataPointModel(dataPoints.points[i].clusterNumber, <double>[...dataPoints.points[i].coords]));
  }

  DataPoints output = DataPoints(l);
  int dims = dataPoints.points[0].coords.length;

  var rand = Random();

  for(int i = 0; i < kCluster; i++) {
    List<double> centCoords = [];
    for(int j = 0; j < dims; j++) {
      centCoords.add(boundaries[j][0] + rand.nextDouble() * (boundaries[j][1] - boundaries[j][0]));
    }

    output.centroids.add(DataPointModel(i + 1, centCoords));
  }

  int c = 0;
  while(c < 50) {
    for(int i = 0; i < output.points.length; i++) {
      double? minDistance;
      int k = 0;

      for(int j = 0; j < output.centroids.length; j++) {
        double distance = euclideanDistance(output.points[i].coords, output.centroids[j].coords);

        if(minDistance == null || distance < minDistance) {
          minDistance = distance;
          k = output.centroids[j].clusterNumber;
        }
      }

      output.points[i].clusterNumber = k;
    }

    for(int i = 0; i < output.centroids.length; i++) {
      List<double> means = List<double>.filled(dims, 0.0);
      int numPoints = 0;

      for(int j = 0; j < output.points.length; j++) {
        if(output.centroids[i].clusterNumber == output.points[j].clusterNumber) {
          numPoints++;

          for(int l = 0; l < output.points[j].coords.length; l++) {
            means[l] += output.points[j].coords[l];
          }
        }
      }

      if(numPoints > 0) {
        for(int j = 0; j < dims; j++) {
          output.centroids[i].coords[j] = means[j] / numPoints;
        }
      }
    }

    c++;
  }

  return output;
}

DataPoints localKmeans(DataPoints? dataPoints, { int kCluster = 0 }) {
  var boundaries = calcBoundaries(dataPoints);

  if(kCluster == 0) {
    List<double> wcsses = [];

    kCluster = 2;

    // Elbow method
    for(int l = 1; l <= 15; l++) {
      DataPoints dp = kmeans(dataPoints, l, boundaries);

      double wcss = 0.0;

      for(int i = 0; i < dp.points.length; i++) {
        for(int j = 0; j < dp.centroids.length; j++) {
          wcss += pow(euclideanDistance(dp.points[i].coords, dp.centroids[j].coords), 2).toDouble();
        }
      }

      wcsses.add(wcss);
    }

    for(int i = wcsses.length - 2; i >= 0; i--) {
      if((wcsses[i + 1] - wcsses[i]).abs() < 100) {
        kCluster = i;
        break;
      }
    }

    DataPoints output = kmeans(dataPoints, kCluster, boundaries);
    return output;
  }
  else {
    DataPoints output = kmeans(dataPoints, kCluster, boundaries);
    return output;
  }
}

double euclideanDistance(List<double> p1, List<double> p2) {
  double sum = 0.0;

  for(int i = 0; i < p1.length; i++) {
    sum += pow((p1[i] - p2[i]), 2);
  }

  return sqrt(sum);
}
