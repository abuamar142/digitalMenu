// ignore_for_file: avoid_print

import 'package:digital_menu/app/controllers/auth_controller.dart';
import 'package:digital_menu/app/core/values/strings.dart';
import 'package:digital_menu/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool isHidden = true.obs;
  RxBool isLoading = false.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthController authController = Get.find<AuthController>();

  Future<void> login() async {
    if (isLoading.value == false) {
      isLoading(true);
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        Get.snackbar(AppStrings.error, 'Enter your email and password first');
      } else if (emailController.text.isEmail == false) {
        Get.snackbar(AppStrings.error, 'Enter correct email format');
      } else {
        Map<String, dynamic> result = await authController.login(
          emailController.text,
          passwordController.text,
        );

        Get.snackbar(result['error'] == true ? AppStrings.error : AppStrings.success, result['message']);

        if (result['error'] == false) {
          Get.offAllNamed(Routes.DASHBOARD_ADMIN);
        }
      }
      isLoading(false);
    }
  }
}
