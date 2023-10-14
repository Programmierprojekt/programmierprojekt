import 'package:flutter/material.dart';
import 'package:programmierprojekt/Components/parameter_handling_component.dart';
import 'package:programmierprojekt/Custom/data_point_model.dart';
import 'package:programmierprojekt/Util/system_manager.dart';

class KMeansScreen extends StatefulWidget {
  final DataPoints inputDataPoints;
  final SystemManager manager;

  const KMeansScreen(
      {required this.manager, required this.inputDataPoints, Key? key})
      : super(key: key);

  @override
  State<KMeansScreen> createState() => _KMeansScreenState();
}

class _KMeansScreenState extends State<KMeansScreen> {
  DataPoints? inputDataPoints;
  SystemManager? manager;

  @override
  void initState() {
    super.initState();
    manager = widget.manager;
    inputDataPoints = widget.inputDataPoints;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ParameterHandlingComponent(
              manager: manager!, inputDataPoints: inputDataPoints!),
        )
      ],
    );
  }
}
