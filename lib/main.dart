import 'package:flutter/material.dart';
import 'package:programmierprojekt/Custom/DataPointModel.dart';
import 'package:programmierprojekt/Custom/DecisionTreeModel.dart';
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
  DataPoints dataPoints = DataPoints([]);
  SystemManager manager = SystemManager(true, 0, 0);
  DecisionTreeModel dtModel = DecisionTreeModel([]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SmartClassificator"),
      ),
      body: ListenableBuilder(
        listenable: manager,
        builder: (context, child) => IndexedStack(
          index: manager.bottomNavigationIndex,
          children: [
            InputPage(
                dataPoints: dataPoints, manager: manager, dtModel: dtModel),
            OutputPage(
                dataPoints: dataPoints, manager: manager, dtModel: dtModel),
          ],
        ),
      ),
      bottomNavigationBar: ListenableBuilder(
        listenable: manager,
        builder: (context, child) => BottomNavigationBar(
          selectedItemColor: Colors.blueAccent,
          onTap: _onNavigationItemClicked,
          currentIndex: manager.bottomNavigationIndex,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.input), label: "Eingabe"),
            BottomNavigationBarItem(icon: Icon(Icons.output), label: "Ausgabe"),
          ],
        ),
      ),
    );
  }

  void _onNavigationItemClicked(int index) {
    manager.changeBottomNavigationIndex(index);
    setState(() {});
  }
}
