// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cool_shop/constants.dart';
import 'package:cool_shop/cubit/login/login_cubit.dart';
import 'package:cool_shop/ui/tabs_screen.dart';
import 'package:cool_shop/ui/widgets/big_button.dart';
import 'package:cool_shop/ui/widgets/big_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpConfirmationScreen extends StatefulWidget {
  const SignUpConfirmationScreen({Key? key}) : super(key: key);

  @override
  _SignUpConfirmationScreenState createState() =>
      _SignUpConfirmationScreenState();
}

class _SignUpConfirmationScreenState extends State<SignUpConfirmationScreen> {
  String code = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AllColors.appBackgroundColor,
      ),
      backgroundColor: AllColors.appBackgroundColor,
      body: Container(
        //padding: const EdgeInsets.fromLTRB(14, 106, 14, 0),
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      const Text(
                        'Verify ',
                        style: AllStyles.headlineNotActive,
                      ),
                      const Text(
                        'Email',
                        style: AllStyles.headlineActive,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            //const SizedBox(height: 87),
            Text(
              'We just sent a verification code on your email. Please enter it below',
              style: AllStyles.dark14w400.copyWith(height: 1.42),
            ),
            const SizedBox(height: 16),
            BlocListener<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginStatus &&
                    state.messageType == MessageType.success) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const TabsScreen(),
                    ),
                  );
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigTextField(
                    text: code,
                    type: TextFieldType.code,
                    labelText: '',
                    errorText: '',
                    isValid: true,
                    onChanged: (value) =>
                        context.read<LoginCubit>().setVerifyCode(value),
                  ),
                  const SizedBox(height: 70),
                  BigButton(
                    child: const Text(
                      'CONTINUE',
                      style: AllStyles.bigButton,
                    ),
                    onPress: () => context.read<LoginCubit>().verifyNewUser(),
                  ),
                  const SizedBox(height: 24),
                  BigButton(
                    child: const Text(
                      'SIGN OUT',
                      style: AllStyles.bigButton,
                    ),
                    onPress: () => context.read<LoginCubit>().signOut(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
