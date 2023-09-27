import 'package:flutter/material.dart';
import 'package:programmierprojekt/Custom/DataPointModel.dart';
import 'package:programmierprojekt/Screens/InputScreen.dart';
import 'package:programmierprojekt/Screens/OutputScreen.dart';
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
      title: "SmartClassificator",
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
        actions: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ListTile(
              title: const Text("Modus ändern"),
              subtitle: Text(
                  "Ausführungsmodus: ${manager.operatingMode == false ? Constants.OPERATING_MODE_SERVER : Constants.OPERATING_MODE_LOCAL}"),
              onTap: _changeOperatingMode,
              tileColor: Colors.indigo,
            ),
          )
        ],
      ),
      body: IndexedStack(
        index: _bottomNavigationIndex,
        children: [
          InputScreen(dataPoints: dataPoints, manager: manager),
          OutputScreen(dataPoints: dataPoints, manager: manager),
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

  void _changeOperatingMode() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(Constants.DLG_TITLE_CHANGE_OPERATING_MODE),
        content: Row(
          children: [
            TextButton(
              child: const Text(Constants.OPERATING_MODE_SERVER),
              onPressed: () {
                manager.changeOperatingMode(false);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(Constants.OPERATING_MODE_LOCAL),
              onPressed: () {
                manager.changeOperatingMode(true);
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
    setState(() {});
  }
}
