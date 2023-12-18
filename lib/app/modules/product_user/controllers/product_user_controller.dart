import 'package:digital_menu/app/core/values/strings.dart';
import 'package:digital_menu/app/data/model/product.dart';
import 'package:digital_menu/app/data/model/selected_product.dart';
import 'package:digital_menu/app/data/services/product.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ProductUserController extends GetxController {
  RxList<SelectedProduct> selectedProduct = RxList.empty();

  double get totalPriceSelectedProducts {
    double totalPrice = 0.0;
    for (var product in selectedProduct) {
      totalPrice += product.price * product.amount.toInt();
    }
    return totalPrice;
  }

  int get totalAmountSelectedProducts {
    int totalAmount = 0;
    for (var product in selectedProduct) {
      totalAmount += product.amount.toInt();
    }
    return totalAmount;
  }

  // Item in dialog card
  RxBool spicy = false.obs;
  RxInt amount = 1.obs;
  TextEditingController note = TextEditingController();

  RxBool isLoading = false.obs;
  RxBool addNote = false.obs;

  void addItem(Product product) {
    try {
      // Check if the product is already in the list
      int existingIndex = selectedProduct.indexWhere(
        (item) => item.id == product.id && item.spicy.value == spicy.value && item.note.toString() == note.text,
      );

      if (existingIndex != -1) {
        // If the product exists, update the quantity
        selectedProduct[existingIndex].amount += amount.toInt();
      } else {
        // If the product is not in the list, add a new item
        selectedProduct.add(
          SelectedProduct.fromProductItem(
            product,
            amount.toInt(),
            product.price * amount.toDouble(),
            spicy.value,
            note.text,
          ),
        );
      }

      Get.back();
    } catch (e) {
      Get.snackbar(AppStrings.success, e.toString());
    }
  }

  RxList<Product> listProduct = RxList.empty();

  Future<Map<String, dynamic>> getProduct() async {
    Map<String, dynamic> hasilProduct = await ProductService.getProduct();

    if (hasilProduct['error'] == false) {
      List<dynamic> data = hasilProduct['data'];

      for (var element in data) {
        listProduct.add(Product.fromJson(element));
      }
    } else {
      Get.snackbar('Warning', hasilProduct['message']);
    }

    return hasilProduct;
  }
}
