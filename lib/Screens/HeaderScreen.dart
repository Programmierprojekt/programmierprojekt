import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:programmierprojekt/Custom/CustomWidgets.dart';
import 'package:programmierprojekt/Custom/DataPointModel.dart';
import 'package:programmierprojekt/Util/Constants.dart';
import 'package:programmierprojekt/Util/SystemManager.dart';

/// Der HeaderScreen zeigt die allgemeinen Optionen und Darstellungen an.
/// Damit sind die Optionen gemeint, die für jeden Algorithmus eingesetzt werden
/// bzw. die allgemein genutzt werden können
class HeaderScreen extends StatefulWidget {
  final SystemManager manager;
  final DataPoints dataPoints;

  const HeaderScreen(
      {required this.manager, required this.dataPoints, Key? key})
      : super(key: key);

  @override
  State<HeaderScreen> createState() => _HeaderScreenState();
}

class _HeaderScreenState extends State<HeaderScreen> {
  SystemManager? manager;
  DataPoints? dataPoints;

  @override
  void initState() {
    super.initState();
    manager = widget.manager;
    dataPoints = widget.dataPoints;
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
            child: CustomWidgets.CustomListTile(
                subtitle: const SizedBox(),
                title: const Text(Constants.BTN_IMPORT),
                onTap: importData,
                backgroundColor: Colors.orange.shade700),
          ),
          //Algorithmesauswahl
          Expanded(
            child: CustomWidgets.CustomListTile(
                title: const Text(Constants.BTN_CHOOSE_ALGORITHM),
                subtitle: Text(
                    manager!.algorithmType == 0 ? "KMeans" : "Decision Tree"),
                onTap: displayAlgorithmDialog,
                backgroundColor: Colors.blue.shade700),
          ),
          //TODO: Wenn Operationsmodus="Server" dann mit Backend live kommunizieren für echtzeit-datenverarbeitung
          //TODO: Wenn Operationsmodus="Lokal" dann muss man den Berechnenbutton drücken zum Clustern
          //TODO: Zu beachten ist, dass die Vorschau der vorhandenen Datenpunkten in Echtzeit geschehen soll
          //Operationsmodus wechseln
          Expanded(
            child: CustomWidgets.CustomListTile(
              title: const Text("Modus ändern"),
              subtitle: Text(
                  "Ausführungsmodus: ${manager!.operatingMode == false ? Constants.OPERATING_MODE_SERVER : Constants.OPERATING_MODE_LOCAL}"),
              onTap: _changeOperatingMode,
              backgroundColor: Colors.indigo,
            ),
          ),
          /*
            Berechnungsbutton ist nur sichtbar, wenn man sich im Modus "Lokal" befindet!
            Dies dient zur Ressourcenschonung des Rechners.
            Beim Modus "Server" wird dieser Button ausgeblendet
           */
          Visibility(
            visible: manager!.operatingMode,
            child: Expanded(
              child: CustomWidgets.CustomListTile(
                  subtitle: const SizedBox(),
                  backgroundColor: Colors.green.shade700,
                  title: const Text(Constants.BTN_CALCULATE),
                  onTap: () {}),
            ),
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

  //TODO: Überprüfen inwiefern DecisionTree-Daten importiert werden sollen
  /// Zuständig für den import von Daten.
  /// Öffnet einen FilePicker und liest die Daten aus der ausgewählten Datei aus
  /// Außerdem wird das gelesene csv convertiert und die Datenpunkte hinzugefügt
  void importData() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      final decodedData = utf8.decode(file.bytes as List<int>);
      List<List<dynamic>> data =
          const CsvToListConverter().convert(decodedData, fieldDelimiter: ";");
      data.removeAt(0);
      for (var e in data) {
        if (double.tryParse(e.first.toString().replaceAll(",", ".")) != null &&
            double.tryParse(e.last.toString().replaceAll(",", ".")) != null) {
          dataPoints!.add(DataPointModel(
              x: double.parse(e.first.toString().replaceAll(',', '.')),
              y: double.parse(e.last.toString().replaceAll(',', '.'))));
        }
      }
      setState(() {});
    } else {
      await _displayInfoDialog();
    }
  }

  /// Informationsdialog, falls der Nutzer den FilePicker schließt
  Future _displayInfoDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(Constants.DLG_TITLE_IMPORT_ABORT),
        content: const Text("Es wurde keine Datei zum importieren ausgewählt!"
            " Daten können durch den Dateiimport bezogen werden"
            " oder manuell hinzugefügt werden."),
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
}
