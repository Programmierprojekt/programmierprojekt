import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:programmierprojekt/Custom/CustomWidgets.dart';
import 'package:programmierprojekt/Custom/DataPointModel.dart';

class InputScreen extends StatefulWidget {
  final DataPoints dataPoints;

  const InputScreen({required this.dataPoints, Key? key}) : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  //Das sind Testdatenpunkte @cleanup
  List<DataPointModel> tiles = [
    DataPointModel(x: 1, y: 2),
    DataPointModel(x: 2, y: 3),
    DataPointModel(x: 1, y: 3),
    DataPointModel(x: 3, y: 1),
    DataPointModel(x: 2, y: 2),
    DataPointModel(x: 4, y: 15),
  ];
  DataPoints? dataPoints;
  TextEditingController xTextController = TextEditingController();
  TextEditingController yTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dataPoints = widget.dataPoints;
    dataPoints?.addAll(tiles);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomWidgets.CustomElevatedButton(
                    text: "Import", onPressed: importData),
              ),
              Expanded(
                child: CustomWidgets.CustomElevatedButton(
                    text: "Algorithmus", onPressed: () {}),
              ),
              Expanded(
                child: CustomWidgets.CustomElevatedButton(
                    buttonBackgroundColor: Colors.lightGreen,
                    text: "Berechnen",
                    onPressed: () {}),
              ),
            ],
          ),
        ),
        const Divider(thickness: 8),
        const SizedBox(
          height: 48,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 9,
              child: TextField(
                maxLines: 1,
                controller: xTextController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: "x-Wert",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 9,
              child: TextField(
                maxLines: 1,
                controller: yTextController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: "y-Wert",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              width: 32,
            ),
            ElevatedButton(
                onPressed: addItem,
                child: const Text(
                  "Hinzufügen",
                  style: TextStyle(),
                ))
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: ListenableBuilder(
            listenable: dataPoints!,
            builder: (context, child) => GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 4,
              ),
              itemCount: dataPoints!.points.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => ListTile(
                leading: IconButton(
                    onPressed: () => editItem(index),
                    icon: const Icon(Icons.edit)),
                trailing: IconButton(
                    onPressed: () => deleteItem(index),
                    icon: const Icon(Icons.delete_forever)),
                title: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(color: Colors.blueGrey)),
                        width: MediaQuery.of(context).size.width / 9,
                        child: Text(
                          dataPoints!.points[index].x.toString(),
                          maxLines: 1,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(color: Colors.blueGrey)),
                        width: MediaQuery.of(context).size.width / 9,
                        child: Text(
                          dataPoints!.points[index].y.toString(),
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    xTextController.dispose();
    yTextController.dispose();
    super.dispose();
  }

  void addItem() {
    dataPoints!.insert(
        0,
        DataPointModel(
            x: double.parse(xTextController.text),
            y: double.parse(yTextController.text)));
    xTextController.clear();
    yTextController.clear();
    setState(() {});
  }

  void deleteItem(index) async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Datenpunkt löschen"),
              content: Text(
                  "Willst du wirklich den Datenpunkt löschen?\n x = ${dataPoints!.points[index].x} | y = ${dataPoints!.points[index].y}"),
              actions: [
                TextButton(
                  child:
                      const Text("Nein", style: TextStyle(color: Colors.blue)),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: const Text("Ja", style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    dataPoints!.removeAt(index);
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
    setState(() {});
  }

  void editItem(index) async {
    TextEditingController xpController =
        TextEditingController(text: dataPoints!.points[index].x.toString());
    TextEditingController ypController =
        TextEditingController(text: dataPoints!.points[index].y.toString());

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Datenpunkt anpassen"),
        content: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 9,
              child: TextField(
                maxLines: 1,
                controller: xpController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: "x-Wert",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 9,
              child: TextField(
                maxLines: 1,
                controller: ypController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: "y-Wert",
                  border: OutlineInputBorder(),
                ),
              ),
            )
          ],
        ),
        actions: [
          TextButton(
            child: const Text("Datenpunkt löschen",
                style: TextStyle(
                    backgroundColor: Colors.red, color: Colors.white)),
            onPressed: () {
              dataPoints!.removeAt(index);
              Navigator.pop(context);
            },
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); //Popup schließen
            },
            child: const Text("Abbruch", style: TextStyle(color: Colors.red)),
          ),
          TextButton(
              onPressed: () {
                dataPoints!.modify(index, double.parse(xpController.text),
                    double.parse(ypController.text));
                Navigator.pop(context);
              },
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.blue),
              )),
        ],
      ),
    );
    xpController.dispose();
    ypController.dispose();
    setState(() {});
  }

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

  Future _displayInfoDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Import-Abbruch"),
        content: const Text("Es wurde keine Datei zum importieren ausgewählt!"
            "Daten können durch den Dateiimport bezogen werden"
            " oder manuell hinzugefügt werden."),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              if (context.mounted) Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
