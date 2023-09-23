import 'package:flutter/material.dart';
import 'package:programmierprojekt/Custom/Custom.dart';
import 'package:programmierprojekt/Custom/DataPointModel.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  List<DataPointModel> tiles = [
    DataPointModel(x: 1, y: 2),
    DataPointModel(x: 2, y: 3),
    DataPointModel(x: 1, y: 3),
    DataPointModel(x: 3, y: 1),
    DataPointModel(x: 2, y: 2),
    DataPointModel(x: 4, y: 15),
  ];
  TextEditingController xTextController = TextEditingController();
  TextEditingController yTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomWidgets.CustomElevatedButton(
                  text: "Import", onPressed: () {}),
              CustomWidgets.CustomElevatedButton(
                  text: "Algorithmus", onPressed: () {}),
              CustomWidgets.CustomElevatedButton(
                  buttonBackgroundColor: Colors.lightGreen,
                  text: "Berechnen",
                  onPressed: () {}),
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
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 4,
            ),
            itemCount: tiles.length,
            shrinkWrap: true,
            itemBuilder: (context, index) => ListTile(
              leading: IconButton(
                  onPressed: () => editItem(index),
                  icon: const Icon(Icons.edit)),
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
                        tiles[index].x.toString(),
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
                        tiles[index].y.toString(),
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
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
    setState(() {
      tiles.insert(
          0,
          DataPointModel(
              x: double.parse(xTextController.text),
              y: double.parse(yTextController.text)));
      xTextController.clear();
      yTextController.clear();
    });
  }

  void editItem(index) async {
    TextEditingController xpController =
        TextEditingController(text: tiles[index].x.toString());
    TextEditingController ypController =
        TextEditingController(text: tiles[index].y.toString());

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
            onPressed: () {
              Navigator.pop(context); //Popup schließen
            },
            child: const Text("Abbruch", style: TextStyle(color: Colors.red)),
          ),
          TextButton(
              onPressed: () {
                tiles[index].x = double.parse(xpController.text);
                tiles[index].y = double.parse(ypController.text);
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
}
