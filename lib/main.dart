import 'package:flutter/material.dart';
import 'package:programmierprojekt/Custom/DataPointModel.dart';
import 'package:programmierprojekt/Pages/InputPage.dart';
import 'package:programmierprojekt/Pages/OutputPage.dart';
import 'package:programmierprojekt/Util/Constants.dart';
import 'package:programmierprojekt/Util/SystemManager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.APP_TITLE,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
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
  DataPoints dataPoints = DataPoints([]);
  SystemManager manager = SystemManager(true, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SmartClassificator"),
      ),
      body: IndexedStack(
        index: _bottomNavigationIndex,
        children: [
          InputPage(dataPoints: dataPoints, manager: manager),
          OutputPage(dataPoints: dataPoints, manager: manager),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blueAccent,
        onTap: _onNavigationItemClicked,
        currentIndex: _bottomNavigationIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.input), label: "Eingabe"),
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
