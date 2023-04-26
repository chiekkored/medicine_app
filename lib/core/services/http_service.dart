import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:medicine_app/utilities/constants/url_contant.dart';

class Http {
  static Future<Response> get(String endpoint) async =>
      await http.get(Uri.parse('${Host.hostname}$endpoint'));

  static Future<Response> post(
          String endpoint, Map<String, dynamic> body) async =>
      await http.post(Uri.parse('${Host.hostname}$endpoint'), body: body);

  static Future<Response> put(
          String endpoint, Map<String, dynamic> body) async =>
      await http.put(Uri.parse('${Host.hostname}$endpoint'), body: body);
}
