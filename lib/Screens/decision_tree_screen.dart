import 'package:flutter/material.dart';
import 'package:programmierprojekt/Custom/decision_tree_model.dart';
import 'package:programmierprojekt/Util/system_manager.dart';

class DecisionTreeScreen extends StatefulWidget {
  final SystemManager manager;
  final DecisionTreeModel dtModel;

  const DecisionTreeScreen(
      {required this.manager, required this.dtModel, Key? key})
      : super(key: key);

  @override
  State<DecisionTreeScreen> createState() => _DecisionTreeScreenState();
}

class _DecisionTreeScreenState extends State<DecisionTreeScreen> {
  SystemManager? manager;
  DecisionTreeModel? dtModel;

  @override
  void initState() {
    super.initState();
    manager = widget.manager;
    dtModel = widget.dtModel;
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: dtModel!,
      builder: (context, child) => Center(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: dtModel!.trainingData.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(dtModel!.trainingData[index]),
            trailing: IconButton(
              onPressed: () {
                dtModel!.removeAt(index);
                setState(() {});
              },
              icon: const Icon(Icons.delete),
            ),
          ),
        ),
      ),
    );
  }
}
