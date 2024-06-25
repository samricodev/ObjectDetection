import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:myapp/widgets/about.dart';
import 'package:myapp/widgets/objectList.dart';
import 'package:myapp/widgets/bar_chart_sample3.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Detección de Objetos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueGrey,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Object Detection Project'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<dynamic, dynamic>> _detectedObjects = [];
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    DatabaseReference starCountRef =
        FirebaseDatabase.instance.ref('detected_objects');
    starCountRef.onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      final List<Map<dynamic, dynamic>> objects = [];

      if (data != null) {
        final mapData = data as Map<dynamic, dynamic>;
        mapData.forEach((key, value) {
          Map<dynamic, dynamic> objectData = value as Map<dynamic, dynamic>;
          // Añadir el timestamp como campo en el mapa del objeto
          objectData['key'] = key; // opcional: almacenar la clave original
          objects.add(objectData);
        });

        // Ordenar objetos por fecha (timestamp)
        objects.sort((a, b) => DateTime.parse(b['timestamp'])
            .compareTo(DateTime.parse(a['timestamp'])));
      }

      setState(() {
        _detectedObjects = objects;
      });
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: Text(widget.title),
      ),
      body: Center(
        child: _selectedIndex == 0
            ? const BarChartSample3()
            : _selectedIndex == 1
                ? objectList(_detectedObjects)
                : about(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.graphic_eq),
            label: 'Graphs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        onTap: _onItemTapped,
      ),
    );
  }
}
