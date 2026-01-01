import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  // Replace with your backend URL
  static const String baseUrl = 'https://learner-teach.online/api';

  // Login
  static Future<Map<String, dynamic>> login(
    String username,
    String password,
  ) async {
    final url = Uri.parse('$baseUrl/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'success': false,
          'message': jsonDecode(response.body)['message'] ?? 'Login failed',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Error connecting to server'};
    }
  }

  static Future<Map<String, dynamic>> getHomeData({
    String? category,
    String? search,
  }) async {
    final uri = Uri.parse(
      '$baseUrl/home?category=${category ?? ""}&search=${search ?? ""}',
    );
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load home data');
    }
  }
}
