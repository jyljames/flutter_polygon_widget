import 'package:flutter/cupertino.dart';
import 'package:flutter_polygon/src/polygon_bean.dart';

class PolygonManager {
  factory PolygonManager() => _instance;

  PolygonManager._();

  static final PolygonManager _instance = PolygonManager._();

  /// Determine if the click is inside the polygon body
  bool isPointInsidePolygon(
      double x, double y, PolygonBean polygonBean) {
    bool isPointInsideArea = false;
    int intersectCount = 0;
    if (polygonBean.polygonPoint.length < 3) {
      throw Exception('Polygon must have at least 3 points.');
    }
    for (int i = 0; i < polygonBean.polygonPoint.length; i++) {
      int nextIndex = (i + 1) % polygonBean.polygonPoint.length;
      Point localPoint = polygonBean.polygonPoint[i];
      Point nextPoint = polygonBean.polygonPoint[nextIndex];
      if (localPoint.Y > y && nextPoint.Y <= y ||
          nextPoint.Y > y && localPoint.Y <= y) {
        double intersectX = (y - localPoint.Y) /
            (nextPoint.Y - localPoint.Y) *
            (nextPoint.X - localPoint.X) +
            localPoint.X;
        if (x <= intersectX) {
          intersectCount++;
        }
      }
    }
    if (intersectCount % 2 == 1) {
      isPointInsideArea = true;
    } else {
      isPointInsideArea = false;
    }
    debugPrint(
        '_isPointInsidePolygon----isPointInsideArea, $isPointInsideArea');

    return isPointInsideArea;
  }

  bool _checkIntersectingLines(Point p1, Point p2, Point p3, Point p4) {
    double determinant = (p2.X - p1.X) * (p4.Y - p3.Y) - (p4.X - p3.X) * (p2.Y - p1.Y);
    if (determinant == 0) {
      return false; // 平行线段不相交
    } else {
      double ua = ((p4.X - p3.X) * (p1.Y - p3.Y) - (p4.Y - p3.Y) * (p1.X - p3.X)) / determinant;
      double ub = ((p2.X - p1.X) * (p1.Y - p3.Y) - (p2.Y - p1.Y) * (p1.X - p3.X)) / determinant;
      return ua >= 0 && ua <= 1 && ub >= 0 && ub <= 1;
    }
  }

  bool _isTriangle(Point p1, Point p2, Point p3) {
    double determinant = (p2.X - p1.X) * (p3.Y - p1.Y) - (p3.X - p1.X) * (p2.Y - p1.Y);
    return determinant != 0;
  }

  /// This method can be used to determine whether the formed shape is a polygon
  /// or an irregular shape with intersecting line segments
  bool isRightPolygon(PolygonBean polygonBean) {
    bool isTriangle = _isTriangle(polygonBean.polygonPoint[0], polygonBean.polygonPoint[1], polygonBean.polygonPoint[2]);
    if (polygonBean.polygonPoint.length == 3 && isTriangle) {
      return true;
    }
    for (int i = 0; i < polygonBean.polygonPoint.length; i++) {
      if (i == polygonBean.polygonPoint.length - 1) {
        continue;
      }
      int j = i + 1;
      for (int k = 0; k < polygonBean.polygonPoint.length - 3; k++) {
        j++;
        Point p1 = Point(X: polygonBean.polygonPoint[i].X,
            Y: polygonBean.polygonPoint[i].Y);
        Point p2;
        if (i + 1 >= polygonBean.polygonPoint.length) {
          p2 = Point(X: polygonBean.polygonPoint[0].X,
              Y: polygonBean.polygonPoint[0].Y);
        } else {
          p2 = Point(X: polygonBean.polygonPoint[i + 1].X,
              Y: polygonBean.polygonPoint[i + 1].Y);
        }
        if (j >= polygonBean.polygonPoint.length) {
          j = 0;
        }
        Point p3 = Point(X: polygonBean.polygonPoint[j].X,
            Y: polygonBean.polygonPoint[j].Y);
        Point p4;
        if (j + 1 >= polygonBean.polygonPoint.length) {
          p4 = Point(X: polygonBean.polygonPoint[0].X,
              Y: polygonBean.polygonPoint[0].Y);
        } else {
          p4 = Point(X: polygonBean.polygonPoint[j + 1].X,
              Y: polygonBean.polygonPoint[j + 1].Y);
        }
        bool isIntersecting = _checkIntersectingLines(p1, p2, p3, p4);
        if (isIntersecting) {
          return true;
        }
      }
    }
    return false;
  }

  /// Thi way make sure which point you click, return point index
  int? confirmPoint(double x, double y, PolygonBean polygon) {
    try {
      for (int i = 0; i < polygon.polygonPoint.length; i++) {
        if ((polygon.polygonPoint[i].X + polygon.pointsSize! + 15 >= x &&
            x >= polygon.polygonPoint[i].X - polygon.pointsSize! - 15) &&
            (polygon.polygonPoint[i].Y + polygon.pointsSize! + 15 >= y &&
                y >= polygon.polygonPoint[i].Y - polygon.pointsSize! - 15)) {
          return i;
        }
      }
    } catch(e) {
      debugPrint(e as String?);
    }
    return null;
  }
}