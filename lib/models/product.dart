import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    required this.id,
    required this.imageUrl,
    required this.collection,
    required this.title,
    required this.price,
    required this.discount,
    required this.rating,
    required this.ratingCount,
  });

  int id;
  String imageUrl;
  String title;
  double price;
  double discount;
  int rating;
  int ratingCount;
  String collection;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        imageUrl: json["imageUrl"],
        price: json["price"].toDouble(),
        discount: json["discount"].toDouble(),
        rating: json["rating"],
        ratingCount: json["ratingCount"],
        collection: json["collection"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "imageUrl": imageUrl,
        "price": price,
        "discount": discount,
        "rating": rating,
        "ratingCount": ratingCount,
        "collection": collection,
      };
}
