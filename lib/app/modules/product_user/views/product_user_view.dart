import 'package:digital_menu/app/core/theme/sizes.dart';
import 'package:digital_menu/app/data/model/product.dart';

import '../../../core/utils/functions/number_formatter.dart';
import '../../../core/theme/colors.dart';
import '../../../global_widget/button.dart';
import '../../../routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/product_user_controller.dart';

class ProductUserView extends GetView<ProductUserController> {
  const ProductUserView({super.key});
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
                                      Get.toNamed(Routes.DETAIL_PRODUCT_USER, arguments: product);
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
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Text(
                                                              'Rp.${formattedNumber(product.price.toInt())}',
                                                              style: const TextStyle(
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                            // Add button
                                                            InkWell(
                                                              onTap: () {
                                                                // Reset jumlah pilihan product ke 1
                                                                controller.amount.value = 1;

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
                                                              child: Ink(
                                                                decoration: BoxDecoration(
                                                                  color: AppColors.primary,
                                                                  borderRadius: BorderRadius.circular(8),
                                                                ),
                                                                padding: const EdgeInsets.all(4),
                                                                child: Icon(
                                                                  Icons.add_outlined,
                                                                  color: AppColors.white,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
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
            Container(
              padding: const EdgeInsets.only(left: 16),
              height: AppSizes.dimen48,
              width: Get.height,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.primary), color: AppColors.white),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Obx(
                        () => RichText(
                          textScaleFactor: 1,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '${controller.totalAmountSelectedProducts.toString()} Item',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: ' | Rp.${formattedNumber(controller.totalPriceSelectedProducts.toInt())}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: double.infinity,
                    width: AppSizes.dimen80,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.only(
                        topRight: AppSizes.radius8,
                        bottomRight: AppSizes.radius8,
                      ),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Get.toNamed(Routes.CHECKOUT, arguments: controller.selectedProduct);
                      },
                      icon: Icon(
                        Icons.keyboard_arrow_up_outlined,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DialogCard extends GetView<ProductUserController> {
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
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Visibility(
                            visible: product.category == 'Makanan',
                            child: Obx(
                              () => CheckboxMenuButton(
                                value: controller.spicy.value,
                                onChanged: (value) {
                                  controller.spicy.toggle();
                                },
                                child: Text(
                                  controller.spicy.isFalse ? 'Not Spicy' : 'Spicy',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                          // Add button
                          Row(
                            children: [
                              SmallButton(
                                onTap: () {
                                  if (controller.amount > 1) {
                                    controller.amount--;
                                  }
                                },
                                iconData: Icons.remove_outlined,
                              ),
                              SizedBox(
                                width: 32,
                                child: Obx(
                                  () => Text(
                                    controller.amount.toString(),
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              SmallButton(
                                onTap: () {
                                  controller.amount++;
                                },
                                iconData: Icons.add_outlined,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Obx(
                        () => CheckboxMenuButton(
                          value: controller.addNote.value,
                          onChanged: (value) {
                            controller.addNote.toggle();
                          },
                          child: const Text(
                            'Add Note',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                      Obx(
                        () => Visibility(
                          visible: controller.addNote.value,
                          child: Column(
                            children: [
                              const SizedBox(height: 8),
                              TextField(
                                autocorrect: false,
                                controller: controller.note,
                                keyboardType: TextInputType.text,
                                maxLines: 2,
                                style: const TextStyle(fontSize: 14),
                                decoration: InputDecoration(
                                  labelText: 'Note',
                                  labelStyle: const TextStyle(fontSize: 14),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
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
                          controller.addItem(product);
                        },
                        child: Obx(
                          () => controller.isLoading.isFalse
                              ? const Text(
                                  'Add to Cart',
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
