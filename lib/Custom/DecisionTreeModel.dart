

import 'package:flutter/material.dart';

class DecisionTreeModel extends ChangeNotifier {
  List<String> trainingData = [];

  DecisionTreeModel(this.trainingData);

  void add(String d) {
    trainingData.add(d);
    notifyListeners();
  }

  void removeAt(int i) {
    trainingData.removeAt(i);
    notifyListeners();
  }
}