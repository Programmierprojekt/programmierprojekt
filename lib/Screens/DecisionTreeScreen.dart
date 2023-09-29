import 'package:flutter/material.dart';
import 'package:programmierprojekt/Util/SystemManager.dart';

class DecisionTreeScreen extends StatefulWidget {
  final SystemManager manager;

  const DecisionTreeScreen({required this.manager, Key? key}) : super(key: key);

  @override
  State<DecisionTreeScreen> createState() => _DecisionTreeScreenState();
}

class _DecisionTreeScreenState extends State<DecisionTreeScreen> {
  SystemManager? manager;

  @override
  void initState() {
    super.initState();
    manager = widget.manager;
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
