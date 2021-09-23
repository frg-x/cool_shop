import 'dart:convert';
import 'package:cool_shop/cubit/login/login_cubit.dart';
import 'package:cool_shop/main.dart';
import 'package:intl/intl.dart';

import 'package:cool_shop/constants.dart';
import 'package:cool_shop/utilities/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class NetworkService {
  Dio _dio = Dio();
  String checkedAccessToken = '';
  String checkedRefreshToken = '';

  int tokenUpdateRetries = 0;
  int tokenUpdateLimit = 3;

  NetworkService() {
    SecureStorageService.readAll().then((allKeys) {
      if (allKeys != null && allKeys['accessToken'] != null) {
        checkedAccessToken = allKeys['accessToken'];
      }
      if (allKeys != null && allKeys['refreshToken'] != null) {
        checkedRefreshToken = allKeys['refreshToken'];
      }
    });
    BaseOptions options = BaseOptions(
      baseUrl: GlobalUrls.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: Constants.requestTimeoutSeconds * 1000, // 3 seconds
      receiveTimeout: Constants.requestTimeoutSeconds * 1000, // 3 seconds
      headers: {'Authorization': 'Bearer $checkedAccessToken'},
    );
    _dio = Dio(options);
    _dio.interceptors.clear();
    //_dio.interceptors.add(LogInterceptor(responseBody: true));

    // _dio.interceptors.add(PrettyDioLogger(
    //     //     requestBody: true,
    //     //     requestHeader: true,
    //     ));

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) {
          //print('ACCESS TOKEN: ' + checkedAccessToken);
          if (checkedAccessToken != '') {
            request.headers['Authorization'] = 'Bearer $checkedAccessToken';
          }
          return handler.next(request);
        },
        onError: (err, handler) async {
          //print(err);
          if (err.response?.statusCode == 401) {
            tokenUpdateRetries++;
            print('Trying to update refreshToken: #$tokenUpdateRetries');
            if (tokenUpdateRetries == tokenUpdateLimit) {
              getIt<LoginCubit>().signOutYouWasHacked();
              return;
            }
            _dio
                .post(GlobalUrls.refreshTokenEndpoint,
                    data: jsonEncode({'refreshToken': checkedRefreshToken}))
                .then((updatedTokens) async {
              if (updatedTokens.statusCode == 200) {
                checkedAccessToken = updatedTokens.data['accessToken'] ?? '';
                checkedRefreshToken = updatedTokens.data['refreshToken'] ?? '';

                // if (checkedAccessToken.isNotEmpty &&
                //     checkedRefreshToken.isNotEmpty) {
                //   DateTime now = DateTime.now();
                //   String formattedDate =
                //       DateFormat('yyyy-MM-dd – kk:mm').format(now);
                //   print(
                //       '$formattedDate Received new refreshToken: $checkedRefreshToken');
                //   print(
                //       '$formattedDate Received new accessToken: $checkedAccessToken');
                // }

                DateTime now = DateTime.now();
                String formattedDate =
                    DateFormat('yyyy-MM-dd – HH:mm:ss').format(now);
                print(
                    '$formattedDate Received new refreshToken: $checkedRefreshToken');
                print(
                    '$formattedDate Received new accessToken: $checkedAccessToken');

                SecureStorageService.write(
                    SecureStorageKey.accessToken, checkedAccessToken);
                SecureStorageService.write(
                    SecureStorageKey.refreshToken, checkedRefreshToken);
                err.requestOptions.headers['Authorization'] =
                    'Bearer $checkedAccessToken';

                //create request with new access token
                final opts = Options(
                  method: err.requestOptions.method,
                  headers: err.requestOptions.headers,
                );
                final cloneReq = await _dio.request(
                  err.requestOptions.path,
                  options: opts,
                  data: err.requestOptions.data,
                  queryParameters: err.requestOptions.queryParameters,
                );
                return handler.resolve(cloneReq);
              }
            });
          } else {
            return handler.reject(err);
          }
        },
      ),
    );
  }

  // Future<void> getNewAccessToken() async {
  //   try {
  //     Response? response = await _dio.post(
  //       GlobalUrls.refreshTokenEndpoint,
  //       data: jsonEncode({'refreshToken': checkedRefreshToken}),
  //     );
  //     if (response.statusCode == 200) {
  //       checkedAccessToken = response.data['accessToken'];
  //       checkedRefreshToken = response.data['refreshToken'];
  //     } else {
  //       throw Exception(response.statusMessage);
  //     }
  //   } on DioError catch (ex) {
  //     if (ex.type == DioErrorType.connectTimeout) {
  //       throw Exception("Connection Timeout Exception");
  //     } else {
  //       throw Exception('${ex.error}\n${ex.response!.data}');
  //     }
  //   }
  // }

  Future<Map?> login(String email, String password) async {
    try {
      Response? response = await _dio.post(
        GlobalUrls.loginEndpoint,
        data: jsonEncode({'email': email, 'password': password}),
      );
      if (response.statusCode == 200) {
        checkedAccessToken = response.data['accessToken'] ?? '';
        checkedRefreshToken = response.data['refreshToken'] ?? '';
        if (checkedAccessToken.isNotEmpty && checkedRefreshToken.isNotEmpty) {
          DateTime now = DateTime.now();
          String formattedDate =
              DateFormat('yyyy-MM-dd – kk:mm:SS').format(now);
          print(
              '$formattedDate Received new refreshToken: $checkedRefreshToken');
          print('$formattedDate Received new accessToken: $checkedAccessToken');
        }
        return response.data;
      } else {
        return null;
      }
    } on DioError catch (e) {
      //throw Exception('${e.response!.statusCode} ${e.response!.statusMessage!}');
      throw Exception(e.message);
    } catch (err) {
      throw Exception(err); // Catches all types of `Exception` and `Error`.
    }
  }

  Future<Map?> postRequest(
    String endpoint,
    var data,
  ) async {
    Response? response = await _dio.post(endpoint, data: data);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<Map?> deleteRequest(
    String endpoint,
    var data,
  ) async {
    Response? response = await _dio.post(endpoint, data: data);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception(response.statusMessage);
    }
  }

  Future<Map?> getRequest(String endpoint) async {
    Response? response = await _dio.get(endpoint);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      if (response.statusCode == 400) {
        throw Exception(response.data);
      } else {
        throw Exception(response.statusMessage);
      }
    }
  }

  // Future<Map<dynamic, dynamic>?> getRequest(String endpoint) async {
  //   try {
  //     Response? response = await _dio.get(endpoint);
  //     if (response.statusCode == 200) {
  //     } else {
  //       throw Exception(response.statusMessage);
  //     }
  //     return response.data;
  //   } on DioError catch (err) {
  //     //throw Exception('${e.response!.statusCode} ${e.response!.statusMessage!}');
  //     if (err.type == DioErrorType.connectTimeout) {
  //       throw Exception("Connection timeout");
  //     } else if (err.response!.statusCode! < 500) {
  //       throw err.response!.data;
  //     } else {
  //       throw err.message;
  //     }
  //   }
  // }
}
