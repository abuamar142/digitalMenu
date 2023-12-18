import 'package:digital_menu/app/data/model/product.dart';

import 'package:get/get.dart';

class SelectedProduct {
  final int id;
  final String category;
  final String name;
  final double price;
  final String description;
  final String imageUrl;
  late RxInt amount; // Gunakan RxInt untuk mengubah amount
  late double totalPrice;
  late RxBool spicy; // Gunakan RxBool untuk mengubah spicy
  late RxString note; // Gunakan RxString untuk mengubah note

  SelectedProduct({
    required this.id,
    required this.category,
    required this.name,
    required this.price,
    this.description = '',
    this.imageUrl = '',
    int amount = 1,
    this.totalPrice = 0.0,
    bool spicy = false,
    String note = '',
  }) {
    this.amount = amount.obs;
    this.spicy = spicy.obs;
    this.note = note.obs;
  }

  factory SelectedProduct.fromProductItem(Product productItem, int amount, double totalPrice, bool spicy, String note) {
    return SelectedProduct(
      id: productItem.id,
      category: productItem.category,
      name: productItem.name,
      price: productItem.price.toDouble(),
      description: productItem.description,
      imageUrl: productItem.imageUrl,
      amount: amount,
      totalPrice: totalPrice,
      spicy: spicy,
      note: note,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'name': name,
      'price': price,
      'description': description,
      'imageUrl': imageUrl,
      'amount': amount.value, // Mengambil nilai RxInt
      'totalPrice': totalPrice,
      'spicy': spicy.value, // Mengambil nilai RxBool
      'note': note.value, // Mengambil nilai RxString
    };
  }
}
