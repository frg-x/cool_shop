class ProductCard {
  ProductCard({
    required this.imageURL,
    required this.vendor,
    required this.title,
    required this.price,
    required this.priceDiscounted,
    required this.rating,
    required this.reviewsNumber,
  });

  String imageURL;
  String vendor;
  String title;
  double price;
  double priceDiscounted;
  int rating;
  int reviewsNumber;
}
