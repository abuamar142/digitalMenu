import 'package:get/get.dart';

import '../modules/add_product/bindings/add_product_binding.dart';
import '../modules/add_product/views/add_product_view.dart';
import '../modules/checkout/bindings/checkout_binding.dart';
import '../modules/checkout/views/checkout_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/detail_product_admin/bindings/detail_product_admin_binding.dart';
import '../modules/detail_product_admin/views/detail_product_admin_view.dart';
import '../modules/detail_product_user/bindings/detail_product_user_binding.dart';
import '../modules/detail_product_user/views/detail_product_user_view.dart';
import '../modules/edit_product/bindings/edit_product_binding.dart';
import '../modules/edit_product/views/edit_product_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/product_admin/bindings/product_admin_binding.dart';
import '../modules/product_admin/views/product_admin_view.dart';
import '../modules/product_user/bindings/product_user_binding.dart';
import '../modules/product_user/views/product_user_view.dart';
import '../modules/result/bindings/result_binding.dart';
import '../modules/result/views/result_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_USER,
      page: () => const ProductUserView(),
      binding: ProductUserBinding(),
    ),
    GetPage(
      name: _Paths.CHECKOUT,
      page: () => const CheckoutView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PRODUCT_USER,
      page: () => const DetailMenuView(),
      binding: DetailMenuBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD_ADMIN,
      page: () => DashboardAdminView(),
      binding: DashboardAdminBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PRODUCT,
      page: () => const AddProductView(),
      binding: AddProductBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT_ADMIN,
      page: () => const ProductAdminView(),
      binding: ProductAdminBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PRODUCT_ADMIN,
      page: () => const DetailProductAdminView(),
      binding: DetailProductAdminBinding(),
    ),
    GetPage(
      name: _Paths.RESULT,
      page: () => const ResultView(),
      binding: ResultBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PRODUCT,
      page: () => const EditProductView(),
      binding: EditProductBinding(),
    ),
  ];
}
