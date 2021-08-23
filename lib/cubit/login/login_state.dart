part of 'login_cubit.dart';

enum MessageType {
  logout,
  error,
  message,
  empty,
  success,
}

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginExit extends LoginState {}

class LoginStatus extends LoginState {
  LoginStatus(this.data, this.messageType, this.message);
  final String message;
  final MessageType messageType;
  final Map<String, dynamic> data;

  // @override
  // List<Object?> get props => [data];

  //bool operator ==(o) => o is LoginStatus && data == o.data;
  // @override
  // bool operator ==(Object other) => other is LoginStatus && other.data == data;

  // @override
  // int get hashCode => data.hashCode;
}
