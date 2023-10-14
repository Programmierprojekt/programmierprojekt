import 'package:flutter/material.dart';
import 'package:programmierprojekt/Custom/data_point_model.dart';
import 'package:programmierprojekt/Pages/input_page.dart';
import 'package:programmierprojekt/Pages/output_page.dart';
import 'package:programmierprojekt/Util/constants.dart';
import 'package:programmierprojekt/Util/system_manager.dart';

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
  DataPoints inputDataPoints = DataPoints([]);
  DataPoints outputDataPoints = DataPoints([]);
  SystemManager manager = SystemManager(true, 0, 0, 0, 0, 0, false);

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
              inputDataPoints: inputDataPoints,
              outputDataPoints: outputDataPoints,
              manager: manager,
            ),
            OutputPage(
              inputDataPoints: inputDataPoints,
              outputDataPoints: outputDataPoints,
              manager: manager
            ),
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
