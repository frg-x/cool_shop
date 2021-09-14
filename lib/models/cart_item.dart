class CartItem {
  CartItem({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.size,
    required this.color,
    required this.quantity,
  });

  int id;
  String imageUrl;
  String title;
  double price;
  String size;
  String color;
  int quantity;
}
