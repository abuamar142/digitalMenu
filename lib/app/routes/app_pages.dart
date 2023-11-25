import 'package:get/get.dart';

import '../modules/add_product/bindings/add_product_binding.dart';
import '../modules/add_product/views/add_product_view.dart';
import '../modules/all_product_admin/bindings/all_product_admin_binding.dart';
import '../modules/all_product_admin/views/all_product_admin_view.dart';
import '../modules/userProduct/bindings/user_product_binding.dart';
import '../modules/userProduct/views/user_product_view.dart';
import '../modules/checkout/bindings/checkout_binding.dart';
import '../modules/checkout/views/checkout_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/detail_menu/bindings/detail_menu_binding.dart';
import '../modules/detail_menu/views/detail_menu_view.dart';
import '../modules/detail_menu_admin/bindings/detail_menu_admin_binding.dart';
import '../modules/detail_menu_admin/views/detail_menu_admin_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
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
      name: _Paths.CAFE_MENU,
      page: () => const UserProductView(),
      binding: UserProductBinding(),
    ),
    GetPage(
      name: _Paths.CHECKOUT,
      page: () => const CheckoutView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_MENU,
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
      name: _Paths.ALL_PRODUCT_ADMIN,
      page: () => const AllProductAdminView(),
      binding: AllProductAdminBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_MENU_ADMIN,
      page: () => const DetailMenuAdminView(),
      binding: DetailMenuAdminBinding(),
    ),
    GetPage(
      name: _Paths.RESULT,
      page: () => const ResultView(),
      binding: ResultBinding(),
    ),
  ];
}
