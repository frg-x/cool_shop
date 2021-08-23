import 'package:cool_shop/constants.dart';
import 'package:cool_shop/models/product.dart';
import 'package:cool_shop/utilities/network_service.dart';

class ShopRepository {
  Future<List<Product>?> getProducts() async {
    List<Product> productsList = [];
    Map<dynamic, dynamic>? productsData =
        await NetworkService().getRequest(GlobalUrls.getAllProducts);
    if (productsData != null) {
      List<dynamic> listOfProducts = productsData['products'];
      for (var product in listOfProducts) {
        Product productObject =
            Product.fromJson(Map<String, dynamic>.from(product));
        productsList.add(productObject);
      }
      return productsList;
    } else {
      return null;
    }
  }
}
