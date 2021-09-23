// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cool_shop/constants.dart';
import 'package:cool_shop/cubit/login/login_cubit.dart';
import 'package:cool_shop/ui/login_screens/verify_email_screen.dart';
import 'package:cool_shop/ui/widgets/big_button.dart';
import 'package:cool_shop/ui/widgets/big_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  String email = '';
  bool isEmailValid = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginStatus &&
            state.messageType == MessageType.success &&
            state.showOnScreen == ShowOnScreen.resetPassword) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const VerifyEmailScreen(),
            ),
          );
        }
      },
      builder: (context, state) {
        email = context.read<LoginCubit>().data.email;
        isEmailValid = context.read<LoginCubit>().data.isEmailValid;
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AllColors.appBackgroundColor,
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(CupertinoIcons.back, color: AllColors.dark),
            ),
          ),
          backgroundColor: AllColors.appBackgroundColor,
          body: Container(
            //padding: const EdgeInsets.fromLTRB(14, 106, 14, 0),
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
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
                            'Reset ',
                            style: AllStyles.headlineNotActive,
                          ),
                          const Text(
                            'Password',
                            style: AllStyles.headlineActive,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                //const SizedBox(height: 87),
                Text(
                  'Please, enter your email address. You will receive a link to create a new password via email.',
                  style: AllStyles.dark14w400.copyWith(height: 1.42),
                ),
                const SizedBox(height: 16),
                Column(
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
                        context.read<LoginCubit>().data.email = value;
                        context.read<LoginCubit>().validateFields();
                      },
                    ),
                    const SizedBox(height: 70),
                    BigButton(
                      child: const Text('RESET'),
                      onPress: isEmailValid
                          ? () {
                              context
                                  .read<LoginCubit>()
                                  .sendCodeToResetPassword();
                            }
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
