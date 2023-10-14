import 'package:flutter/material.dart';
import 'package:programmierprojekt/Components/parameter_handling_component.dart';
import 'package:programmierprojekt/Custom/data_point_model.dart';
import 'package:programmierprojekt/Util/system_manager.dart';

class KMeansScreen extends StatefulWidget {
  final InputDataPoints dataPoints;
  final SystemManager manager;

  const KMeansScreen(
      {required this.manager, required this.dataPoints, Key? key})
      : super(key: key);

  @override
  State<KMeansScreen> createState() => _KMeansScreenState();
}

class _KMeansScreenState extends State<KMeansScreen> {
  InputDataPoints? dataPoints;
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
        Expanded(
          child: ParameterHandlingComponent(
              manager: manager!, dataPoints: dataPoints!),
        )
      ],
    );
  }
}
