import 'package:digital_menu/app/core/theme/colors.dart';
import 'package:digital_menu/app/core/theme/sizes.dart';
import 'package:digital_menu/app/core/theme/text.dart';
import 'package:digital_menu/app/core/values/strings.dart';
import 'package:digital_menu/app/data/model/product.dart';
import 'package:digital_menu/app/global_widget/button.dart';
import 'package:digital_menu/app/modules/detail_product_admin/controllers/detail_product_admin_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class DetailProductAdminView extends GetView<DetailProductAdminController> {
  const DetailProductAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    final Product product = Get.arguments;

    controller.productIdController.text = product.id.toString();
    controller.categoryController.text = product.category;
    controller.nameController.text = product.name;
    controller.priceController.text = product.price.toString();
    controller.descriptionController.text = product.description;
    controller.imageUrlController.text = product.imageUrl.toString();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Product'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * 0.1,
        ),
        child: ListView(
          children: [
            SizedBox(
              height: Get.height * 0.3,
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: 200,
                  child: controller.imageUrlController.text.isNotEmpty
                      ? Image.network(product.imageUrl.toString())
                      : const Center(
                          child: Text(
                            'None',
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              autocorrect: false,
              controller: controller.productIdController,
              readOnly: true,
              style: AppTextStyles.textStyleW500S14,
              decoration: InputDecoration(
                labelText: 'Product Id',
                border: OutlineInputBorder(
                  borderRadius: AppSizes.allRadius8,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              autocorrect: false,
              controller: controller.nameController,
              keyboardType: TextInputType.text,
              style: AppTextStyles.textStyleW500S14,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(
                  borderRadius: AppSizes.allRadius8,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              autocorrect: false,
              controller: controller.priceController,
              keyboardType: TextInputType.number,
              style: AppTextStyles.textStyleW500S14,
              decoration: InputDecoration(
                labelText: 'Price',
                border: OutlineInputBorder(
                  borderRadius: AppSizes.allRadius8,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              autocorrect: false,
              controller: controller.descriptionController,
              keyboardType: TextInputType.text,
              maxLines: 3,
              style: AppTextStyles.textStyleW500S14,
              decoration: InputDecoration(
                labelText: 'Product Description',
                border: OutlineInputBorder(
                  borderRadius: AppSizes.allRadius8,
                ),
              ),
            ),
            const SizedBox(height: AppSizes.dimen16),
            LargeButton(
              backgroundColor: AppColors.primary,
              isLoading: controller.isLoadingPickFile,
              onPressed: () async {
                controller.pickFile();
              },
              textButton: 'Pick Product Image',
            ),
            const SizedBox(height: 20),
            LargeButton(
                isLoading: controller.isLoadingDelete,
                onPressed: () {
                  if (controller.nameController.text.isEmpty || controller.priceController.text.isEmpty || controller.descriptionController.text.isEmpty) {
                    Get.snackbar(AppStrings.error, 'Enter your product category, name, price, and description first');
                  } else if (controller.priceController.text.isNumericOnly == false) {
                    Get.snackbar(AppStrings.error, 'Enter your product price with number first');
                  } else {
                    Get.defaultDialog(
                      title: 'Confirmation',
                      middleText: 'Are you sure to delete the product?',
                      titlePadding: const EdgeInsets.only(top: 30),
                      contentPadding: const EdgeInsets.all(30),
                      actions: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(),
                          onPressed: () => Get.back(),
                          child: const Text('No'),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                          onPressed: () async {},
                          child: Obx(
                            () => controller.isLoadingUpdate.isFalse
                                ? const Text('Confirm')
                                : const SizedBox(
                                    width: 15,
                                    height: 15,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    );
                  }
                },
                textButton: 'Save'),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Get.defaultDialog(
                  title: 'Confirmation',
                  middleText: 'Are you sure to delete the product?',
                  titlePadding: const EdgeInsets.only(top: 30),
                  contentPadding: const EdgeInsets.all(30),
                  actions: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(),
                      onPressed: () => Get.back(),
                      child: const Text('No'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                      onPressed: () async {},
                      child: Obx(
                        () => controller.isLoadingDelete.isFalse
                            ? const Text('Confirm')
                            : const SizedBox(
                                width: 15,
                                height: 15,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              ),
                      ),
                    ),
                  ],
                );
              },
              child: Text(
                'Delete Product',
                style: AppTextStyles.textStyleW700S14.copyWith(color: AppColors.red),
              ),
            )
          ],
        ),
      ),
    );
  }
}
