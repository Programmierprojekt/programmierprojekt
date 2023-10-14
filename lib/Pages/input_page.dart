import 'package:flutter/material.dart';
import 'package:programmierprojekt/Custom/data_point_model.dart';
import 'package:programmierprojekt/Screens/decision_tree_screen.dart';
import 'package:programmierprojekt/Screens/header_screen.dart';
import 'package:programmierprojekt/Screens/kmeans_screen.dart';
import 'package:programmierprojekt/Util/system_manager.dart';

class InputPage extends StatefulWidget {
  final DataPoints inputDataPoints;
  final DataPoints outputDataPoints;
  final SystemManager manager;

  const InputPage({required this.inputDataPoints, required this.outputDataPoints, required this.manager, Key? key})
      : super(key: key);

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  DataPoints? inputDataPoints;
  DataPoints? outputDataPoints;
  SystemManager? manager;

  @override
  void initState() {
    super.initState();
    inputDataPoints = widget.inputDataPoints;
    outputDataPoints = widget.outputDataPoints;
    manager = widget.manager;
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
                inputDataPoints: widget.inputDataPoints,
                outputDataPoints: widget.outputDataPoints,
              )),
          const Divider(thickness: 8),
          const SizedBox(
            height: 48,
          ),
          SingleChildScrollView(
            child: manager!.algorithmType == 0
                ? KMeansScreen(
                    manager: widget.manager, inputDataPoints: widget.inputDataPoints)
                : DecisionTreeScreen(
                    manager: widget.manager,
                  ),
          )
        ],
      ),
    );
  }
}
