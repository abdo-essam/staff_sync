import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import '../models/employee.dart';
import '../utils/constants.dart';

class EmployeeService {
  static const String apiUrl = 'https://hub.dummyapis.com/employee';

  Future<List<Employee>> getEmployees() async {
    try {
      final http.Client client = _createHttpClient();
      final response = await client.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((json) => Employee.fromJson(json)).toList();
      } else {
        throw Exception(AppConstants.errorLoadingEmployees);
      }
    } catch (e) {
      throw Exception('${AppConstants.errorGeneric}: $e');
    }
  }

  // Create an IOClient with a custom HttpClient to handle SSL certificate expiration
  http.Client _createHttpClient() {
    final HttpClient httpClient = HttpClient()
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return IOClient(httpClient);
  }
}
