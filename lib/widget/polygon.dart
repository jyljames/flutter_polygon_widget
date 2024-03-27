import 'package:flutter/material.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:flutter_polygon/widget/polygon_painter.dart';

import '../src/polygon_bean.dart';
import '../src/polygon_manager.dart';


enum PanWay {
  outsidePolygon,
  insidePolygon,
  insidePoint
}

class Polygon extends StatefulWidget {
  /// polygon's points，must be set
  final List<Point> points;

  /// polygon's edge color
  final Color? edgeColor;

  /// polygon color
  final Color? bodyColor;

  /// polygon's edge width, default 2
  final double? edgeWidth;

  /// polygon points Size, default 5
  final double? pointSize;

  /// polygon points' color
  final Color? pointColor;

  /// callback for GestureDetector Widget
  final GestureDragUpdateCallback? onPanUpdate;
  final GestureDragDownCallback? onPanDown;
  final GestureDragEndCallback? onPanEnd;

  final double? screenWidth;
  final double? screenHeight;

  final Widget? child;

  const Polygon({super.key,
    required this.points,
    this.edgeColor = Colors.red,
    this.edgeWidth = 2.0,
    this.bodyColor = Colors.red,
    this.pointSize = 5,
    this.pointColor = Colors.black,
    this.onPanUpdate,
    this.onPanDown,
    this.onPanEnd,
    this.screenWidth,
    this.screenHeight,
    this.child,
  });

  @override
  State<Polygon> createState() => _PolygonState();
}

class _PolygonState extends State<Polygon> {
  final List<Point> _polygonPoints = [];
  late PolygonBean _polygon;
  late double _screenWidth;
  late double _screenHeight;

  PanWay _panWay = PanWay.outsidePolygon;

  @override
  void initState() {
    super.initState();
    _polygonPoints.addAll(widget.points.map((point) =>
        Point(X: point.X, Y: point.Y)));
    _polygon = PolygonBean(polygonPoint: _polygonPoints, edgeWidth: widget.edgeWidth, edgeColor: widget.edgeColor,
    pointsColor: widget.pointColor, pointsSize: widget.pointSize);
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = widget.screenWidth ?? MediaQuery.of(context).size.width;
    _screenHeight = widget.screenHeight ?? MediaQuery.of(context).size.height;
    return GestureDetector(
      onPanUpdate: (details) {
        debugPrint('polygon now pan update.');
        _dragPolygon(details.delta.dx, details.delta.dy, details.localPosition.dx, details.localPosition.dy,  _polygon);
      },
      onPanDown: (details) {
        debugPrint('polygon now pan down. x = ${details.localPosition.dx}, y = ${details.localPosition.dy}');
        _confirmPanMode(details.localPosition.dx, details.localPosition.dy, _polygon);
      },
      onPanEnd: widget.onPanEnd,
      child: CustomPaint(
        foregroundPainter: PolygonPainter(
          _polygon,
        ),
        child: widget.child,
      ),
    );
  }

  void _confirmPanMode(
      double x, double y, PolygonBean polygon) {
    if (PolygonManager().confirmPoint(x, y, polygon) != null) {
      _panWay = PanWay.insidePoint;
    } else if (PolygonManager().isPointInsidePolygon(x, y, polygon)) {
      _panWay = PanWay.insidePolygon;
    } else {
      _panWay = PanWay.outsidePolygon;
    }
    debugPrint(
        '_confirmPanMode function---- pan way = $_panWay');
  }

  void _dragPolygon(
      double dx, double dy, double locationX, double locationY, PolygonBean polygon) {
    setState(() {
      switch (_panWay) {
        case PanWay.outsidePolygon:
          break;
        case PanWay.insidePolygon:
          _dragSizeChangePosition(polygon, dx, dy);
          break;
        case PanWay.insidePoint:
          int pointIndex = PolygonManager().confirmPoint(locationX, locationY, polygon)!;
          _dragSizeChangePoint(
              pointIndex, polygon, dx, dy);
          break;
      }
    });
  }

  void _dragSizeChangePoint(
      int pointIndex, PolygonBean polygon, dx, dy) {
    setState(() {
      polygon.polygonPoint[pointIndex].X =
          polygon.polygonPoint[pointIndex].X + dx;
      polygon.polygonPoint[pointIndex].Y =
          polygon.polygonPoint[pointIndex].Y + dy;
      if (polygon.polygonPoint[pointIndex].X <= 0) {
        polygon.polygonPoint[pointIndex].X = 0;
      }
      if (polygon.polygonPoint[pointIndex].Y <= 0) {
        polygon.polygonPoint[pointIndex].Y = 0;
      }
      if (polygon.polygonPoint[pointIndex].X >= _screenWidth) {
        polygon.polygonPoint[pointIndex].X = _screenWidth;
      }
      if (polygon.polygonPoint[pointIndex].Y >= _screenHeight) {
        polygon.polygonPoint[pointIndex].Y = _screenHeight;
      }
    });
  }

  void _dragSizeChangePosition(PolygonBean polygon, dx, dy) {
    setState(() {
      for (Point localPoint in polygon.polygonPoint) {
        localPoint.X = localPoint.X + dx;
        localPoint.Y = localPoint.Y + dy;
        if (localPoint.X <= 0) {
          localPoint.X = 0;
        }
        if (localPoint.Y <= 0) {
          localPoint.Y = 0;
        }
        if (localPoint.X >= _screenWidth) {
          localPoint.X = _screenWidth;
        }
        if (localPoint.Y >= _screenHeight) {
          localPoint.Y = _screenHeight;
        }
      }
    });
  }
}

