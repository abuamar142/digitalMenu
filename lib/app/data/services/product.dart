import 'package:digital_menu/app/core/values/strings.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class ProductService extends GetxService {
  ProductService._();

  static Future<Map<String, dynamic>> getProduct() async {
    try {
      final response = await http.get(Uri.parse('${AppStrings.apiUrl}?sheet=Menu'));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        return {
          'error': false,
          'message': 'Berhasil mengambil data',
          'data': data,
        };
      } else {
        throw {
          'error': true,
          'message': Exception('Gagal mengambil data: ${response.statusCode}'),
          'data': null,
        };
      }
    } catch (e) {
      // Handle error jika diperlukan
      throw {
        'error': true,
        'message': Exception('Error: $e'),
        'data': null,
      };
    }
  }

  static Future<Map<String, dynamic>> updateProduct(Map<String, dynamic> productData) async {
    print('${AppStrings.apiUrl}?sheet=Menu');
    print(jsonEncode(productData));
    try {
      final response = await http.put(
        Uri.parse('${AppStrings.apiUrl}?sheet=Menu'),
        body: jsonEncode(productData),
        headers: {'Content-Type': 'application/json'},
      );

      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        return {
          'error': false,
          'message': 'Data berhasil diperbarui',
          'data': jsonDecode(response.body),
        };
      } else {
        throw {
          'error': true,
          'message': Exception('Gagal memperbarui data: ${response.statusCode}'),
          'data': null,
        };
      }
    } catch (e) {
      // Handle error jika diperlukan
      throw {
        'error': true,
        'message': Exception('Error: $e'),
        'data': null,
      };
    }
  }
}
