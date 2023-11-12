import 'package:get/get.dart';

class MenuItem {
  final int id;
  final RxString name;
  final RxDouble price;
  final RxString image;

  MenuItem({
    required this.id,
    required String name,
    required double price,
    String image = '',
  })  : name = name.obs,
        price = price.obs,
        image = image.obs;

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name.value, // Mengambil nilai RxString
      'price': price.value, // Mengambil nilai RxDouble
      'image': image.value, // Mengambil nilai RxString
    };
  }
}
