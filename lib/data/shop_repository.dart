import 'dart:convert';

import 'package:cool_shop/constants.dart';
import 'package:cool_shop/cubit/login/login_cubit.dart';
import 'package:cool_shop/cubit/login/models/data.dart';
import 'package:cool_shop/main.dart';
import 'package:cool_shop/models/product.dart';
import 'package:cool_shop/models/user.dart';
import 'package:cool_shop/utilities/custom_exception.dart';
import 'package:cool_shop/utilities/network_service.dart';
import 'package:cool_shop/utilities/secure_storage.dart';
import 'package:dio/dio.dart';

class ShopRepository {
  List<Product> productsList = [];
  List<Product> favProductsList = [];
  final _networkService = getIt<NetworkService>();

  Future<List<Product>?> getProducts() async {
    productsList.clear();
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

  Future<List<Product>?> getFavoriteProducts() async {
    favProductsList.clear();
    String? userId = await SecureStorageService.read(SecureStorageKey.userId);
    Map<dynamic, dynamic>? favoritesData = await _networkService
        .getRequest(GlobalUrls.getFavoriteProducts + '/$userId');
    if (favoritesData != null) {
      List<dynamic> listOfProducts = favoritesData['products'];
      for (var product in listOfProducts) {
        Product favProduct =
            Product.fromJson(Map<String, dynamic>.from(product));
        favProductsList.add(favProduct);
      }
      return favProductsList;
    } else {
      return null;
    }
  }

  Product getProductById(String productId) {
    return productsList
        .firstWhere((element) => element.id == int.parse(productId));
  }

  Future<void> addToFavorites(String productId, bool oldValue) async {
    Product foundProduct = getProductById(productId);
    favProductsList.add(foundProduct);
    String userId = getIt<LoginCubit>().data.userId;
    Map<dynamic, dynamic>? favoritesData = await _networkService.postRequest(
        GlobalUrls.addToFavoriteProducts,
        jsonEncode(
            {'productId': int.parse(productId), 'userId': int.parse(userId)}));
    if (favoritesData != null && favoritesData['success']) {
      print('Response: ${favoritesData['success']}');
    } else {
      print('error');
      return;
    }
  }

  Future<User?> getProfile(int id) async {
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

  Future<Data?> login(String email, String password) async {
    final data = Data();
    Map? responseData = await _networkService.login(email, password);
    if (responseData != null) {
      if (responseData['success']) {
        data.userId = responseData['userId'];
        data.userName = responseData['userName'];
        data.isLogged = true;
        data.isVerified = responseData['isVerify'];

        await SecureStorageService.write(
            SecureStorageKey.userName, responseData['userName']);
        await SecureStorageService.write(
            SecureStorageKey.userId, responseData['userId']);
        await SecureStorageService.write(
            SecureStorageKey.accessToken, responseData['accessToken']);
        await SecureStorageService.write(
            SecureStorageKey.refreshToken, responseData['refreshToken']);
        await SecureStorageService.write(SecureStorageKey.isLogged, 'true');
        await SecureStorageService.write(
            SecureStorageKey.isVerified, data.isVerified.toString());

        return data;
      } else {
        throw CustomException(responseData['message']);
      }
    } else {
      return null;
    }
  }

  Future<Data?> signUp(Object json) async {
    final data = Data();
    Map? responseData = await _networkService.postRequest(
      GlobalUrls.createUserEndpoint,
      json,
    );
    if (responseData != null) {
      if (responseData['success']) {
        data.currentLoginTab = 0;
        data.message = responseData['message'];
        return data;
      } else {
        throw CustomException(responseData['message']);
      }
    } else {
      return null;
    }
  }

  Future<void> resendSignUpVerifyToken(Object json) async {
    try {
      await _networkService.postRequest(
        GlobalUrls.resendVerifyToken,
        json,
      );
    } on DioError catch (e) {
      throw CustomException(e.response.toString());
    } catch (e) {
      throw CustomException(e.toString());
    }
  }

  Future<void> sendEmailToRecoverPassword(Object json) async {
    try {
      await _networkService.postRequest(
        GlobalUrls.sendEmailToRecoverPassword,
        json,
      );
    } on DioError catch (e) {
      throw CustomException(e.response.toString());
    } catch (e) {
      throw CustomException(e.toString());
    }
  }

  Future<Data?> resetPassword(Object json, String newPassword) async {
    try {
      final data = Data();
      Map? responseData = await _networkService.postRequest(
        GlobalUrls.resetPassword,
        json,
      );
      if (responseData != null) {
        if (responseData['success']) {
          data.message = responseData['message'];
          return data;
        } else {
          throw CustomException(responseData['message']);
        }
      } else {
        return null;
      }
    } on DioError catch (e) {
      throw CustomException(e.message);
    }
  }

  Future<Data?> verifyNewUser(String userId, String verifyCode) async {
    try {
      final data = Data();
      Map? responseData = await _networkService.getRequest(
          GlobalUrls.verifyNewUser + '/UserId/$userId/Token/$verifyCode');
      if (responseData != null) {
        if (responseData['success']) {
          data.isVerified = true;
          data.message = responseData['message'];
          await SecureStorageService.write(
              SecureStorageKey.isVerified, data.isVerified.toString());
          return data;
        } else {
          throw CustomException(responseData['message']);
        }
      } else {
        return null;
      }
    } on DioError catch (e) {
      throw CustomException(e.message);
    }
  }
}
