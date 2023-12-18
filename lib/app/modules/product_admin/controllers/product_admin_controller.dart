import 'package:digital_menu/app/data/model/product.dart';
import 'package:digital_menu/app/data/services/product.dart';

import 'package:get/get.dart';

class ProductAdminController extends GetxController {
  RxBool isLoading = false.obs;

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
