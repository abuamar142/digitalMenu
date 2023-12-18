import 'dart:convert';

class Order {
  final String idOrder;
  final DateTime dateOrder;
  final String nameOrder;
  final int noTable;
  final int id;
  final String category;
  final String name;
  final double price;
  final String description;
  final String imageUrl;
  final int amount;
  final double totalPrice;
  final String note;
  final dynamic spicy;

  Order({
    required this.idOrder,
    required this.dateOrder,
    required this.nameOrder,
    required this.noTable,
    required this.id,
    required this.category,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
    required this.amount,
    required this.totalPrice,
    required this.note,
    required this.spicy,
  });

  factory Order.fromRawJson(String str) => Order.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        idOrder: json["idOrder"],
        dateOrder: DateTime.parse(json["dateOrder"]),
        nameOrder: json["nameOrder"],
        noTable: json["noTable"],
        id: json["id"],
        category: json["category"],
        name: json["name"],
        price: json["price"],
        description: json["description"],
        imageUrl: json["imageUrl"],
        amount: json["amount"],
        totalPrice: json["totalPrice"],
        note: json["note"],
        spicy: json["spicy"],
      );

  Map<String, dynamic> toJson() => {
        "idOrder": idOrder,
        "dateOrder": dateOrder.toIso8601String(),
        "nameOrder": nameOrder,
        "noTable": noTable,
        "id": id,
        "category": category,
        "name": name,
        "price": price,
        "description": description,
        "imageUrl": imageUrl,
        "amount": amount,
        "totalPrice": totalPrice,
        "note": note,
        "spicy": spicy,
      };
}
