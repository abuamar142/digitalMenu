import 'package:digital_menu/app/controllers/product_controller.dart';
import 'package:get/get.dart';

import '../controllers/product_user_controller.dart';

class ProductUserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductUserController>(
      () => ProductUserController(),
    );
    Get.lazyPut<ProductController>(
      () => ProductController(),
    );
  }
}
