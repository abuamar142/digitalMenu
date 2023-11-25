import 'package:digital_menu/app/core/values/strings.dart';
import 'package:digital_menu/app/data/model/product.dart';
import 'package:digital_menu/app/data/model/transaction.dart';
import 'package:digital_menu/app/data/services/product.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class UserProductController extends GetxController {
  RxList<Sale> sales = RxList.empty();

  double get totalPriceSales {
    double totalPrice = 0.0;
    for (var sale in sales) {
      totalPrice += sale.price * sale.totalItem.toInt();
    }
    return totalPrice;
  }

  int get totalAmountSales {
    int totalAmount = 0;
    for (var sale in sales) {
      totalAmount += sale.totalItem.toInt();
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
      sales.add(
        Sale.fromProductItem(
          product,
          amount.toInt(),
          product.price * amount.toDouble(),
          spicy.value,
          note.text,
        ),
      );

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