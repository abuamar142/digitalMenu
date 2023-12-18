import 'package:digital_menu/app/core/theme/colors.dart';
import 'package:digital_menu/app/core/theme/sizes.dart';
import 'package:digital_menu/app/core/theme/text.dart';
import 'package:digital_menu/app/data/model/product.dart';
import 'package:digital_menu/app/global_widget/button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:svg_flutter/svg_flutter.dart';

import '../controllers/edit_product_controller.dart';

class EditProductView extends GetView<EditProductController> {
  const EditProductView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.nameController.text = controller.product.name;
    controller.priceController.text = controller.product.price.toString();
    controller.descriptionController.text = controller.product.description;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: AppSizes.marginAppHaveAppBar,
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/icons/product.svg',
                height: Get.height * 0.4,
                fit: BoxFit.contain,
              ),
              // Dropdown(
              //   listItems: controller.listCategory,
              //   selectedValue: controller.selectedCategory,
              // ),
              const SizedBox(height: AppSizes.dimen16),
              TextField(
                autocorrect: false,
                style: AppTextStyles.textStyleW500S14,
                controller: controller.nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.dimen16),
              TextField(
                autocorrect: false,
                style: AppTextStyles.textStyleW500S14,
                controller: controller.priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(
                    borderRadius: AppSizes.allRadius8,
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.dimen16),
              TextField(
                autocorrect: false,
                maxLines: 3,
                style: AppTextStyles.textStyleW500S14,
                controller: controller.descriptionController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: AppSizes.allRadius8,
                  ),
                ),
              ),
              // const SizedBox(height: AppSizes.dimen16),
              // LargeButton(
              //   backgroundColor: AppColors.primary,
              //   isLoading: controller.isLoadingPickFile,
              //   onPressed: () async {
              //     controller.pickFile();
              //   },
              //   textButton: 'Pick Product Image',
              // ),
              const SizedBox(height: AppSizes.dimen16),
              LargeButton(
                backgroundColor: AppColors.primary,
                isLoading: controller.isLoadingAddProduct,
                onPressed: () async {
                  controller.updateProduct();
                },
                textButton: 'Update',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
