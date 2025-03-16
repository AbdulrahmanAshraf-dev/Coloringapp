import 'package:http/http.dart' as http;

Future<String> getSvgData(String url) async {
  final http.Response data = await http.get(Uri.parse(url));
  return data.body;
}