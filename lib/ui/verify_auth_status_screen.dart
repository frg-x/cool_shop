import 'package:cool_shop/constants.dart';
import 'package:cool_shop/cubit/login/login_cubit.dart';
import 'package:cool_shop/ui/login_screens/login_screen.dart';
import 'package:cool_shop/ui/login_screens/sign_up_confirmation_screen.dart';
import 'package:cool_shop/ui/tabs_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyAuthStatusScreen extends StatelessWidget {
  const VerifyAuthStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLogged;
    bool isVerified;

    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        if (state is LoginStatus) {
          isLogged = state.data.isLogged ?? false;
          isVerified = state.data.isVerified ?? false;
          if (isLogged && isVerified) {
            return const TabsScreen();
          } else if (isLogged && !isVerified) {
            return const SignUpConfirmationScreen();
          } else {
            return const LoginScreen();
          }
        } else {
          return const ColoredBox(
            color: AllColors.appBackgroundColor,
            child: CupertinoActivityIndicator(),
          );
        }
      },
    );
  }
}
