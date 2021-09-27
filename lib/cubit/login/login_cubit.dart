import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:cool_shop/constants.dart';
import 'package:cool_shop/cubit/login/models/data.dart';
import 'package:cool_shop/cubit/tab_switching/tab_switching_cubit.dart';
import 'package:cool_shop/main.dart';
import 'package:cool_shop/utilities/network_service.dart';
import 'package:cool_shop/utilities/secure_storage.dart';
import 'package:dio/dio.dart';
import 'package:string_validator/string_validator.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial()) {
    checkLoginState();
  }

  Data data = Data(
    userId: '',
    userName: '',
    email: '',
    password: '',
    verifyCode: '',
    isNameValid: false,
    isEmailValid: false,
    isPasswordValid: false,
    verifiedOne: false,
    verifiedTwo: false,
    verifiedThree: false,
    isCodeFilled: false,
    isLogged: false,
    isVerified: false,
    currentLoginTab: 0,
  );

  final _networkService = getIt<NetworkService>();

  void setLoginTab(int page) {
    data.currentLoginTab = page;
    emit(LoginStatus(data, MessageType.empty, '', ShowOnScreen.byDefault));
  }

  void setVerifyCode(String text) {
    data.verifyCode = text;
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
    Map? responseData = await _networkService
        .getRequest(GlobalUrls.getPersonById + '/${data.userId}');
    print(responseData);
  }

  void signInWithEmailPassword() async {
    try {
      Map? responseData =
          await _networkService.login(data.email, data.password);
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

          emit(
            LoginStatus(data, MessageType.success, '', ShowOnScreen.signIn),
          );
        } else {
          emit(LoginStatus(data, MessageType.error, responseData['message'],
              ShowOnScreen.signIn));
        }
      }
    } on Exception catch (e) {
      emit(LoginStatus(
          data, MessageType.error, e.toString(), ShowOnScreen.signIn));
    }
  }

  void sendCodeToResetPassword() async {
    data.verifyCode = '';
    try {
      Map? responseData = await _networkService.postRequest(
        GlobalUrls.sendEmailToRecoverPassword,
        jsonEncode({
          "email": data.email,
        }),
      );
      if (responseData != null) {
        if (responseData['success']) {
          emit(
            LoginStatus(
              data,
              MessageType.success,
              responseData['message'] ?? 'Success',
              ShowOnScreen.resetPassword,
            ),
          );
        } else {
          emit(LoginStatus(
            data,
            MessageType.error,
            responseData['message'],
            ShowOnScreen.resetPassword,
          ));
        }
      }
    } on Exception catch (e) {
      emit(LoginStatus(
        data,
        MessageType.error,
        e.toString(),
        ShowOnScreen.resetPassword,
      ));
    }
  }

  void resendSignUpVerifyToken() async {
    data.verifyCode = '';
    try {
      Map? responseData = await _networkService.postRequest(
        GlobalUrls.resendVerifyToken,
        jsonEncode({
          "email": data.email,
        }),
      );
      if (responseData != null) {
        if (responseData['success']) {
          emit(
            LoginStatus(
              data,
              MessageType.success,
              responseData['message'] ?? 'Success',
              ShowOnScreen.verifyEmail,
            ),
          );
        } else {
          emit(LoginStatus(
            data,
            MessageType.error,
            responseData['message'],
            ShowOnScreen.verifyEmail,
          ));
        }
      }
    } on Exception catch (e) {
      emit(LoginStatus(
        data,
        MessageType.error,
        e.toString(),
        ShowOnScreen.resetPassword,
      ));
    }
  }

  void verifyEmailByCode(String newPassword) async {
    try {
      Map? responseData = await _networkService.postRequest(
        GlobalUrls.resetPassword,
        jsonEncode({
          "password": newPassword,
          "confirmPassword": newPassword,
          "resetPasswordToken": data.verifyCode,
        }),
      );
      if (responseData != null) {
        data.verifyCode = '';
        data.password = newPassword;
        data.isEmailValid = true;
        data.isPasswordValid = true;
        validateFields();
        if (responseData['success'] == true) {
          emit(
            LoginStatus(
              data,
              MessageType.success,
              responseData['message'],
              ShowOnScreen.newPassword,
            ),
          );
        } else {
          emit(LoginStatus(
            data,
            MessageType.error,
            responseData['message'],
            ShowOnScreen.newPassword,
          ));
        }
      }
    } on Exception catch (e) {
      emit(LoginStatus(
        data,
        MessageType.error,
        e.toString(),
        ShowOnScreen.newPassword,
      ));
    }
  }

  void signUp() async {
    try {
      Map? responseData = await _networkService.postRequest(
        GlobalUrls.createUserEndpoint,
        jsonEncode({
          "userName": data.userName,
          "email": data.email,
          "password": data.password,
          "confirmPassword": data.password,
        }),
      );
      if (responseData != null) {
        if (responseData['success']) {
          data.currentLoginTab = 0;
          emit(
            LoginStatus(
              data,
              MessageType.success,
              responseData['message'],
              ShowOnScreen.signUp,
            ),
          );
        } else {
          emit(LoginStatus(
            data,
            MessageType.error,
            responseData['message'],
            ShowOnScreen.signUp,
          ));
        }
      }
    } on Exception catch (e) {
      emit(LoginStatus(
        data,
        MessageType.error,
        e.toString(),
        ShowOnScreen.signUp,
      ));
    }
  }

  void verifyNewUser() async {
    try {
      Map? responseData = await _networkService.getRequest(
          GlobalUrls.verifyNewUser +
              '/UserId/${data.userId}/Token/${data.verifyCode}');
      if (responseData != null) {
        if (responseData['success']) {
          data.isVerified = true;
          await SecureStorageService.write(
              SecureStorageKey.isVerified, data.isVerified.toString());
          emit(
            LoginStatus(
              data,
              MessageType.success,
              responseData['message'],
              ShowOnScreen.signUpConfirmation,
            ),
          );
        } else {
          emit(LoginStatus(
            data,
            MessageType.error,
            responseData['message'],
            ShowOnScreen.signUpConfirmation,
          ));
        }
      }
    } on DioError catch (e) {
      Response<dynamic>? r = e.response;
      Map<String, dynamic> responseData = jsonDecode(r!.data);
      if (r.statusCode == 400) {
        Map<String, dynamic> errors = responseData['errors'];
        emit(LoginStatus(
          data,
          MessageType.error,
          errors['token'][0],
          ShowOnScreen.signUpConfirmation,
        ));
      }
    } on Exception catch (e) {
      emit(LoginStatus(
        data,
        MessageType.error,
        e.toString(),
        ShowOnScreen.signUpConfirmation,
      ));
    }
  }
}
