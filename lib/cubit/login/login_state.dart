part of 'login_cubit.dart';

enum MessageType {
  logout,
  error,
  message,
  empty,
  success,
}

enum ShowOnScreen {
  byDefault,
  signIn,
  signUp,
  resetPassword,
  verifyEmail,
  newPassword,
  signUpConfirmation,
}

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginExit extends LoginState {}

class LoginLoading extends LoginState {}

class LoginStatus extends LoginState {
  LoginStatus(
    this.data,
    this.messageType,
    this.message,
    this.showOnScreen,
  );
  final String message;
  final MessageType messageType;
  final Data data;
  final ShowOnScreen showOnScreen;

  // @override
  // List<Object?> get props => [data];

  //bool operator ==(o) => o is LoginStatus && data == o.data;
  // @override
  // bool operator ==(Object other) => other is LoginStatus && other.data == data;

  // @override
  // int get hashCode => data.hashCode;
}
