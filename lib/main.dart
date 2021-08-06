// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:cool_shop/login_screens/cubit/cubit/login_cubit.dart';
import 'package:cool_shop/login_screens/login_widget.dart';
import 'package:cool_shop/constants.dart';
import 'package:cool_shop/login_screens/sign_up_widget.dart';
import 'package:cool_shop/widgets/social_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const CoolShop());
}

class CoolShop extends StatelessWidget {
  const CoolShop({Key? key}) : super(key: key);

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
        home: const LoginScreen(),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late int currentPageIndex;

  void selectPage(int page) {
    setState(() {
      currentPageIndex = page;
    });
  }

  List<Widget> get startPage => [
        SignUp(callback: selectPage),
        const Login(),
      ];

  @override
  void initState() {
    currentPageIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllColors.appBackgroundColor,
      body: Container(
        padding: const EdgeInsets.fromLTRB(14, 106, 14, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              //mainAxisSize: MainAxisSize.min,
              children: [
                const Spacer(flex: 1),
                GestureDetector(
                  onTap: () => selectPage(PageTypes.signUp.index),
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: currentPageIndex == PageTypes.signUp.index
                            ? const BorderSide(
                                color: AllColors.primary,
                                width: 2.0,
                                style: BorderStyle.solid,
                              )
                            : BorderSide.none,
                      ),
                    ),
                    child: Text(
                      'Sign up',
                      style: currentPageIndex == PageTypes.signUp.index
                          ? AllStyles.headlineActive
                          : AllStyles.headlineNotActive,
                    ),
                  ),
                ),
                const Spacer(flex: 2),
                GestureDetector(
                  onTap: () => selectPage(PageTypes.login.index),
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: currentPageIndex == PageTypes.login.index
                            ? const BorderSide(
                                color: AllColors.primary,
                                width: 2.0,
                                style: BorderStyle.solid,
                              )
                            : BorderSide.none,
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: currentPageIndex == PageTypes.login.index
                          ? AllStyles.headlineActive
                          : AllStyles.headlineNotActive,
                    ),
                  ),
                ),
                const Spacer(flex: 1),
              ],
            ),
            const SizedBox(height: 73),
            startPage[currentPageIndex],
          ],
        ),
      ),
      // ignore: sized_box_for_whitespace
      bottomNavigationBar: Container(
        height: 200,
        child: Column(
          children: [
            const Text(
              'Or sign up with social account',
              style: AllStyles.dark14w400,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                SocialCard(
                  image: 'assets/icons/google.svg',
                  onPress: () => print('Google'),
                ),
                const SizedBox(width: 16),
                SocialCard(
                  image: 'assets/icons/facebook.svg',
                  onPress: () => print('Facebook'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
