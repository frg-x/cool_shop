import 'package:cool_shop/constants.dart';
import 'package:cool_shop/ui/login_screens/login_screen_navbar.dart';
import 'package:cool_shop/ui/login_screens/sign_up_widget.dart';
import 'package:flutter/material.dart';

import 'sign_in_widget.dart';

class LoginScreenSwitcher extends StatefulWidget {
  const LoginScreenSwitcher({Key? key}) : super(key: key);

  @override
  _LoginScreenSwitcherState createState() => _LoginScreenSwitcherState();
}

class _LoginScreenSwitcherState extends State<LoginScreenSwitcher> {
  late int currentPageIndex;

  void selectPage(int page) {
    setState(() {
      currentPageIndex = page;
    });
  }

  List<Widget> get startPage => [
        const SignIn(),
        SignUp(callback: selectPage),
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
      bottomNavigationBar: const LoginScreenNavBar(),
      body: BodySwitcher(
        callback: selectPage,
        currentPageIndex: currentPageIndex,
        renderLoginWidget: startPage[currentPageIndex],
      ),
    );
  }
}

class BodySwitcher extends StatelessWidget {
  const BodySwitcher({
    Key? key,
    required this.callback,
    required this.currentPageIndex,
    required this.renderLoginWidget,
  }) : super(key: key);

  final Function callback;
  final int currentPageIndex;
  final Widget renderLoginWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 90, 14, 0),
      //! padding: const EdgeInsets.fromLTRB(14, 46, 14, 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(flex: 1),
                GestureDetector(
                  onTap: () => callback(PageTypes.signIn.index),
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: currentPageIndex == PageTypes.signIn.index
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
                      style: currentPageIndex == PageTypes.signIn.index
                          ? AllStyles.headlineActive
                          : AllStyles.headlineNotActive,
                    ),
                  ),
                ),
                const Spacer(flex: 2),
                GestureDetector(
                  onTap: () => callback(PageTypes.signUp.index),
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
                      'Sign Up',
                      style: currentPageIndex == PageTypes.signUp.index
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
            renderLoginWidget,
            //! old value const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
