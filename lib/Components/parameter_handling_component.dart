import 'package:flutter/material.dart';
import 'package:programmierprojekt/Custom/data_point_model.dart';
import 'package:programmierprojekt/Util/constants.dart';
import 'package:programmierprojekt/Util/system_manager.dart';

class ParameterHandlingComponent extends StatefulWidget {
  final SystemManager manager;
  final DataPoints inputDataPoints;

  const ParameterHandlingComponent(
      {required this.manager, required this.inputDataPoints, Key? key})
      : super(key: key);

  @override
  State<ParameterHandlingComponent> createState() =>
      _ParameterHandlingComponentState();
}

class _ParameterHandlingComponentState
    extends State<ParameterHandlingComponent> {
  int choosenDistanceMetric = 0;
  int choosenClusterDetermination = 0;
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
      children: widget.manager.operatingMode
          ? buildWidgetsForLocal()
          : buildWidgetsForServer(),
    );
  }

  List<Widget> buildWidgetsForLocal() => [
        ListTile(
          title: const Text(Constants.BTN_DISTANCE_METRIC),
          subtitle: Text(Constants.METRIC_CHOICES[choosenDistanceMetric]),
          tileColor: Colors.deepPurpleAccent.shade700,
          onTap: displayInfoDialogInLocalMode,
        ),
        ListTile(
          title: const Text(Constants.BTN_CLUSTER_DETERMINATION),
          subtitle: Text(Constants
              .CLUSTER_DETERMINATION_CHOICES[choosenClusterDetermination]),
          tileColor: kClusterController.text.isEmpty
              ? Colors.deepPurpleAccent.shade700
              : Colors.grey.shade700,
          enabled: kClusterController.text.isEmpty,
          onTap: displayInfoDialogInLocalMode,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 9,
          child: TextField(
            controller: kClusterController,
            onChanged: (value) {
              //TODO: @Adrian hier muss du den Wert von K-Cluster holen
              if ((int.tryParse(value) ?? 0) < 2 && value != "") {
                displayErrorDialogForKCluster();
                kClusterController.text = "";
              }
              setState(() {});
            },
            maxLines: 1,
            keyboardType: const TextInputType.numberWithOptions(),
            decoration: const InputDecoration(
              labelText: Constants.K_CLUSTER_TEXT,
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ];

  List<Widget> buildWidgetsForServer() => [
        ListTile(
          title: const Text(Constants.BTN_DISTANCE_METRIC),
          subtitle: Text(Constants.METRIC_CHOICES[choosenDistanceMetric]),
          onTap: chooseDistanceMetric,
          tileColor: Colors.teal.shade700,
        ),
        ListTile(
          title: const Text(Constants.BTN_CLUSTER_DETERMINATION),
          subtitle: Text(Constants
              .CLUSTER_DETERMINATION_CHOICES[choosenClusterDetermination]),
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
            onChanged: (value) {
              if ((int.tryParse(value) ?? 0) < 2 && value != "") {
                displayErrorDialogForKCluster();
                kClusterController.text = "";
              } else {
                widget.manager.callKCluster(int.tryParse(value) ?? 0);
              }
              setState(() {});
            },
            maxLines: 1,
            keyboardType: const TextInputType.numberWithOptions(),
            decoration: const InputDecoration(
              labelText: Constants.K_CLUSTER_TEXT,
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ];

  void chooseDistanceMetric() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(Constants.BTN_DISTANCE_METRIC),
        content: Row(
          children: [
            ElevatedButton(
              child: Text(Constants.METRIC_CHOICES[0]), //Euklidisch
              onPressed: () {
                choosenDistanceMetric = 0;
                widget.manager.callDistanceMetric(0);
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(
              width: 8,
            ),
            ElevatedButton(
              child: Text(Constants.METRIC_CHOICES[1]), //Manhattan
              onPressed: () {
                choosenDistanceMetric = 1;
                widget.manager.callDistanceMetric(1);
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(
              width: 8,
            ),
            ElevatedButton(
              child: Text(Constants.METRIC_CHOICES[2]), //Jaccards
              onPressed: () {
                choosenDistanceMetric = 2;
                widget.manager.callDistanceMetric(2);
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
        title: const Text(Constants.BTN_CLUSTER_DETERMINATION),
        content: Row(
          children: [
            ElevatedButton(
              child: Text(Constants.CLUSTER_DETERMINATION_CHOICES[0]),
              //Elbow
              onPressed: () {
                choosenClusterDetermination = 0;
                widget.manager.callClusterDetermination(0);
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(
              width: 8,
            ),
            ElevatedButton(
              child: Text(Constants.CLUSTER_DETERMINATION_CHOICES[1]),
              //Silhouette
              onPressed: () {
                choosenClusterDetermination = 1;
                widget.manager.callClusterDetermination(1);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
    setState(() {});
  }

  /// Zeigt eine Info im lokalen Modus an, wenn die Distanzmetrik oder
  /// Klusterbestimmung geändert werden soll.
  /// Diese Einstellungen sind im lokalen Modus eingeschränkt
  void displayInfoDialogInLocalMode() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(Constants.INFORMATION),
        content: const Column(
          children: [
            Text("Im Operationsmodus 'lokal', kann man nur die "
                "Euklidische Distanz und Elbow-Klusterbestimmung"
                "oder manuelle k eingabe durchführen."
                "Für mehr optionen,"
                " verwenden Sie den Operationsmodus 'Server'!"),
          ],
        ),
        actions: [
          TextButton(
            child: const Text(Constants.OK_TEXT),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }

  /// Zeigt eine Info an, wenn k-Cluster minimial Grenze nicht eingehalten wurde
  void displayErrorDialogForKCluster() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(Constants.INFORMATION),
        content: const Text("k-Cluster darf nur minimal 2 sein!"),
        actions: [
          TextButton(
            child: const Text(Constants.OK_TEXT),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
