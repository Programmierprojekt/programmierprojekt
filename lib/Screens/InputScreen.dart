import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:programmierprojekt/Custom/Custom.dart';
import 'package:programmierprojekt/Custom/DataPointModel.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  List<DataPointModel> tiles = [];
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
        const Divider(),
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
        ),//https://shellshock.io/#K7P42NP
        const SizedBox(
          height: 10,
        ),
        //TODO: Hier findet ein WidgetOverflow statt, fixen!!
        ListView.builder(
          itemCount: tiles.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => ListTile(
            leading: IconButton(
                onPressed: () => editItem(index),
                icon: const Icon(Icons.edit)),
            title: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 9,
                  child: TextField(
                    controller: TextEditingController(
                        text: tiles[index].x.toString()),
                    maxLines: 1,
                    readOnly: true,
                    enabled: false,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: "x",
                      border: OutlineInputBorder(),

                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 9,
                  child: TextField(
                    maxLines: 1,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    enabled: false,
                    controller: TextEditingController(
                        text: tiles[index].y.toString()),
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: "y",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
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
      tiles.add(DataPointModel(
          x: double.parse(xTextController.text),
          y: double.parse(yTextController.text)));
      xTextController.clear();
      yTextController.clear();
    });
  }

  void editItem(index) {
    //TODO: Dialog anzeigen wo man die Werte ändern kann
  }
}
