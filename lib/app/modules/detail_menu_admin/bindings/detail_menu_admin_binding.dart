import 'package:get/get.dart';

import '../controllers/detail_menu_admin_controller.dart';

class DetailMenuAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailMenuAdminController>(
      () => DetailMenuAdminController(),
    );
  }
}
