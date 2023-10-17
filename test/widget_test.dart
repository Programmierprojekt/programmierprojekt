// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:programmierprojekt/Custom/data_point_model.dart';
import 'package:programmierprojekt/Util/system_manager.dart';

void main() {
  test("test if DataPoints receives values", () {
    DataPoints points = DataPoints([]);
    points.add(DataPointModel(0, [3.0, 4.0]));
    expect(points.points.length, 1);
    points.addAll([
      DataPointModel(1, [2.0, 7.0]),
      DataPointModel(2, [1.0, 6.0])
    ]);
    expect(points.points.length, 3);
  });

  test("test if manager parameters for algorithmtype receives value changes",
      () {
    SystemManager manager = SystemManager(true, 0, 0, 0, 0, 0, false);
    manager.changeAlgorithmType(1);
    expect(manager.algorithmType, 1);
    manager.changeOperatingMode(true);
    expect(manager.operatingMode, true);
    manager.callClusterDetermination(1);
    expect(manager.choosenClusterDetermination, 1);
  });
}
