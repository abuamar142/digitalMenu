import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:digital_menu/app/core/values/strings.dart';

class OrderService extends GetxService {
  OrderService._();

  static Future<Map<String, dynamic>> addOrder(Map<String, dynamic> orderData) async {
    print('${AppStrings.apiUrl}?sheet=Order');
    print('\n');
    print(jsonEncode(orderData));
    print('\n');
    try {
      final response = await http.post(
        Uri.parse('${AppStrings.apiUrl}?sheet=Order'),
        body: jsonEncode(orderData),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 302) {
        return {
          'error': false,
          'message': 'Pesanan berhasil ditambahkan',
          'data': jsonDecode(response.body),
        };
      } else {
        throw {
          'error': true,
          'message': Exception('Gagal menambahkan pesanan: ${response.statusCode}'),
          'data': null,
        };
      }
    } catch (e) {
      // Handle error jika diperlukan
      if (e is FormatException) {
        return {
          'error': false,
          'message': 'Pesanan berhasil ditambahkan',
          'data': null,
        };
      } else {
        throw {
          'error': true,
          'message': Exception('Error: $e'),
          'data': null,
        };
      }
    }
  }
}
