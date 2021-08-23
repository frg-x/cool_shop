// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cool_shop/constants.dart';
import 'package:cool_shop/cubit/login/login_cubit.dart';
import 'package:cool_shop/widgets/big_button.dart';
import 'package:cool_shop/widgets/big_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email = '';
  String password = '';
  bool isEmailValid = false;
  bool isPasswordValid = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cool Shop',
      theme: ThemeData(
        fontFamily: AllStrings.fontFamily,
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: AllColors.primary,
            ),
      ),
      home: Scaffold(
        backgroundColor: AllColors.appBackgroundColor,
        body: Container(
          padding: const EdgeInsets.fromLTRB(14, 106, 14, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: const Text(
                      'Forgot Password',
                      style: AllStyles.headlineActive,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 87),
              Text(
                'Please, enter your email address. You will receive a link to create a new password via email.',
                style: AllStyles.dark14w400.copyWith(height: 1.42),
              ),
              const SizedBox(height: 16),
              BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  if (state is LoginStatus) {
                    email = state.data['email'];
                    password = state.data['password'];
                    isEmailValid = state.data['isEmailValid'];
                    isPasswordValid = state.data['isEmailValid'];
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigTextField(
                        text: email,
                        type: TextFieldType.email,
                        labelText: 'Email',
                        errorText:
                            'Not a valid email address. Should be your@email.com',
                        isValid: isEmailValid,
                        onChanged: (value) {
                          context.read<LoginCubit>().email = value;
                          context.read<LoginCubit>().validateFields();
                        },
                      ),
                      const SizedBox(height: 70),
                      BigButton(
                        text: 'SEND',
                        onPress: () => print('SEND'),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
