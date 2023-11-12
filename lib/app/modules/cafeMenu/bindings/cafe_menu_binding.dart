import 'package:digital_menu/app/controllers/product_controller.dart';
import 'package:get/get.dart';

import '../controllers/cafe_menu_controller.dart';

class CafeMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CafeMenuController>(
      () => CafeMenuController(),
    );
    Get.lazyPut<ProductController>(
      () => ProductController(),
    );
  }
}
