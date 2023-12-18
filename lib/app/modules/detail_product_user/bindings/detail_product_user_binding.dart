import 'package:get/get.dart';

import '../controllers/detail_product_user_controller.dart';

class DetailMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailMenuController>(
      () => DetailMenuController(),
    );
  }
}
