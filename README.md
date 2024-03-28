# polygon

A simple widget that can draw, change, and drag polygons(You can customize the colors of polygons, edges, and dots).


## Demo

![Demo](https://raw.githubusercontent.com/java-james/loading_overlay/master/loading_overlay.gif)

*See example for details*


## Usage

Add the package to your `pubspec.yml` file.

```yml
dependencies:
  polygon: ^0.4.0
```

Next, import the library into your widget.

```dart
import 'package:flutter_polygon/flutter_polygon.dart';
```

Wrap your app widget.

```dart
Polygon(
  /// set toast style, optional
  points: points,
  child: child,
);
```

### Method (You can use these function when you want to deal your polygon)

This method can be used to determine whether the formed shape is a polygon or an irregular shape with intersecting line segments

```dart
PolygonManager().isRightPolygon;
```


## Options

Polygon have default style, you also can custom style.


|      name       |          type           |   need   |             desc              |
|:---------------:|:-----------------------:|:--------:|:-----------------------------:|
|      child      |         Widget          | required | On the child you want to draw |
|     points      |       List<Point>       | required |       polygon's points        |
|    edgeColor    |          Color          | optional |                               |
|    bodyColor    |          Color          | optional |                               |
|    edgeWidth    |         double          | optional |                               |
|    pointSize    |         double          | optional |                               |
|   pointColor    |          Color          | optional |                               |
|   onPanUpdate   |        Function         | optional | you can set it when you drag  |
|    onPanDown    |        Function         | optional |                               |
|    onPanEnd     |        Function         | optional |                               |
| containerWidth  |         double          | optional |                               |
| containerHeight |         double          | optional |                               |


## Examples

```dart
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

```
