import 'package:flutter/material.dart';
import 'package:programmierprojekt/Custom/Custom.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  List tiles = [];

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
                  text: "Export", onPressed: () {}),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        ListView.builder(
          itemCount: tiles.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => const ListTile(
            trailing: TextField(
              maxLines: 1,
            ),
            title: TextField(
              maxLines: 1,
            ),
            leading: TextField(
              maxLines: 1,
            ),
          ),
        )
      ],
    );
  }
}
