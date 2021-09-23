// ignore_for_file: non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'package:cool_shop/constants.dart';
import 'package:cool_shop/cubit/login/login_cubit.dart';
import 'package:cool_shop/ui/login_screens/reset_password_screen.dart';
import 'package:cool_shop/ui/verify_auth_status_screen.dart';
import 'package:cool_shop/ui/widgets/big_button.dart';
import 'package:cool_shop/ui/widgets/big_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInWidget extends StatefulWidget {
  const SignInWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInWidget> createState() => _SignInWidgetState();
}

class _SignInWidgetState extends State<SignInWidget> {
  String email = '';
  String password = '';
  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isLogged = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginStatus && state.messageType == MessageType.success) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const VerifyAuthStatusScreen(),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is LoginStatus) {
          email = state.data.email;
          password = state.data.password;
          isEmailValid = state.data.isEmailValid;
          isPasswordValid = state.data.isPasswordValid;
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BigTextField(
              text: email,
              type: TextFieldType.email,
              labelText: 'Email',
              errorText: 'Not a valid email address. Should be your@email.com',
              isValid: isEmailValid,
              onChanged: (value) {
                context.read<LoginCubit>().data.email = value;
                context.read<LoginCubit>().validateFields();
              },
            ),
            BigTextField(
              text: password,
              type: TextFieldType.password,
              labelText: 'Password',
              errorText:
                  'Password less 6 characters or contains wrong characters',
              isValid: isPasswordValid,
              onChanged: (value) {
                context.read<LoginCubit>().data.password = value;
                context.read<LoginCubit>().validateFields();
              },
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const ResetPasswordScreen(),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    'Forgot your password?',
                    style: AllStyles.dark14w400,
                  ),
                  SvgPicture.asset('assets/icons/small-arrow-right.svg'),
                ],
              ),
            ),
            const SizedBox(height: 28),
            BigButton(
              child: const Text(
                'LOGIN',
                style: AllStyles.bigButton,
              ),
              onPress: context.read<LoginCubit>().data.verifiedTwo
                  ? () {
                      context.read<LoginCubit>().signInWithEmailPassword();
                    }
                  : null,
            ),
          ],
        );
      },
    );
  }
}
