import 'package:coloringapp/core/models/path_svg_item.dart';
import 'package:coloringapp/core/models/vector_image.dart';
import 'package:coloringapp/core/utils/get_vector_image_from_string_xml.dart';
import 'package:coloringapp/features/coloring_screen/presentation/screens/svg_painter_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ColoringSvgScreen extends StatefulWidget {
  const ColoringSvgScreen({super.key});

  @override
  State<ColoringSvgScreen> createState() => _ColoringSvgScreenState();
}

class _ColoringSvgScreenState extends State<ColoringSvgScreen> {
  @override
  void initState() {
    _init();
    super.initState();
  }

  Size? _size;
  List<PathSvgItem>? _items;
  Color _selectedColor = Colors.red;

  static const urlDogWithSmile =
      'https://res.cloudinary.com/dlvkpvwnb/image/upload/v1742080461/1_guqtvj.svg';

  Future<void> _init() async {
    final value = await getVectorImage(urlDogWithSmile);
    setState(() {
      _items = value.items;
      _size = value.size;
    });
  }

  void _onTap(Offset position) {
    for (int i = 0; i < _items!.length; i++) {
      if (_items![i].path.contains(position)) {
        setState(() {
          _items![i] = PathSvgItem(
            path: _items![i].path,
            fill: _selectedColor,
          );
        });
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Coloring SVG')),
      body: Column(
        children: [
          Expanded(
            child: _items == null || _size == null
                ? const Center(child: CircularProgressIndicator())
                : InteractiveViewer(
                    child: Center(
                      child: FittedBox(
                        child: RepaintBoundary(
                          child: SizedBox(
                            width: _size!.width,
                            height: _size!.height,
                            child: Stack(
                              children: [
                                for (int index = 0;
                                    index < _items!.length;
                                    index++)
                                  SvgPainterImage(
                                    item: _items![index],
                                    size: _size!,
                                    onTap: _onTap,
                                  )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
          _buildColorPalette()
        ],
      ),
    );
  }

  Widget _buildColorPalette() {
    final colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
      Colors.orange,
      Colors.purple,
      Colors.pink,
      Colors.black,
    ];
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.grey[200],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: colors.map((color) {
          return GestureDetector(
            onTap: () => setState(() => _selectedColor = color),
            child: Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
                border: Border.all(
                  color: _selectedColor == color
                      ? Colors.black
                      : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

Future<VectorImage> getVectorImage(String url) async {
  final String svgData = await getSvgData(url);
  final VectorImage vectorImage = getVectorImageFromStringXml(svgData);
  return vectorImage;
}

Future<String> getSvgData(String url) async {
  final http.Response data = await http.get(Uri.parse(url));
  return data.body;
}
