import 'package:cool_shop/constants.dart';
import 'package:cool_shop/cubit/login/login_cubit.dart';
import 'package:cool_shop/ui/login_screens/widgets/login_screen_navbar.dart';
import 'package:cool_shop/ui/login_screens/widgets/sign_up_widget.dart';
import 'package:cool_shop/ui/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/sign_in_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late int currentPageIndex;

  List<Widget> loginTabs = [
    const SignInWidget(),
    const SignUpWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (_, state) {
        if (state is LoginStatus && state.messageType == MessageType.error) {
          // print(state.message);
          // print(state.messageType);
          // print(state.showOnScreen);
          showCustomSnackbar(
              context: context, text: state.message, duration: 3);
        }
        if (state is LoginStatus && state.messageType == MessageType.success) {
          // print(state.message);
          // print(state.messageType);
          // print(state.showOnScreen);
          showCustomSnackbar(
              context: context, text: state.message, duration: 2);
        }
      },
      builder: (context, state) {
        int currentPageIndex = context.read<LoginCubit>().data.currentLoginTab;
        return Scaffold(
          backgroundColor: AllColors.appBackgroundColor,
          bottomNavigationBar: const LoginScreenNavBar(),
          body: BodySwitcher(
            body: loginTabs.elementAt(currentPageIndex),
            index: currentPageIndex,
          ),
        );
      },
    );
  }
}

class BodySwitcher extends StatelessWidget {
  const BodySwitcher({
    required this.body,
    required this.index,
    Key? key,
  }) : super(key: key);

  final Widget body;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(14, 90, 14, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(flex: 1),
              GestureDetector(
                onTap: () => context
                    .read<LoginCubit>()
                    .setLoginTab(PageTypes.signIn.index),
                child: Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: index == PageTypes.signIn.index
                          ? const BorderSide(
                              color: AllColors.primary,
                              width: 2.0,
                              style: BorderStyle.solid,
                            )
                          : BorderSide.none,
                    ),
                  ),
                  child: Text(
                    'Sign In',
                    style: index == PageTypes.signIn.index
                        ? AllStyles.headlineActive
                        : AllStyles.headlineNotActive,
                  ),
                ),
              ),
              const Spacer(flex: 2),
              GestureDetector(
                onTap: () => context
                    .read<LoginCubit>()
                    .setLoginTab(PageTypes.signUp.index),
                child: Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: index == PageTypes.signUp.index
                          ? const BorderSide(
                              color: AllColors.primary,
                              width: 2.0,
                              style: BorderStyle.solid,
                            )
                          : BorderSide.none,
                    ),
                  ),
                  child: Text(
                    'Sign Up',
                    style: index == PageTypes.signUp.index
                        ? AllStyles.headlineActive
                        : AllStyles.headlineNotActive,
                  ),
                ),
              ),
              const Spacer(flex: 1),
            ],
          ),
          //! old value const SizedBox(height: 73),
          const SizedBox(height: 33),
          body,
          //! old value const SizedBox(height: 40),
        ],
      ),
    );
  }
}
