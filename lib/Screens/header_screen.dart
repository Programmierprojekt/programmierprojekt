import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:programmierprojekt/Custom/custom_widgets.dart';
import 'package:programmierprojekt/Custom/data_point_model.dart';
import 'package:programmierprojekt/Custom/decision_tree_model.dart';
import 'package:programmierprojekt/Util/constants.dart';
import 'package:programmierprojekt/Util/system_manager.dart';
import 'package:programmierprojekt/api/backend_service.dart';

/// Der HeaderScreen zeigt die allgemeinen Optionen und Darstellungen an.
/// Damit sind die Optionen gemeint, die für jeden Algorithmus eingesetzt werden
/// bzw. die allgemein genutzt werden können
class HeaderScreen extends StatefulWidget {
  final SystemManager manager;
  final DataPoints dataPoints;
  final DecisionTreeModel dtModel;

  const HeaderScreen(
      {required this.manager,
      required this.dataPoints,
      required this.dtModel,
      Key? key})
      : super(key: key);

  @override
  State<HeaderScreen> createState() => _HeaderScreenState();
}

class _HeaderScreenState extends State<HeaderScreen> {
  SystemManager? manager;
  DataPoints? dataPoints;
  DecisionTreeModel? dtModel;
  late PlatformFile file;
  bool importedFile = false;

