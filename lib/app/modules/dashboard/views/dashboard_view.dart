import '../controllers/dashboard_controller.dart';

import '../../../core/theme/sizes.dart';
import '../../../global_widget/button.dart';

import '../../../controllers/auth_controller.dart';
import '../../../core/theme/colors.dart';
import '../../../routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DashboardAdminView extends GetView<DashboardAdminController> {
  DashboardAdminView({super.key});
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'Admin Dashboard',
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              authController.logout();
              Get.offAllNamed(Routes.HOME);
            },
            icon: Icon(
              Icons.logout_outlined,
              color: AppColors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1, vertical: Get.height * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LargeButton(
              isLoading: controller.isLoadingAddProduct,
              onPressed: () {
                Get.toNamed(Routes.ADD_PRODUCT);
              },
              textButton: 'Add Product',
            ),
            const SizedBox(height: AppSizes.dimen16),
            LargeButton(
              isLoading: controller.isLoadingAddProduct,
              onPressed: () {
                Get.toNamed(Routes.ALL_PRODUCT_ADMIN);
              },
              textButton: 'Products',
            )
          ],
        ),
      ),
    );
  }
}
