import 'package:cool_shop/constants.dart';
import 'package:cool_shop/models/product.dart';
import 'package:cool_shop/models/user.dart';
import 'package:cool_shop/utilities/network_service.dart';

class ShopRepository {
  Future<List<Product>?> getProducts() async {
    List<Product> productsList = [];
    final _networkService = NetworkService();
    Map<dynamic, dynamic>? productsData =
        await _networkService.getRequest(GlobalUrls.getAllProducts);
    if (productsData != null) {
      List<dynamic> listOfProducts = productsData['products'];
      for (var product in listOfProducts) {
        //print(json.decode(product['color'].replaceAll('\'', '\"')).runtimeType);
        Product productObject =
            Product.fromJson(Map<String, dynamic>.from(product));
        productsList.add(productObject);
      }
      return productsList;
    } else {
      return null;
    }
  }

  Future<User?> getProfile(int id) async {
    final _networkService = NetworkService();
    Map<dynamic, dynamic>? userData = await _networkService
        .getRequest(GlobalUrls.getProfile + '/' + id.toString());
    if (userData != null) {
      final user = User(
        id: userData['id'],
        email: userData['login'],
        password: userData['password'],
        firstName: userData['firstName'],
        secondName: userData['secondName'],
        age: userData['age'],
      );
      return user;
    } else {
      return null;
    }
  }
}
