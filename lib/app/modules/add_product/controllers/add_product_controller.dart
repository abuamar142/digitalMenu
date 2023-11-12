import '../../../controllers/product_controller.dart';
import '../../../core/values/strings.dart';
import '../../../routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String filePath = '';

  RxBool isLoadingPickFile = false.obs;
  RxBool isLoadingAddProduct = false.obs;

  RxString selectedCategory = 'Category'.obs;

  List<String> listCategory = [
    'Category',
    'Food',
    'Drink',
    'Snack',
  ];

  final ProductController productController = Get.find<ProductController>();

  Future<void> addProduct() async {
    if (isLoadingAddProduct.value == false) {
      isLoadingAddProduct(true);

      if (nameController.text.isEmpty || priceController.text.isEmpty || descriptionController.text.isEmpty || selectedCategory.value == 'Category') {
        Get.snackbar(AppStrings.error, 'Enter your product category, name, price, and description first');
      } else if (priceController.text.isNumericOnly == false) {
        Get.snackbar(AppStrings.error, 'Enter your product price with number first');
      } else {
        try {
          if (filePath.isNotEmpty) {
            Map<String, dynamic> result = await productController.uploadFileToFirebaseStorage(filePath, nameController.text);

            if (result['error'] == false) {
              Map<String, dynamic> resultProduct = await productController.addProduct(
                {
                  'category': selectedCategory.toString(),
                  'name': nameController.text,
                  'price': int.tryParse(priceController.text),
                  'description': descriptionController.text,
                  'imageURL': result['downloadURL'],
                },
              );

              Get.snackbar(resultProduct['error'] == true ? AppStrings.error : AppStrings.success, resultProduct['message']);

              if (resultProduct['error'] == false) {
                Get.offAllNamed(Routes.DASHBOARD_ADMIN);
              }
            }
          } else {
            Map<String, dynamic> resultProduct = await productController.addProduct(
              {
                'category': selectedCategory.toString(),
                'name': nameController.text,
                'price': int.tryParse(priceController.text),
                'description': descriptionController.text,
                'imageURL': '',
              },
            );

            Get.snackbar(resultProduct['error'] == true ? AppStrings.error : AppStrings.success, resultProduct['message']);

            if (resultProduct['error'] == false) {
              Get.offAllNamed(Routes.DASHBOARD_ADMIN);
            }
          }
        } catch (e) {
          Get.snackbar(AppStrings.error, 'Error uploading the file $e');
          isLoadingAddProduct(false);
          return;
        }
      }

      isLoadingAddProduct(false);
    }
  }

  Future<void> pickFile() async {
    Map<String, dynamic> result = await productController.pickFile();

    if (result['error'] == false) {
      print("file path sebelum $filePath");
      print("file path sebelum ${filePath.isEmpty}");

      filePath = result['path_to_file'];
      print("file path sesudah $filePath");
      print("file path sesudah ${filePath.isEmpty}");
      Get.snackbar(AppStrings.success, result['message']);
    } else if (result['error'] = true) {
      Get.snackbar(AppStrings.error, result['message']);
    } else {
      Get.snackbar(AppStrings.error, 'Failed to load file');
    }
  }
}
