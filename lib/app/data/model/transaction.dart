import 'package:digital_menu/app/data/model/product.dart';

import 'package:get/get.dart';

class Sale {
  final String id;
  final String name;
  final double price;
  final String image;
  late RxInt totalItem; // Gunakan RxInt untuk mengubah totalItem
  late double totalPrice;
  late RxBool spicy; // Gunakan RxBool untuk mengubah spicy
  late RxString note; // Gunakan RxString untuk mengubah note

  Sale({
    required this.id,
    required this.name,
    required this.price,
    this.image = '',
    int totalItem = 1,
    this.totalPrice = 0.0,
    bool spicy = false,
    String note = '',
  }) {
    this.totalItem = totalItem.obs;
    this.spicy = spicy.obs;
    this.note = note.obs;
  }

  factory Sale.fromProductItem(Product productItem, int totalItem, double totalPrice, bool spicy, String note) {
    return Sale(
      id: productItem.id.toString(),
      name: productItem.name.toString(),
      price: productItem.price.toDouble(),
      image: productItem.imageUrl.toString(),
      totalItem: totalItem,
      totalPrice: totalPrice,
      spicy: spicy,
      note: note,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'totalItem': totalItem.value, // Mengambil nilai RxInt
      'totalPrice': totalPrice,
      'spicy': spicy.value, // Mengambil nilai RxBool
      'note': note.value, // Mengambil nilai RxString
    };
  }
}
