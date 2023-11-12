import '../../../controllers/product_controller.dart';
import 'package:get/get.dart';

class AllProductAdminController extends GetxController {
  RxBool isLoadingDelete = false.obs;

  final ProductController productController = Get.find<ProductController>();
}
