import 'package:flutter/material.dart';
import 'package:programmierprojekt/Custom/data_point_model.dart';
import 'package:programmierprojekt/Custom/decision_tree_model.dart';
import 'package:programmierprojekt/Screens/decision_tree_screen.dart';
import 'package:programmierprojekt/Screens/header_screen.dart';
import 'package:programmierprojekt/Screens/kmeans_screen.dart';
import 'package:programmierprojekt/Util/system_manager.dart';

class InputPage extends StatefulWidget {
  final DataPoints dataPoints;
  final SystemManager manager;
  final DecisionTreeModel dtModel;

  const InputPage(
      {required this.dataPoints,
      required this.manager,
      required this.dtModel,
      Key? key})
      : super(key: key);

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  DataPoints? dataPoints;
  SystemManager? manager;
  DecisionTreeModel? dtModel;

  @override
  void initState() {
    super.initState();
    dataPoints = widget.dataPoints;
    manager = widget.manager;
    dtModel = widget.dtModel;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
              child: HeaderScreen(
                  manager: widget.manager,
                  dataPoints: widget.dataPoints,
                  dtModel: widget.dtModel)),
          const Divider(thickness: 8),
          const SizedBox(
            height: 48,
          ),
          SingleChildScrollView(
            child: manager!.algorithmType == 0
                ? KMeansScreen(
                    manager: widget.manager, dataPoints: widget.dataPoints)
                : DecisionTreeScreen(
                    manager: widget.manager, dtModel: widget.dtModel),
          )
        ],
      ),
    );
  }
}
