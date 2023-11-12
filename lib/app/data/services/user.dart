import '../model/user.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class UserService extends GetxService {
  UserService._();

  static Future<List<User>> fetchUser() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://script.google.com/macros/s/AKfycbwQ_ArTGx7Zt1dHOrmtHUCVHk0W_Qfp5yXGuOuNH45q79Qchbhq7T2-JCByRt036jTx/exec',
        ),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);

        final List<User> users = jsonData.map((json) => User.fromJson(json)).toList();

        return users;
      } else {
        throw Exception('Gagal mengambil data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle error jika diperlukan
      throw Exception('Error: $e');
    }
  }
}
