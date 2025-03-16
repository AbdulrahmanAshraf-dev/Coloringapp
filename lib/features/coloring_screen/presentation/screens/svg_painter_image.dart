import 'package:coloringapp/core/models/path_svg_item.dart';
import 'package:flutter/material.dart';

import '../../manager/svg_painter.dart';

class SvgPainterImage extends StatelessWidget {
  const SvgPainterImage({
    super.key,
    required this.item,
    required this.size,
    required this.onTap,
  });

  final PathSvgItem item;
  final Size size;
  final Function(Offset) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => onTap(details.localPosition), // تمرير إحداثيات الضغط
      child: CustomPaint(
        size: size,
        painter: SvgPainter(item),
      ),
    );
  }
}
