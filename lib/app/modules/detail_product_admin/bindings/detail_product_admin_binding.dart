import 'package:digital_menu/app/modules/detail_product_admin/controllers/detail_product_admin_controller.dart';
import 'package:get/get.dart';

class DetailProductAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailProductAdminController>(
      () => DetailProductAdminController(),
    );
  }
}
