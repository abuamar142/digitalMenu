import '../../../core/theme/colors.dart';
import '../../../core/theme/sizes.dart';
import '../../../core/theme/text.dart';
import '../../../global_widget/button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';

import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
  const AddProductView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.nameController.text = 'Magelangan';
    controller.priceController.text = '12000';
    controller.descriptionController.text = 'Nasi goreng mawut dengan mie dari Indomie';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1, vertical: Get.height * 0.025),
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/icons/login.svg',
                height: Get.height * 0.4,
                fit: BoxFit.fitHeight,
              ),
              Dropdown(
                listItems: controller.listCategory,
                selectedValue: controller.selectedCategory,
              ),
              const SizedBox(height: AppSizes.dimen16),
              TextField(
                autocorrect: false,
                style: AppTextStyles.textStyleW500S14,
                controller: controller.nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radius8),
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
                    borderRadius: BorderRadius.circular(AppSizes.radius8),
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
                    borderRadius: BorderRadius.circular(AppSizes.radius8),
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
              const SizedBox(height: AppSizes.dimen24),
              LargeButton(
                backgroundColor: AppColors.primary,
                isLoading: controller.isLoadingAddProduct,
                onPressed: () async {
                  controller.addProduct();
                },
                textButton: 'Save',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
