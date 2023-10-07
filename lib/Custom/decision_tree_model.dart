import 'package:flutter/material.dart';
import 'package:ml_dataframe/src/data_frame/data_frame.dart';

class DecisionTreeModel extends ChangeNotifier {
  List<String> trainingData = [];
  DataFrame dataFrame = DataFrame([]);

  DecisionTreeModel(this.trainingData);

  void add(String d) {
    trainingData.add(d);
    notifyListeners();
  }

  void removeAt(int i) {
    trainingData.removeAt(i);
    notifyListeners();
  }

  void setFrame(DataFrame newFrame) {
    dataFrame = newFrame;
    notifyListeners();
  }
}
