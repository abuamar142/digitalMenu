import 'package:digital_menu/app/data/model/order.dart';
import 'package:digital_menu/app/data/model/selected_product.dart';
import 'package:digital_menu/app/data/services/order.dart';
import 'package:digital_menu/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  TextEditingController noTable = TextEditingController();
  TextEditingController nameOrder = TextEditingController();

  RxBool isLoadingCheckout = false.obs;

  RxList<SelectedProduct> selectedProducts = Get.arguments;

  double get total {
    double totalPrice = 0.0;
    for (var selectedProduct in selectedProducts) {
      totalPrice += selectedProduct.price * selectedProduct.amount.toInt();
    }

    return totalPrice;
  }

  void addOrder() async {
    if (nameOrder.text.isNotEmpty && noTable.text.isNotEmpty) {
      isLoadingCheckout(true);

      try {
        // Mendapatkan tanggal dan jam saat ini
        DateTime now = DateTime.now();

        // Menggunakan tanggal dan jam sebagai bagian dari idOrder
        String idOrder = '${now.day}${now.month}${now.year}${now.hour}${now.minute}${now.millisecond}_${nameOrder.text.toLowerCase()}';

        Map<String, dynamic> orderData = {
          'idOrder': idOrder,
          'dateOrder': now.toIso8601String(),
          'nameOrder': nameOrder.text.toString(),
          'noTable': int.parse(noTable.text).toInt(),
          'items': selectedProducts,
        };

        Map<String, dynamic> hasilOrder = await OrderService.addOrder(orderData);

        if (hasilOrder['error'] == false) {
          Get.toNamed(Routes.RESULT, arguments: idOrder);
        } else {
          Get.snackbar('Warning', hasilOrder['message']);
        }
      } catch (e) {
        print('Error: $e');
        // Handle error jika diperlukan
        Get.snackbar('Error', 'Terjadi kesalahan saat menambahkan pesanan');
      }

      isLoadingCheckout(false);
    } else {
      Get.snackbar('Warning', 'Lengkapi form terlebih dahulu');
    }
  }
}
