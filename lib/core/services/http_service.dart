import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:medicine_app/utilities/constants/url_contant.dart';

/// Custom Http services.
class Http {
  /// HTTP GET Request to a specified [String] `endpoint`.
  static Future<Response> get(String endpoint) async =>
      await http.get(Uri.parse('${Host.hostname}$endpoint'));

  /// HTTP POST Request to a specified [String] `endpoint`.
  static Future<Response> post(String endpoint,
          {required Map<String, dynamic> body}) async =>
      await http.post(Uri.parse('${Host.hostname}$endpoint'), body: body);

  /// HTTP PUT Request to a specified [String] `endpoint`.
  static Future<Response> put(String endpoint,
          {required Map<String, dynamic> body}) async =>
      await http.put(Uri.parse('${Host.hostname}$endpoint'), body: body);
}
