
import 'package:coloringapp/core/models/path_svg_item.dart';
import 'package:flutter/material.dart';



class VectorImage {
  const VectorImage({
    required this.items,
    this.size,
  });

  final List<PathSvgItem> items;
  final Size? size;
}
