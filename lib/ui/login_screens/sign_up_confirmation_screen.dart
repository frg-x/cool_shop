// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cool_shop/constants.dart';
import 'package:cool_shop/cubit/login/login_cubit.dart';
import 'package:cool_shop/main.dart';
import 'package:cool_shop/ui/verify_auth_status_screen.dart';
import 'package:cool_shop/ui/widgets/big_button.dart';
import 'package:cool_shop/ui/widgets/big_text_field.dart';
import 'package:cool_shop/ui/widgets/custom_snackbar.dart';
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
  @override
  Widget build(BuildContext context) {
    context.read<LoginCubit>().validateCode('');
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AllColors.appBackgroundColor,
      ),
      backgroundColor: AllColors.appBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
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
              BlocConsumer<LoginCubit, LoginState>(
                listener: (context, state) {
                  if (state is LoginStatus &&
                      state.messageType == MessageType.error &&
                      state.showOnScreen == ShowOnScreen.signUpConfirmation) {
                    showCustomSnackbar(
                        context: context, text: state.message, duration: 3);
                  }
                  if (state is LoginStatus &&
                      state.messageType == MessageType.success &&
                      state.showOnScreen == ShowOnScreen.signUpConfirmation) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const VerifyAuthStatusScreen(),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is LoginStatus) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigTextField(
                          text: getIt<LoginCubit>().getVerifyCode!,
                          type: TextFieldType.code,
                          labelText: 'Code',
                          errorText: '',
                          isValid: state.data.isCodeValid,
                          onChanged: (value) {
                            context.read<LoginCubit>().validateCode(value);
                          },
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Didn\'t receive email? ',
                              style:
                                  AllStyles.dark14w400.copyWith(height: 1.42),
                            ),
                            GestureDetector(
                              onTap: () {
                                context
                                    .read<LoginCubit>()
                                    .resendSignUpVerifyToken();
                                showCustomSnackbar(
                                  context: context,
                                  text:
                                      'We just sent a verification code on your email. Please enter it below',
                                  duration: 3,
                                );
                              },
                              child: const Text(
                                'Resend ',
                                style: AllStyles.dark14w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 55),
                        BigButton(
                          child: const Text(
                            'CONTINUE',
                            style: AllStyles.bigButton,
                          ),
                          onPress: getIt<LoginCubit>().data.isCodeValid
                              ? () => getIt<LoginCubit>().verifyNewUser()
                              : null,
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
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
