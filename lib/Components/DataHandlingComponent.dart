import 'package:flutter/material.dart';
import 'package:programmierprojekt/Custom/DataPointModel.dart';
import 'package:programmierprojekt/Util/Constants.dart';
import 'package:programmierprojekt/Util/SystemManager.dart';

class DataHandlingComponent extends StatefulWidget {
  final DataPoints dataPoints;
  final SystemManager manager;

  const DataHandlingComponent(
      {required this.manager, required this.dataPoints, Key? key})
      : super(key: key);

  @override
  State<DataHandlingComponent> createState() => _DataHandlingComponentState();
}

class _DataHandlingComponentState extends State<DataHandlingComponent> {
  DataPoints? dataPoints;
  SystemManager? manager;

  //Für die Dateneingabe
  TextEditingController xTextController = TextEditingController();
  TextEditingController yTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    manager = widget.manager;
    dataPoints = widget.dataPoints;
  }

  @override
  void dispose() {
    xTextController.dispose();
    yTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              //width: 128,
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
              //width: 128,
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
                ))
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        ListenableBuilder(
            listenable: dataPoints!,
            builder: (context, child) => ListView.builder(
                  shrinkWrap: true,
                  itemCount: dataPoints!.points.length,
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
                ))
      ],
    );
  }

  /// Fügt ein Datenpunkt hinzu --> Manuelle Dateneingabe
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

  /// Entfernt ein Datenpunkt
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

  /// Ein Datenpunkt bearbeiten wobei die neue Daten über ein Dialog eingegeben
  /// werden
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
}
