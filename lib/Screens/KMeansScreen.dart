import 'package:flutter/material.dart';
import 'package:programmierprojekt/Components/DataHandlingComponent.dart';
import 'package:programmierprojekt/Components/ParameterHandlingComponent.dart';
import 'package:programmierprojekt/Custom/DataPointModel.dart';
import 'package:programmierprojekt/Util/SystemManager.dart';

class KMeansScreen extends StatefulWidget {
  final DataPoints dataPoints;
  final SystemManager manager;

  const KMeansScreen(
      {required this.manager, required this.dataPoints, Key? key})
      : super(key: key);

  @override
  State<KMeansScreen> createState() => _KMeansScreenState();
}

class _KMeansScreenState extends State<KMeansScreen> {
  DataPoints? dataPoints;
  SystemManager? manager;

  @override
  void initState() {
    super.initState();
    manager = widget.manager;
    dataPoints = widget.dataPoints;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child:
              DataHandlingComponent(manager: manager!, dataPoints: dataPoints!),
        ),
        Expanded(
          child: ParameterHandlingComponent(
              manager: manager!, dataPoints: dataPoints!),
        )
      ],
    );
  }
}
