import 'dart:convert';

class Product {
  final String category;
  final String description;
  final String name;
  final int price;
  final String productId;
  String? imageURL;

  Product({
    required this.category,
    required this.description,
    required this.name,
    required this.price,
    required this.productId,
    this.imageURL,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        category: json["category"],
        description: json["description"],
        name: json["name"],
        price: json["price"],
        productId: json["productId"],
        imageURL: json["imageURL"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "description": description,
        "name": name,
        "price": price,
        "productId": productId,
        "imageURL": imageURL,
      };
}
