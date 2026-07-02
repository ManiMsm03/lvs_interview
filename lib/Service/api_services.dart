import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Model/api_response_model.dart';

class ApiService {
  final String baseUrl = "https://your-api-url.com";


  Future<ApiResponse> getMethod(String endpoint) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl$endpoint"),
        headers: {
          "Content-Type": "application/json",
        },
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception("GET failed: $e");
    }
  }

  Future<ApiResponse> postMethod(
      String endpoint,
      Map<String, dynamic> body,
      ) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl$endpoint"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(body),
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception("POST failed: $e");
    }
  }

   ApiResponse _handleResponse(http.Response response) {
    final data = jsonDecode(response.body);

    return ApiResponse(
      statusCode: response.statusCode,
      data: data,
    );
  }
}