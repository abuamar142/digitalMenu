import 'dart:convert';

class Product {
  final int id;
  final String category;
  final String name;
  final dynamic price;
  final String description;
  final String imageUrl;

  Product({
    required this.id,
    required this.category,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
  });

  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        category: json["category"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "name": name,
        "price": price,
        "description": description,
        "imageUrl": imageUrl,
      };
}