  @override
  void initState() {
    super.initState();
    manager = widget.manager;
    dataPoints = widget.dataPoints;
    dtModel = widget.dtModel;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Datenimport
          Expanded(
            child: CustomWidgets.customListTile(
                subtitle: const SizedBox(),
                title: const Text(Constants.BTN_IMPORT),
                onTap: importData,
                backgroundColor: Colors.orange.shade700),
          ),
          //Algorithmesauswahl
          Expanded(
            child: CustomWidgets.customListTile(
                title: const Text(Constants.BTN_CHOOSE_ALGORITHM),
                subtitle: Text(
                    manager!.algorithmType == 0 ? "KMeans" : "Decision Tree"),
                onTap: displayAlgorithmDialog,
                backgroundColor: Colors.blue.shade700),
          ),
          //Operationsmodus wechseln
          Expanded(
            child: CustomWidgets.customListTile(
              title: const Text(Constants.BTN_CHANGE_MODE),
              subtitle: Text(
                  "Ausführungsmodus: ${manager!.operatingMode == false ? Constants.OPERATING_MODE_SERVER : Constants.OPERATING_MODE_LOCAL}"),
              onTap: _changeOperatingMode,
              backgroundColor: Colors.indigo,
            ),
          ),
          Expanded(
            child: CustomWidgets.customListTile(
                subtitle: const SizedBox(),
                backgroundColor: Colors.green.shade700,
                title: const Text(Constants.BTN_CALCULATE),
                onTap: () {
                  if (dataPoints!.points.isNotEmpty) {
                    if (manager!.operatingMode == false) {
                      performClustering(file,
                          kCluster: widget.manager.kClusterController,
                          distanceMetric: widget.manager.choosenDistanceMetric,
                          clusterDetermination:
                              widget.manager.choosenClusterDetermination);
                    }
                  } else {
                    noFileSelectedDialog();
                  }
                  if (importedFile) {
                    manager!.startLocalCalculation();
                  }
                  setState(() {});
                }),
          ),
        ],
      ),
    );
  }

  /// Verantwortlich für den Wechsel des Operationsmodus.
  /// Wird als Button-Klick-Funktion verwendet
  /// Öffnet einen Dialog für die Auswahl des Operationsmoduses
  void _changeOperatingMode() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(Constants.DLG_TITLE_CHANGE_OPERATING_MODE),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              child: const Text(Constants.OPERATING_MODE_SERVER),
              onPressed: () {
                manager!.changeOperatingMode(false);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(Constants.OPERATING_MODE_LOCAL),
              onPressed: () {
                manager!.changeOperatingMode(true);
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
    setState(() {});
  }

  /// Zuständig für den import von Daten.
  /// Öffnet einen FilePicker und liest die Daten aus der ausgewählten Datei aus
  /// Außerdem wird das gelesene csv convertiert und die Datenpunkte hinzugefügt
  void importData() async {
    if (dataPoints!.points.isNotEmpty) {
      dataPoints!
          .clearAllPoints(); //Alle Datenpunkte löschen, wenn neue Datei importiert wird
      importedFile = false;
    }
    String csvDelimiter = await displayDelimiterDialog();
    if (csvDelimiter != ";" || csvDelimiter != ",") {
      importedFile = false;
      await _displayInfoDialogOnAbortedFilePicking();
      return;
    }

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );
    if (result != null) {
      file = result.files.first;
      //Dateigröße überprüfen
      if (file.size >= Constants.MAX_FILE_SIZE) {
        displayFileTooBigDialog();
        return;
      }

      final decodedData = utf8.decode(file.bytes as List<int>);
      List<List<dynamic>> data = const CsvToListConverter()
          .convert(decodedData, fieldDelimiter: csvDelimiter);
      data.removeAt(0); //Überschriftzeile entfernen
      for (var e in data) {
        if (manager!.algorithmType == 0) {
          double? first =
              double.tryParse(e.first.toString().replaceAll(",", "."));
          double? last =
              double.tryParse(e.last.toString().replaceAll(",", "."));
          if (first != null && last != null) {
            dataPoints!.add(DataPointModel(x: first, y: last));
          }
        } else if (manager!.algorithmType == 1) {
          dtModel!.add(e.toString());
        }
      }
      importedFile = true;
    } else {
      importedFile = false;
      await _displayInfoDialogOnAbortedFilePicking();
    }
    setState(() {});
  }

  /// Infodialog, weil Datei zu groß ist zum importieren
  void displayFileTooBigDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(Constants.INFORMATION),
        content: const Text(
            "Die ausgewählte Datei ist zu groß!\nDie Dateigröße ist auf 3 mb beschränkt."),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(Constants.OK_TEXT))
        ],
      ),
    );
  }

  /// Dialog zur Auswahl des String delimiters
  Future<String> displayDelimiterDialog() async {
    String delim = ",";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(Constants.DLG_TITLE_DELIM),
        content: Row(
          children: [
            TextButton(
              child: const Text(
                ",",
                style: TextStyle(
                    backgroundColor: Colors.black, color: Colors.deepOrange),
              ),
              onPressed: () {
                delim = ",";
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(";",
                  style: TextStyle(
                      backgroundColor: Colors.black, color: Colors.deepOrange)),
              onPressed: () {
                delim = ";";
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
    return delim;
  }

  /// Informationsdialog, falls der Nutzer den FilePicker schließt
  Future _displayInfoDialogOnAbortedFilePicking() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(Constants.DLG_TITLE_IMPORT_ABORT),
        content: const Text("Es wurde keine Datei zum importieren ausgewählt!"
            " Daten können durch den Dateiimport bezogen werden"
            " oder bei KMeans manuell hinzugefügt werden."),
        actions: [
          TextButton(
            child: const Text(Constants.OK_TEXT),
            onPressed: () {
              if (context.mounted) Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  /// Dialog für das Wechseln des einzusetzenden Algorithmuses
  void displayAlgorithmDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(Constants.BTN_CHOOSE_ALGORITHM),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
                onPressed: () => chooseAlgorithm(0, context),
                child: const Text("KMeans")),
            const SizedBox(
              width: 8,
            ),
            TextButton(
              onPressed: () => chooseAlgorithm(1, context),
              child: const Text("Decision Tree"),
            ),
          ],
        ),
      ),
    );
    setState(() {});
  }

  /// Buttonklick-Funktion beim wechseln des Operationsmoduses
  void chooseAlgorithm(int pressedAlgo, context) {
    manager!.changeAlgorithmType(pressedAlgo);
    Navigator.of(context).pop();
  }

  /// Dialog um den nutzer mitzuteilen, dass noch keine Datei ausgewählt worden ist
  void noFileSelectedDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(Constants.INFORMATION),
        content: const Text("Es wurde bisher noch keine Datei importiert!"),
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
