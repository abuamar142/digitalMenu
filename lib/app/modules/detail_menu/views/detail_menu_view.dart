import 'package:digital_menu/app/data/model/product.dart';

import '../../../core/utils/functions/number_formatter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_menu_controller.dart';

class DetailMenuView extends GetView<DetailMenuController> {
  const DetailMenuView({super.key});
  @override
  Widget build(BuildContext context) {
    Product product = Get.arguments;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('DetailMenuView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: Get.height * 0.1),
        child: Column(
          children: [
            SizedBox(
              height: 320,
              child: product.imageUrl.isNotEmpty
                  ? Image.network(product.imageUrl.toString())
                  : const Center(
                      child: Text(
                        'None',
                      ),
                    ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.name.toString(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Rp.${formattedNumber(product.price.toInt())}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
