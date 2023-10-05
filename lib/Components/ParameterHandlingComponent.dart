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
  int choosenDistanceMetric = 0;
  int choosenClusterDetermination = 0;
  final metricChoices = ["Euklidisch", "Manhattan", "Jacards"];
  final clusterDeterminationChoices = ["Elbow", "Silhouette"];
  TextEditingController kClusterController = TextEditingController();

  @override
  dispose() {
    kClusterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 4,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16),
      shrinkWrap: true,
      children: widget!.manager.operatingMode
          ? buildWidgetsForLocal()
          : buildWidgetsForServer(),
    );
  }

  List<Widget> buildWidgetsForLocal() => [
    SizedBox(
      width: MediaQuery.of(context).size.width / 9,
      child: TextField(
        controller: kClusterController,
        onChanged: (value) => setState(() {}),
        maxLines: 1,
        keyboardType: const TextInputType.numberWithOptions(),
        decoration: const InputDecoration(
          labelText: "kCluster",
          border: OutlineInputBorder(),
        ),
      ),
    ),
  ];

  List<Widget> buildWidgetsForServer() => [
        ListTile(
          title: const Text("Distanzmetrik"),
          subtitle: Text(metricChoices[choosenDistanceMetric]),
          onTap: chooseDistanceMetric,
          tileColor: Colors.teal.shade700,
        ),
        ListTile(
          title: const Text("Klusterbestimmung"),
          subtitle:
              Text(clusterDeterminationChoices[choosenClusterDetermination]),
          onTap: chooseClusterDetermination,
          tileColor: kClusterController.text.isEmpty
              ? Colors.teal.shade700
              : Colors.grey.shade700,
          enabled: kClusterController.text.isEmpty,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 9,
          //width: 128,
          child: TextField(
            controller: kClusterController,
            onChanged: (value) => setState(() {}),
            maxLines: 1,
            keyboardType: const TextInputType.numberWithOptions(),
            decoration: const InputDecoration(
              labelText: "kCluster",
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ];

  void chooseDistanceMetric() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Distanzmetrik"),
        content: Row(
          children: [
            ElevatedButton(
              child: const Text("Euklidisch"),
              onPressed: () {
                choosenDistanceMetric = 0;
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(
              width: 8,
            ),
            ElevatedButton(
              child: const Text("Manhattan"),
              onPressed: () {
                choosenDistanceMetric = 1;
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(
              width: 8,
            ),
            ElevatedButton(
              child: const Text("Jaccard"),
              onPressed: () {
                choosenDistanceMetric = 2;
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
    setState(() {});
  }

  void chooseClusterDetermination() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Klusterbestimmung"),
        content: Row(
          children: [
            ElevatedButton(
              child: const Text("Elbow"),
              onPressed: () {
                choosenClusterDetermination = 0;
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(
              width: 8,
            ),
            ElevatedButton(
              child: const Text("Silhouette"),
              onPressed: () {
                choosenClusterDetermination = 1;
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
    setState(() {});
  }
}
