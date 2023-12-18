import 'package:digital_menu/app/core/theme/colors.dart';
import 'package:digital_menu/app/routes/app_pages.dart';
import '../../../core/theme/sizes.dart';
import '../../../core/utils/functions/number_formatter.dart';
import '../../../data/model/product.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/product_admin_controller.dart';

class ProductAdminView extends GetView<ProductAdminController> {
  const ProductAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Menu List'),
        centerTitle: true,
      ),
      body: Padding(
        padding: AppSizes.marginAppHaveAppBar,
        child: Column(
          children: [
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    children: [
                      SizedBox(
                        height: constraints.maxHeight,
                        child: FutureBuilder(
                          future: controller.getProduct(),
                          builder: (context, snapProduct) {
                            if (snapProduct.connectionState == ConnectionState.waiting) {
                              // Show a loading indicator while the data is being fetched
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (snapProduct.hasData) {
                              // Display your UI with the fetched data
                              return ListView.builder(
                                itemCount: controller.listProduct.length,
                                itemBuilder: (context, index) {
                                  Product product = controller.listProduct[index];

                                  return InkWell(
                                    onTap: () {
                                      Get.dialog(
                                        SingleChildScrollView(
                                          child: SizedBox(
                                            height: Get.height,
                                            child: Dialog(
                                              child: DialogCard(product: product),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      elevation: 5,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                                        child: LayoutBuilder(
                                          builder: (context, constraints) {
                                            return SizedBox(
                                              width: constraints.maxWidth,
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: 100,
                                                    width: 100,
                                                    child: product.imageUrl.isNotEmpty
                                                        ? Image.network(
                                                            product.imageUrl.toString(),
                                                            fit: BoxFit.contain,
                                                          )
                                                        : const Center(
                                                            child: Text(
                                                              'None',
                                                            ),
                                                          ),
                                                  ),
                                                  const SizedBox(width: 16),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          product.name.toString(),
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                        const SizedBox(height: 16),
                                                        Text(
                                                          'Rp.${formattedNumber(product.price.toInt())}',
                                                          style: const TextStyle(
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const Center(
                                child: Text(
                                  'Menu Kosong',
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: AppSizes.text16),
          ],
        ),
      ),
    );
  }
}

class DialogCard extends GetView<ProductAdminController> {
  const DialogCard({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return FittedBox(
                child: SizedBox(
                  width: constraints.maxWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Item image
                            FittedBox(
                              child: product.imageUrl.isNotEmpty
                                  ? Image.network(
                                      product.imageUrl.toString(),
                                      fit: BoxFit.fitHeight,
                                    )
                                  : const Center(
                                      child: Text(
                                        'None',
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 16),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name.toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  product.description.toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Rp.${formattedNumber(product.price.toInt())}',
                                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSizes.dimen16),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: AppSizes.buttonSize,
                          backgroundColor: controller.isLoading.isFalse ? AppColors.primary : AppColors.red,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              8,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Get.toNamed(Routes.EDIT_PRODUCT, arguments: product);
                        },
                        child: Obx(
                          () => controller.isLoading.isFalse
                              ? const Text(
                                  'Edit',
                                )
                              : SizedBox(
                                  width: 15,
                                  height: 15,
                                  child: CircularProgressIndicator(
                                    color: AppColors.white,
                                    strokeWidth: 2,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: AppSizes.dimen8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: AppSizes.buttonSize,
                          backgroundColor: controller.isLoading.isFalse ? AppColors.yellow : AppColors.red,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              8,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                        child: Center(
                          child: Obx(
                            () => controller.isLoading.isFalse
                                ? const Text(
                                    'Back',
                                  )
                                : SizedBox(
                                    width: 15,
                                    height: 15,
                                    child: CircularProgressIndicator(
                                      color: AppColors.white,
                                      strokeWidth: 2,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
