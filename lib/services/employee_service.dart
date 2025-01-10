import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/employee.dart';
import '../utils/constants.dart';

class EmployeeService {
  final Dio _dio = Dio();

  Future<List<Employee>> getEmployees() async {
    try {
      // Try to get cached data first
      final prefs = await SharedPreferences.getInstance();
      final cachedData = prefs.getString(AppConstants.employeesCacheKey);

      if (cachedData != null && cachedData.isNotEmpty) {
        try {
          final List<dynamic> decodedData = json.decode(cachedData);
          return decodedData
              .map<Employee>((json) => Employee.fromJson(json))
              .toList();
        } catch (e) {
          // Ignore corrupt cache and fetch fresh data
          await prefs.remove(AppConstants.employeesCacheKey);
        }
      }

      _dio.httpClientAdapter = IOHttpClientAdapter(createHttpClient: () {
        final HttpClient client = HttpClient();
        client.badCertificateCallback = (cert, host, port) => true;
        return client;
      });

      // If no valid cached data, fetch from API
      final response = await _dio.get(AppConstants.apiUrl);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final employees =
        data.map<Employee>((json) => Employee.fromJson(json)).toList();

        // Cache the data
        await prefs.setString(
            AppConstants.employeesCacheKey, json.encode(data));

        return employees;
      } else {
        throw Exception(
            '${AppConstants.errorLoadingEmployees}: ${response.statusCode} - ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('${AppConstants.errorNetwork}: ${e.message}');
    } catch (e) {
      throw Exception('${AppConstants.errorGeneric}: $e');
    }
  }

  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(AppConstants.employeesCacheKey)) {
      await prefs.remove(AppConstants.employeesCacheKey);
    }
  }
}
