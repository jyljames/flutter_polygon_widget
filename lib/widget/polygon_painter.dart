import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../src/polygon_bean.dart';

class PolygonPainter extends CustomPainter {
  final PolygonBean _polygon;

  PolygonPainter(this._polygon,);

  @override
  void paint(Canvas canvas, Size size) {
    final edgePaint = Paint()
      ..color = _polygon.edgeColor!
      ..strokeWidth = _polygon.edgeWidth!
      ..style = PaintingStyle.stroke;

    final bodyPaint = Paint()
      ..color = _polygon.bodyColor!
      ..style = PaintingStyle.fill;


    final pointPaint = Paint()
      ..color = _polygon.pointsColor ?? Colors.transparent
      ..strokeWidth = _polygon.pointsSize ?? 0
      ..style = PaintingStyle.fill;

    // Connect points sequentially using the passed in point list and draw lines
    Path path = Path();
    path.moveTo(_polygon.polygonPoint.first.X, _polygon.polygonPoint.first.Y);
    for (int i = 1; i < _polygon.polygonPoint.length; i++) {
      path.lineTo(_polygon.polygonPoint[i].X, _polygon.polygonPoint[i].Y);
    }
    path.close();
    // Draw fill color
    canvas.drawPath(path, bodyPaint);
    _drawLine(canvas, edgePaint);
    _drawCircle(canvas, pointPaint);
  }

  void _drawLine(Canvas canvas, Paint paint) {
    for (int i = 0; i < _polygon.polygonPoint.length - 1; i++) {
      canvas.drawLine(
        Offset(_polygon.polygonPoint[i].X, _polygon.polygonPoint[i].Y),
        Offset(_polygon.polygonPoint[i + 1].X, _polygon.polygonPoint[i + 1].Y),
        paint,
      );
    }
    canvas.drawLine(
      Offset(_polygon.polygonPoint.last.X, _polygon.polygonPoint.last.Y),
      Offset(_polygon.polygonPoint.first.X, _polygon.polygonPoint.first.Y),
      paint,
    );

  }

  void _drawCircle(Canvas canvas, Paint paint) {
    for (Point point in _polygon.polygonPoint) {
      canvas.drawCircle(
        Offset(point.X, point.Y),
        _polygon.pointsSize!,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}