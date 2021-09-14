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
    required this.sizes,
    required this.colors,
  });

  int id;
  String imageUrl;
  String title;
  double price;
  double discount;
  int rating;
  int ratingCount;
  String collection;
  List<dynamic> sizes;
  List<dynamic> colors;

  factory Product.fromJson(Map<String, dynamic> jsonData) => Product(
        id: jsonData["id"],
        title: jsonData["title"],
        imageUrl: jsonData["imageUrl"],
        price: jsonData["price"].toDouble(),
        discount: jsonData["discount"].toDouble(),
        rating: jsonData["rating"],
        ratingCount: jsonData["ratingCount"],
        collection: jsonData["collection"],
        sizes: json.decode(jsonData["size"].replaceAll('\'', '\"')),
        colors: json.decode(jsonData["color"].replaceAll('\'', '\"')),
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
        "size": sizes,
        "color": colors,
      };
}
