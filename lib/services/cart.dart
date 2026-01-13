import 'package:http/http.dart' as http;
import 'dart:convert';
import './api.dart'; // Import your Api class

class CartService {
  // Use the baseUrl from Api class
  static String get baseUrl => Api.baseUrl;

  // Checkout API call
  static Future<void> checkout({
    required List<Map<String, dynamic>> items,
    required double subtotal,
    required double tax,
    required double total,
  }) async {
    try {
      final orderData = {
        'items': items,
        'subtotal': subtotal,
        'tax': tax,
        'total': total,
      };

      final response = await http.post(
        Uri.parse('$baseUrl/checkout'),
        headers: {
          'Content-Type': 'application/json',
          // Add authorization header if needed
          // 'Authorization': 'Bearer YOUR_TOKEN',
        },
        body: json.encode(orderData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Checkout successful
        return;
      } else {
        // Handle error response
        final error = json.decode(response.body);
        throw Exception(error['message'] ?? 'Checkout failed');
      }
    } catch (e) {
      // Re-throw the error to be handled by the caller
      throw Exception('Failed to process checkout: $e');
    }
  }
}