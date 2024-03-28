import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
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
  List<Point> _points = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Point point = Point(X: 0, Y: 0);
    List<double> xList= [200, 400, 200, 400];
    List<double> yList= [200, 200, 400, 400];
    for (int i = 0; i < 4; i++) {
      Point points = point.copyWith(xList[i], yList[i]);
      _points.add(points);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Polygon(
      points: _points,
      pointColor: Colors.blue.withOpacity(0.7),
      pointSize: 10,
      edgeColor: Colors.blue,
      edgeWidth: 10,
      child: Scaffold(
        body:SizedBox(),
      ),
    );
  }
}
