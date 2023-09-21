import 'package:flutter/material.dart';
import 'package:programmierprojekt/Screens/InputScreen.dart';
import 'package:programmierprojekt/Screens/OutputScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "SmartClassificator",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _bottomNavigationIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SmartClassificator"),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.dehaze))],
      ),
      body: IndexedStack(
        index: _bottomNavigationIndex,
        children: const [
          InputScreen(),
          OutputScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blueAccent,
        onTap: _onNavigationItemClicked,
        currentIndex: _bottomNavigationIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.input), label: "Eingabe"),
          BottomNavigationBarItem(icon: Icon(Icons.output), label: "Ausgabe"),
        ],
      ),
    );
  }

  void _onNavigationItemClicked(int index) {
    setState(() {
      _bottomNavigationIndex = index;
    });
  }
}
