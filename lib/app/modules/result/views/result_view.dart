import 'package:digital_menu/app/core/theme/sizes.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controllers/result_controller.dart';

class ResultView extends GetView<ResultController> {
  const ResultView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.dimen48),
              height: Get.height * 0.4,
              child: QrImageView(
                data: controller.sale.name.isNotEmpty ? controller.sale.name : controller.id,
              ),
            ),
            const SizedBox(height: AppSizes.dimen24),
            const Text(
              'Tunjukkan Kode pada Kasir',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
