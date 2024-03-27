import 'package:flutter/material.dart';

class PolygonBean {
  PolygonBean({this.edgeColor = Colors.red, this.bodyColor = Colors.red,
    this.edgeWidth = 2, required this.polygonPoint, this.pointsColor = Colors.blue, this.pointsSize = 5});

  final Color? edgeColor;
  final Color? bodyColor;
  final double? edgeWidth;
  final List<Point> polygonPoint;
  final Color? pointsColor;
  final double? pointsSize;

  PolygonBean copyWith({Color? edgeColor, Color? bodyColor, double? edgeWidth, required List<Point> polygonPoint,
    Color? pointsColor, double? pointsSize}) {
    return PolygonBean(
      edgeColor: edgeColor?? this.edgeColor,
      bodyColor: bodyColor?? this.bodyColor,
      edgeWidth: edgeWidth?? this.edgeWidth,
      polygonPoint: this.polygonPoint,
      pointsColor: this.pointsColor,
      pointsSize: this.pointsSize,
    );
  }

  @override
  String toString() {
    return 'PolygonBean{edgeColor: $edgeColor, bodyColor: $bodyColor, edgeWidth: $edgeWidth, polygonPoint: $polygonPoint, pointsColor: $pointsColor, pointsSize: $pointsSize}';
  }
}

class Point {
  Point({required this.X, required this.Y});

  double X;
  double Y;

  Point copyWith(double x, double y) {
    return Point(
        X: x,
        Y: y,
    );
  }

  @override
  String toString() {
    return 'Point{x: $X, y: $Y}';
  }
}