import 'package:coloringapp/core/models/path_svg_item.dart';
import 'package:flutter/material.dart';

class SvgPainter extends CustomPainter {
  const SvgPainter(this.pathSvgItem);

  final PathSvgItem pathSvgItem;

  @override
  void paint(Canvas canvas, Size size) {
    Path path = pathSvgItem.path;

    // رسم التعبئة (fill)
    final fillPaint = Paint()
      ..color = pathSvgItem.fill ?? Colors.white
      ..style = PaintingStyle.fill;

    // رسم الحدود (stroke) باللون الأسود
    final strokePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawPath(path, fillPaint); // رسم fill
    canvas.drawPath(path, strokePaint); // رسم stroke
  }

  bool contains(Offset position) {
    return pathSvgItem.path.contains(position);
  }

  @override
  bool shouldRepaint(SvgPainter oldDelegate) {
    return oldDelegate.pathSvgItem.fill != pathSvgItem.fill;
  }
}
