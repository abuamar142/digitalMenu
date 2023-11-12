import '../../../controllers/product_controller.dart';
import 'package:get/get.dart';

import '../controllers/all_product_admin_controller.dart';

class AllProductAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllProductAdminController>(
      () => AllProductAdminController(),
    );
    Get.lazyPut<ProductController>(
      () => ProductController(),
    );
  }
}
