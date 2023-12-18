// ignore_for_file: avoid_print

import 'package:digital_menu/app/controllers/product_controller.dart';
import 'package:digital_menu/app/core/values/strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailProductAdminController extends GetxController {
  final TextEditingController productIdController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();

  RxBool isLoadingPickFile = false.obs;
  RxBool isLoadingUpdate = false.obs;
  RxBool isLoadingDelete = false.obs;

  String filePath = '';

  final ProductController productController = Get.find<ProductController>();

  Future<void> updateProduct() async {
    isLoadingUpdate(true);
    print("Apakah filePath tidak kosong: ${filePath.isNotEmpty}");
    try {
      if (filePath.isNotEmpty) {
        Map<String, dynamic> resultUpload = await productController.uploadFileToFirebaseStorage(filePath, nameController.text);

        if (imageUrlController.text.isNotEmpty) {
          await productController.deleteFile(imageUrlController.text);
          imageUrlController.text = '';
        }

        imageUrlController.text = resultUpload['downloadURL'];
      }

      Map<String, dynamic> result = await productController.updateProduct({
        'productId': productIdController.text,
        'name': nameController.text,
        'category': categoryController.text,
        'price': int.tryParse(priceController.text),
        'description': descriptionController.text,
        'imageURL': imageUrlController.text, // Menggunakan newImageURL yang mungkin kosong
      });

      print('back back');
      Get.back();
      Get.back();
      print('back back');

      Get.snackbar(
        result['error'] == true ? AppStrings.error : AppStrings.success,
        result['message'],
      );
    } catch (e) {
      Get.snackbar(AppStrings.error, e.toString());
    }

    isLoadingUpdate(false);
  }

  Future<void> deleteProduct(String productId, String imageURL) async {
    isLoadingDelete(true);
    try {
      Map<String, dynamic> result = await productController.deleteProduct(productId, imageURL);

      Get.snackbar(
        result['error'] == true ? AppStrings.error : AppStrings.success,
        result['message'],
      );

      Get.back();
    } catch (e) {
      Get.back();
      Get.snackbar(AppStrings.error, e.toString());
    }
    isLoadingDelete(false);
  }

  Future<void> pickFile() async {
    Map<String, dynamic> result = await productController.pickFile();
    if (result['error'] == false) {
      filePath = result['path_to_file'];
      Get.snackbar(AppStrings.success, result['message']);
    } else if (result['error'] = true) {
      Get.snackbar(AppStrings.error, result['message']);
    } else {
      Get.snackbar(AppStrings.error, 'Failed to load file');
    }
  }
}
