import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:medicine_app/utilities/constants/url_contant.dart';

class Http {
  static Future<Response> get(String endpoint) async =>
      await http.get(Uri.parse('${Host.hostname}$endpoint'));
}
