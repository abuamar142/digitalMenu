import 'package:digital_menu/app/controllers/product_controller.dart';
import 'package:get/get.dart';

import '../controllers/user_product_controller.dart';

class UserProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserProductController>(
      () => UserProductController(),
    );
    Get.lazyPut<ProductController>(
      () => ProductController(),
    );
  }
}
