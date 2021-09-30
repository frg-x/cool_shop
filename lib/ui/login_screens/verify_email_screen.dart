// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cool_shop/constants.dart';
import 'package:cool_shop/cubit/login/login_cubit.dart';
import 'package:cool_shop/main.dart';
import 'package:cool_shop/ui/login_screens/new_password_screen.dart';
import 'package:cool_shop/ui/widgets/big_button.dart';
import 'package:cool_shop/ui/widgets/big_text_field.dart';
import 'package:cool_shop/ui/widgets/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);

  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  String code = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AllColors.appBackgroundColor,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(CupertinoIcons.back, color: AllColors.dark),
        ),
      ),
      backgroundColor: AllColors.appBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
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
              BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  if (state is LoginStatus) {
                    code = state.data.verifyCode ?? '';
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigTextField(
                          text: code,
                          type: TextFieldType.code,
                          labelText: 'Code',
                          errorText: '',
                          isValid: context.read<LoginCubit>().data.isCodeValid,
                          onChanged: (value) {
                            context.read<LoginCubit>().validateCode(value);
                            context.read<LoginCubit>().validateFields();
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
                              onTap: () => showCustomSnackbar(
                                  context: context,
                                  text: 'Function was not implemented',
                                  duration: 3),
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
                              ? () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const NewPasswordScreen(),
                                    ),
                                  )
                              : null,
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
