import 'package:cool_shop/constants.dart';
import 'package:cool_shop/cubit/login/login_cubit.dart';
import 'package:cool_shop/ui/widgets/big_button.dart';
import 'package:cool_shop/ui/widgets/big_text_field.dart';
import 'package:cool_shop/ui/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  String name = '';
  String email = '';
  String password = '';
  bool isNameValid = false;
  bool isEmailValid = false;
  bool isPasswordValid = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        if (state is LoginStatus) {
          name = state.data.userName;
          email = state.data.email;
          password = state.data.password;
          isNameValid = state.data.isNameValid;
          isEmailValid = state.data.isEmailValid;
          isPasswordValid = state.data.isPasswordValid;

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BigTextField(
                text: name,
                type: TextFieldType.name,
                labelText: 'Name',
                errorText:
                    'Not a valid username or Name is less than 6 characters',
                isValid: context.read<LoginCubit>().data.isNameValid,
                onChanged: (value) {
                  context.read<LoginCubit>().data.userName = value;
                  context.read<LoginCubit>().validateFields();
                },
              ),
              BigTextField(
                text: email,
                type: TextFieldType.email,
                labelText: 'Email',
                errorText:
                    'Not a valid email address. Should be your@email.com',
                isValid: context.read<LoginCubit>().data.isEmailValid,
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
                    'Password less than 6 characters or contains wrong characters',
                isValid: context.read<LoginCubit>().data.isPasswordValid,
                onChanged: (value) {
                  context.read<LoginCubit>().data.password = value;
                  context.read<LoginCubit>().validateFields();
                },
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => context
                    .read<LoginCubit>()
                    .setLoginTab(PageTypes.signIn.index),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      'Already have an account?',
                      style: AllStyles.dark14w400,
                    ),
                    SvgPicture.asset('assets/icons/small-arrow-right.svg'),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              BigButton(
                child: const Text(
                  'SIGN UP',
                  style: AllStyles.bigButton,
                ),
                onPress: context.read<LoginCubit>().data.verifiedThree
                    ? () {
                        context.read<LoginCubit>().signUp();
                      }
                    : null,
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
