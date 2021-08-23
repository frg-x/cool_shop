// ignore_for_file: non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'package:cool_shop/constants.dart';
import 'package:cool_shop/cubit/login/login_cubit.dart';
import 'package:cool_shop/login_screens/forgot_password_screen.dart';
import 'package:cool_shop/widgets/big_button.dart';
import 'package:cool_shop/widgets/big_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignIn extends StatefulWidget {
  const SignIn({
    Key? key,
  }) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email = '';
  String password = '';
  bool isEmailValid = false;
  bool isPasswordValid = false;
  bool isLogged = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      // listener: (context, state) {
      //   if (state is LoginStatus) {
      //     if (state.messageType == MessageType.error) {
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         SnackBar(
      //           content: Text(
      //             state.message,
      //             softWrap: true,
      //           ),
      //           behavior: SnackBarBehavior.floating,
      //           margin: const EdgeInsets.fromLTRB(20, 0, 20, 75),
      //           shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(8)),
      //         ),
      //       );
      //     }
      //   }
      // },
      builder: (context, state) {
        if (state is LoginStatus) {
          email = state.data['email'];
          password = state.data['password'];
          isEmailValid = state.data['isEmailValid'];
          isPasswordValid = state.data['isPasswordValid'];
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
                context.read<LoginCubit>().email = value;
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
                context.read<LoginCubit>().password = value;
                context.read<LoginCubit>().validateFields();
              },
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const ForgotPassword(),
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
              text: 'LOGIN',
              onPress: context.read<LoginCubit>().verifiedTwo
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
