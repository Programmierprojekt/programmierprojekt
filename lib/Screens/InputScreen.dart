import 'package:flutter/material.dart';

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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          TextButton(child: const Text("Import"), onPressed: (){},),
          TextButton(child: const Text("Algorithmus"), onPressed: (){},),
          TextButton(child: const Text("Export"), onPressed: (){},),
        ],),
        const SizedBox(height: 10,),
        ListView.builder(
          itemCount: tiles.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => const ListTile(
            trailing: TextField(maxLines: 1,),
            title: TextField(maxLines: 1,),
            leading: TextField(maxLines: 1,),
          ),)
      ],
    );
  }
}
