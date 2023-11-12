import 'package:digital_menu/app/data/model/transaction.dart';
import 'package:get/get.dart';

class CheckoutController extends GetxController {
  RxList<Sale> sales = Get.arguments;

  double get total {
    double totalPrice = 0.0;
    for (var sale in sales) {
      totalPrice += sale.price * sale.totalItem.toInt();
    }

    return totalPrice;
  }
}
