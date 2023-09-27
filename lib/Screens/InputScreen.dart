import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:programmierprojekt/Algorithms/AlgorithmHelper.dart';
import 'package:programmierprojekt/Custom/CustomWidgets.dart';
import 'package:programmierprojekt/Custom/DataPointModel.dart';
import 'package:programmierprojekt/Util/Constants.dart';

class InputScreen extends StatefulWidget {
  final DataPoints dataPoints;
  final Algorithm algorithm;

  const InputScreen(
      {required this.dataPoints, required this.algorithm, Key? key})
      : super(key: key);

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
  Algorithm? algo;
  TextEditingController xTextController = TextEditingController();
  TextEditingController yTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dataPoints = widget.dataPoints;
    dataPoints?.addAll(tiles); //@cleanup, Debug-Daten
    algo = widget.algorithm;
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
                child: CustomWidgets.CustomListTile(
                    subtitle: const SizedBox(),
                    title: const Text(Constants.BTN_IMPORT),
                    onTap: importData,
                    backgroundColor: Colors.orange.shade700),
              ),
              Expanded(
                child: CustomWidgets.CustomListTile(
                    title: const Text(Constants.BTN_CHOOSE_ALGORITHM),
                    subtitle:
                        Text(algo!.algorithm == 0 ? "KMeans" : "Decision Tree"),
                    onTap: displayAlgorithmDialog,
                    backgroundColor: Colors.blue.shade700),
              ),
              Expanded(
                child: CustomWidgets.CustomListTile(
                    subtitle: const SizedBox(),
                    backgroundColor: Colors.green.shade700,
                    title: const Text(Constants.BTN_CALCULATE),
                    onTap: () {}),
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
                  labelText: Constants.X_VALUE_TEXT,
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
                  labelText: Constants.Y_VALUE_TEXT,
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
                  Constants.BTN_ADD,
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
              title: const Text(Constants.DLG_TITLE_DEL_ITEMS),
              content: Text(
                  "Willst du wirklich den Datenpunkt löschen?\n x = ${dataPoints!.points[index].x} | y = ${dataPoints!.points[index].y}"),
              actions: [
                TextButton(
                  child: const Text(Constants.BTN_NO,
                      style: TextStyle(color: Colors.blue)),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: const Text(Constants.BTN_YES,
                      style: TextStyle(color: Colors.red)),
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
        title: const Text(Constants.DLG_TITLE_MODIFY_ITEM),
        content: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 9,
              child: TextField(
                maxLines: 1,
                controller: xpController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: Constants.X_VALUE_TEXT,
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
                controller: ypController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: Constants.Y_VALUE_TEXT,
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text(Constants.BTN_DELETE_ITEM,
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
            child: const Text(Constants.ABORT_TEXT,
                style: TextStyle(color: Colors.red)),
          ),
          TextButton(
              onPressed: () {
                dataPoints!.modify(index, double.parse(xpController.text),
                    double.parse(ypController.text));
                Navigator.pop(context);
              },
              child: const Text(
                Constants.OK_TEXT,
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

  void displayAlgorithmDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(Constants.BTN_CHOOSE_ALGORITHM),
        content: Row(
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

  void chooseAlgorithm(int pressedAlgo, context) {
    algo!.modify(pressedAlgo);
    Navigator.of(context).pop();
  }
}
