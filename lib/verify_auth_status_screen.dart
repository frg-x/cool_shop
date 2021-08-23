import 'package:cool_shop/constants.dart';
import 'package:cool_shop/cubit/login/login_cubit.dart';
import 'package:cool_shop/login_screens/login_screen_switcher.dart';
import 'package:cool_shop/tabs_screen.dart';
import 'package:cool_shop/widgets/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyAuthStatusScreen extends StatelessWidget {
  const VerifyAuthStatusScreen({Key? key}) : super(key: key);

  static const namedRoute = '/';

  @override
  Widget build(BuildContext context) {
    bool isLogged;
    //context.read<LoginCubit>().getLoginState();
    //print('VerifyAuthStatusScreen Builded!');
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginStatus && state.messageType == MessageType.error) {
          CustomSnackbar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is LoginStatus) {
          isLogged = state.data['isLogged'] ?? false;
          if (isLogged) {
            //return const TestWidget();
            return const TabsScreen();
          } else {
            return const LoginScreenSwitcher();
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

class TestWidget extends StatelessWidget {
  const TestWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton(
          child: const Text('SignOut'),
          onPressed: () => context.read<LoginCubit>().signOut(),
        ),
      )),
    );
  }
}
