// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:cool_shop/login_screens/cubit/login_cubit.dart';
import 'package:cool_shop/login_screens/login_screen_switcher.dart';
import 'package:cool_shop/constants.dart';
import 'package:cool_shop/tabs_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// ignore: unused_import
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const CoolShop(isLogged: false));
}

class CoolShop extends StatelessWidget {
  const CoolShop({Key? key, required this.isLogged}) : super(key: key);

  final bool isLogged;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit({}),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cool Shop',
        theme: ThemeData(
          fontFamily: AllStrings.fontFamily,
          colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: AllColors.primary,
              ),
        ),
        home: isLogged ? const TabsScreen() : const LoginScreenSwitcher(),
      ),
    );
  }
}
