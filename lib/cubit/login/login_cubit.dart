import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:cool_shop/constants.dart';
import 'package:cool_shop/utilities/network_service.dart';
import 'package:cool_shop/utilities/secure_storage.dart';
import 'package:string_validator/string_validator.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.data) : super(LoginInitial()) {
    getLoginState();
    checkLoginState();
  }

  String userId = '';
  String userName = '';
  String email = '';
  String password = '';

  bool isNameValid = false;
  bool isEmailValid = false;
  bool isPasswordValid = false;

  bool verifiedOne = false;
  bool verifiedTwo = false;
  bool verifiedThree = false;

  bool? isLogged = false;
  final Map<String, dynamic> data;

  bool isRunning = true;

  void validateFields() {
    isNameValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!-_]+").hasMatch(userName) &&
        userName.length >= 6;
    isEmailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    isPasswordValid =
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&*]+").hasMatch(password) &&
            password.length >= 6;

    if (isNameValid && isEmailValid && isPasswordValid) {
      verifiedOne = true;
      verifiedTwo = true;
      verifiedThree = true;
    } else if (isEmailValid && isPasswordValid) {
      verifiedOne = true;
      verifiedTwo = true;
      verifiedThree = false;
    } else if (isEmailValid) {
      verifiedOne = true;
      verifiedTwo = false;
      verifiedThree = false;
    } else {
      verifiedOne = false;
      verifiedTwo = false;
      verifiedThree = false;
    }
    data.addAll({
      'name': userName,
      'email': email,
      'password': password,
      'isNameValid': isNameValid,
      'isEmailValid': isEmailValid,
      'isPasswordValid': isPasswordValid,
      'isLogged': isLogged,
    });
    emit(LoginStatus(data, MessageType.empty, ''));
  }

  void checkLoginState() async {
    SecureStorageService.readAll().then((Map<dynamic, dynamic>? storageData) {
      String isLoggedStorage = toString(storageData!['isLogged']);
      isLogged = toBoolean(isLoggedStorage);
      userId = storageData['userId'] ?? '';
      userName = storageData['userName'] ?? '';
      data.addAll({
        'name': userName,
        'email': email,
        'password': password,
        'isNameValid': isNameValid,
        'isEmailValid': isEmailValid,
        'isPasswordValid': isPasswordValid,
        'isLogged': isLogged,
      });
      //print(storageData);
      emit(LoginStatus(data, MessageType.empty, ''));
    });
  }

  Future<void> getLoginState() async {
    while (isRunning) {
      var tmpIsLogged =
          await SecureStorageService.read(SecureStorageKey.isLogged);
      if (tmpIsLogged != null) {
        isLogged = toBoolean(tmpIsLogged);
      } else {
        isLogged = null;
      }
      if (isLogged != null) {
        if (isLogged!) {
          print('Logged!');
        } else {
          print('Signed out by user');
        }
      } else {
        signOutYouWasHacked();
        isRunning = false;
        print('Signed out by protecting system');
      }
      await Future.delayed(const Duration(seconds: 5));
    }
  }

  void signOutYouWasHacked() async {
    SecureStorageService.deleteAll().then((_) {
      userId = '';
      userName = '';
      email = '';
      password = '';
      isNameValid = false;
      isEmailValid = false;
      isPasswordValid = false;
      verifiedOne = false;
      verifiedTwo = false;
      verifiedThree = false;
      isLogged = null;
      data.addAll({
        'name': userName,
        'email': email,
        'password': password,
        'isNameValid': isNameValid,
        'isEmailValid': isEmailValid,
        'isPasswordValid': isPasswordValid,
        'isLogged': isLogged,
      });
      emit(LoginStatus(data, MessageType.error,
          'Sorry... Something went wrong\nPlease, try to Sign In again'));
    });
  }

  void signOut() async {
    SecureStorageService.deleteAll().then((_) {
      userId = '';
      userName = '';
      email = '';
      password = '';
      isNameValid = false;
      isEmailValid = false;
      isPasswordValid = false;
      verifiedOne = false;
      verifiedTwo = false;
      verifiedThree = false;
      isLogged = false;
      isRunning = true;
      data.addAll({
        'name': userName,
        'email': email,
        'password': password,
        'isNameValid': isNameValid,
        'isEmailValid': isEmailValid,
        'isPasswordValid': isPasswordValid,
        'isLogged': isLogged,
      });
      emit(LoginStatus(data, MessageType.error, 'You\'ve signed out'));
    });
  }

  // void signOut() async {
  //   SecureStorageService.readAll().then((allKeys) {
  //     print(allKeys);
  //   });
  // }

  void readAllSettings() {
    SecureStorageService.readAll().then((settings) {
      //print(settings);
      data.addAll(settings as Map<String, dynamic>);
      //print(data);
      emit(LoginStatus(data, MessageType.empty, ''));
    });
  }

  void signInWithEmailPassword() async {
    final _networkService = NetworkService();
    try {
      Map? responseData = await _networkService.login(email, password);
      if (responseData != null) {
        if (responseData['success']) {
          userId = responseData['userId'];
          userName = responseData['userName'];
          isLogged = true;
          // await SecureStorageService.write(SecureStorageKey.email, email);
          // await SecureStorageService.write(SecureStorageKey.password, password);
          await SecureStorageService.write(
              SecureStorageKey.userName, responseData['userName']);
          await SecureStorageService.write(
              SecureStorageKey.userId, responseData['userId']);
          await SecureStorageService.write(
              SecureStorageKey.accessToken, responseData['accessToken']);
          await SecureStorageService.write(
              SecureStorageKey.refreshToken, responseData['refreshToken']);
          await SecureStorageService.write(SecureStorageKey.isLogged, 'true');
          data.addAll({
            'name': userName,
            'email': email,
            'password': password,
            'isNameValid': isNameValid,
            'isEmailValid': isEmailValid,
            'isPasswordValid': isPasswordValid,
            'isLogged': isLogged,
          });
          emit(
            LoginStatus(data, MessageType.success, ''),
          );
        } else {
          emit(LoginStatus(data, MessageType.error, responseData['message']));
        }
      }
    } on Exception catch (e) {
      emit(LoginStatus(data, MessageType.error, e.toString()));
    }
  }

  void signUp() async {
    final _networkService = NetworkService();
    try {
      Map? responseData = await _networkService.postRequest(
        GlobalUrls.createUserEndpoint,
        jsonEncode({
          "userName": userName,
          "email": email,
          "password": password,
          "confirmPassword": password,
        }),
      );
      if (responseData != null) {
        if (responseData['success']) {
          emit(
            LoginStatus(data, MessageType.success, responseData['message']),
          );
        } else {
          emit(LoginStatus(data, MessageType.error, responseData['message']));
        }
      }
    } on Exception catch (e) {
      emit(LoginStatus(data, MessageType.error, e.toString()));
    }
  }
}
