import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.data) : super(LoginInitial());

  String name = '';
  String email = '';
  String password = '';

  bool isNameValid = false;
  bool isEmailValid = false;
  bool isPasswordValid = false;

  bool verifiedOne = false;
  bool verifiedTwo = false;
  bool verifiedThree = false;

  final Map<String, dynamic> data;

  void validateFields() {
    isNameValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!-_]+").hasMatch(name) &&
        name.length >= 6;
    isEmailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
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
      'name': name,
      'email': email,
      'password': password,
      'isNameValid': isNameValid,
      'isEmailValid': isEmailValid,
      'isPasswordValid': isPasswordValid,
    });

    emit(LoginData(data));
  }
}
