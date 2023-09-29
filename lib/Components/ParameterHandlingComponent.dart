import 'package:flutter/material.dart';
import 'package:programmierprojekt/Custom/DataPointModel.dart';
import 'package:programmierprojekt/Util/SystemManager.dart';

class ParameterHandlingComponent extends StatefulWidget {
  final SystemManager manager;
  final DataPoints dataPoints;

  const ParameterHandlingComponent(
      {required this.manager, required this.dataPoints, Key? key})
      : super(key: key);

  @override
  State<ParameterHandlingComponent> createState() =>
      _ParameterHandlingComponentState();
}

class _ParameterHandlingComponentState
    extends State<ParameterHandlingComponent> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [],
    );
  }
}
