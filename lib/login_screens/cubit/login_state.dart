part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginData extends LoginState {
  LoginData(this.data);
  final Map<String, dynamic> data;
}
