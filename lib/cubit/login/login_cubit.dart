import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:cool_shop/constants.dart';
import 'package:cool_shop/cubit/login/models/data.dart';
import 'package:cool_shop/cubit/tab_switching/tab_switching_cubit.dart';
import 'package:cool_shop/data/shop_repository.dart';
import 'package:cool_shop/main.dart';
import 'package:cool_shop/utilities/custom_exception.dart';
import 'package:cool_shop/utilities/network_service.dart';
import 'package:cool_shop/utilities/secure_storage.dart';
import 'package:string_validator/string_validator.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial()) {
    checkLoginState();
  }

  final ShopRepository _shopRepository = ShopRepository();

  Data data = Data();

  void setLoginTab(int page) {
    data.currentLoginTab = page;
    emit(LoginStatus(data, MessageType.empty, '', ShowOnScreen.byDefault));
  }

  String? get getVerifyCode => data.verifyCode;

  void validateCode(String text) {
    data.verifyCode = text;
    data.isCodeValid =
        RegExp(r"^[a-zA-Z0-9]{8}-[a-zA-Z0-9]{4}-[a-zA-Z0-9]{4}-[a-zA-Z0-9]{4}-[a-zA-Z0-9]{12}")
                .hasMatch(data.verifyCode!) &&
            data.verifyCode!.length >= 30;
    if (data.isCodeValid) {
      data.isCodeValid = true;
    } else {
      data.isCodeValid = false;
    }
    emit(LoginStatus(data, MessageType.empty, '', ShowOnScreen.byDefault));
  }

  void validateFields() {
    data.isNameValid =
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!-_]+").hasMatch(data.userName) &&
            data.userName.length >= 6;
    data.isEmailValid =
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(data.email);
    data.isPasswordValid =
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&*]+").hasMatch(data.password) &&
            data.password.length >= 6;

    if (data.isNameValid && data.isEmailValid && data.isPasswordValid) {
      data.verifiedOne = true;
      data.verifiedTwo = true;
      data.verifiedThree = true;
    } else if (data.isEmailValid && data.isPasswordValid) {
      data.verifiedOne = true;
      data.verifiedTwo = true;
      data.verifiedThree = false;
    } else if (data.isEmailValid) {
      data.verifiedOne = true;
      data.verifiedTwo = false;
      data.verifiedThree = false;
    } else {
      data.verifiedOne = false;
      data.verifiedTwo = false;
      data.verifiedThree = false;
    }
    emit(LoginStatus(data, MessageType.empty, '', ShowOnScreen.byDefault));
  }

  void checkLoginState() async {
    SecureStorageService.readAll().then((Map<dynamic, dynamic>? storageData) {
      String isLoggedStorage = toString(storageData!['isLogged']);
      String isVerifiedStorage = toString(storageData['isVerified']);
      data.isLogged = toBoolean(isLoggedStorage);
      data.isVerified = toBoolean(isVerifiedStorage);
      data.userId = storageData['userId'] ?? '';
      data.userName = storageData['userName'] ?? '';
      //print(storageData);
      emit(LoginStatus(data, MessageType.empty, '', ShowOnScreen.byDefault));
    });
  }

  void clearUserInfo() {
    SecureStorageService.deleteAll();
    data.clear();
  }

  void signOut() async {
    clearUserInfo();
    getIt<TabSwitchingCubit>().setActiveTabNumber(0);
    emit(LoginStatus(
        data, MessageType.error, 'You\'ve signed out', ShowOnScreen.byDefault));
  }

  void signOutYouWasHacked() async {
    clearUserInfo();
    emit(LoginStatus(
        data,
        MessageType.error,
        'Sorry... Something went wrong\nPlease, try to Sign In again',
        ShowOnScreen.byDefault));
  }

  // void signOut() async {
  //   SecureStorageService.readAll().then((allKeys) {
  //     print(allKeys);
  //   });
  // }

  void readAllSettings() {
    SecureStorageService.readAll().then((settings) {
      print(settings);
    });
  }

  void clearAccessToken() {
    SecureStorageService.write(SecureStorageKey.accessToken, '')
        .then((_) => print('Done!'));
  }

  void clearRefreshToken() {
    SecureStorageService.write(SecureStorageKey.refreshToken, '')
        .then((_) => print('Done!'));
  }

  void testGetRequest() async {
    Map? responseData = await NetworkService()
        .getRequest(GlobalUrls.getPersonById + '/${data.userId}');
    print(responseData);
  }

  void signInWithEmailPassword() async {
    try {
      Data? responseData =
          await _shopRepository.login(data.email, data.password);
      data.userId = responseData!.userId;
      data.userName = responseData.userName;
      data.isLogged = responseData.isLogged;
      data.isVerified = responseData.isVerified;
      emit(LoginStatus(
          data, MessageType.success, 'Logged in succeed', ShowOnScreen.signIn));
    } on CustomException catch (e) {
      emit(
          LoginStatus(data, MessageType.error, e.message, ShowOnScreen.signIn));
    }
  }

  void sendCodeToResetPassword() async {
    data.verifyCode = '';
    try {
      await _shopRepository.sendEmailToRecoverPassword(
        jsonEncode({
          "email": data.email,
        }),
      );
      emit(LoginStatus(
          data, MessageType.success, 'Success', ShowOnScreen.resetPassword));
    } on CustomException catch (e) {
      emit(LoginStatus(
          data, MessageType.error, e.message, ShowOnScreen.resetPassword));
    }
  }

  void resendSignUpVerifyToken() async {
    data.verifyCode = '';
    try {
      await _shopRepository.resendSignUpVerifyToken(
        jsonEncode({
          "email": data.email,
        }),
      );
    } on CustomException catch (e) {
      emit(LoginStatus(
          data, MessageType.error, e.message, ShowOnScreen.verifyEmail));
    }
  }

  void saveNewPassword(String newPassword) async {
    try {
      Data? responseData = await _shopRepository.resetPassword(
        jsonEncode({
          "password": data.password,
          "confirmPassword": data.password,
          "resetPasswordToken": data.verifyCode,
        }),
        data.password,
      );
      if (responseData != null) {
        data.verifyCode = '';
        data.password = newPassword;
        data.isEmailValid = true;
        data.isPasswordValid = true;
        validateFields();
        emit(
          LoginStatus(
            data,
            MessageType.success,
            responseData.message,
            ShowOnScreen.newPassword,
          ),
        );
      } else {
        emit(LoginStatus(
          data,
          MessageType.error,
          responseData!.message,
          ShowOnScreen.newPassword,
        ));
      }
    } on CustomException catch (e) {
      emit(LoginStatus(
        data,
        MessageType.error,
        e.message,
        ShowOnScreen.newPassword,
      ));
    }
  }

  void signUp() async {
    try {
      Data? responseData = await _shopRepository.signUp(
        jsonEncode({
          "userName": data.userName,
          "email": data.email,
          "password": data.password,
          "confirmPassword": data.password,
        }),
      );

      if (responseData != null) {
        data.currentLoginTab = responseData.currentLoginTab;
        emit(
          LoginStatus(data, MessageType.success, responseData.message,
              ShowOnScreen.signUp),
        );
      }
    } on CustomException catch (e) {
      emit(
          LoginStatus(data, MessageType.error, e.message, ShowOnScreen.signUp));
    }
  }

  void verifyNewUser() async {
    try {
      Data? responseData =
          await _shopRepository.verifyNewUser(data.userId, data.verifyCode!);
      if (responseData != null) {
        data.isVerified = responseData.isVerified;
        emit(
          LoginStatus(data, MessageType.success, responseData.message,
              ShowOnScreen.signUpConfirmation),
        );
      } else {
        emit(LoginStatus(
          data,
          MessageType.error,
          responseData!.message,
          ShowOnScreen.signUpConfirmation,
        ));
      }
    } on CustomException catch (e) {
      emit(LoginStatus(
          data, MessageType.error, e.message, ShowOnScreen.signUpConfirmation));
    }
  }
}
