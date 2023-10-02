import 'package:flutter/material.dart';
import 'package:programmierprojekt/Custom/DataPointModel.dart';
import 'package:programmierprojekt/Screens/DecisionTreeScreen.dart';
import 'package:programmierprojekt/Screens/HeaderScreen.dart';
import 'package:programmierprojekt/Screens/KMeansScreen.dart';
import 'package:programmierprojekt/Util/SystemManager.dart';

class InputPage extends StatefulWidget {
  final DataPoints dataPoints;
  final SystemManager manager;

  const InputPage({required this.dataPoints, required this.manager, Key? key})
      : super(key: key);

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  //Das sind Testdatenpunkte @cleanup
  List<DataPointModel> tiles = [
    DataPointModel(x: 1, y: 2),
    DataPointModel(x: 2, y: 3),
    DataPointModel(x: 1, y: 3),
    DataPointModel(x: 3, y: 1),
    DataPointModel(x: 2, y: 2),
    DataPointModel(x: 4, y: 15),
  ];
  DataPoints? dataPoints;
  SystemManager? manager;

  @override
  void initState() {
    super.initState();
    dataPoints = widget.dataPoints;
    dataPoints?.addAll(tiles); //@cleanup, Debug-Daten
    manager = widget.manager;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: HeaderScreen(
                  manager: widget.manager, dataPoints: widget.dataPoints)),
          const Divider(thickness: 8),
          const SizedBox(
            height: 48,
          ),
          SingleChildScrollView(
            child: manager!.algorithmType == 0
                ? KMeansScreen(
                    manager: widget.manager, dataPoints: widget.dataPoints)
                : DecisionTreeScreen(manager: widget.manager),
          )
        ],
      ),
    );
  }
}