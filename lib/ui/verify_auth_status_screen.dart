import 'package:cool_shop/constants.dart';
import 'package:cool_shop/cubit/login/login_cubit.dart';
import 'package:cool_shop/ui/login_screens/login_screen_switcher.dart';
import 'package:cool_shop/ui/tabs_screen.dart';
import 'package:cool_shop/ui/widgets/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyAuthStatusScreen extends StatelessWidget {
  const VerifyAuthStatusScreen({Key? key}) : super(key: key);

  static const namedRoute = '/';

  @override
  Widget build(BuildContext context) {
    bool isLogged;
    //print('VerifyAuthStatusScreen Builded!');
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginStatus && state.messageType == MessageType.error) {
          showCustomSnackbar(
              context: context, text: state.message, duration: 4);
        }
      },
      builder: (context, state) {
        //print(state);
        if (state is LoginStatus) {
          isLogged = state.data['isLogged'] ?? false;
          if (isLogged) {
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