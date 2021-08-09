import 'package:cool_shop/constants.dart';
import 'package:cool_shop/login_screens/cubit/login_cubit.dart';
import 'package:cool_shop/widgets/big_button.dart';
import 'package:cool_shop/widgets/big_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUp extends StatefulWidget {
  const SignUp({
    Key? key,
    required this.callback,
  }) : super(key: key);

  final Function callback;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String name = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        if (state is LoginData) {
          name = state.data['name'];
          email = state.data['email'];
          password = state.data['password'];
        }
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
              isValid: context.read<LoginCubit>().isNameValid,
              onChanged: (value) {
                context.read<LoginCubit>().name = value;
                context.read<LoginCubit>().validateFields();
              },
            ),
            BigTextField(
              text: email,
              type: TextFieldType.email,
              labelText: 'Email',
              errorText: 'Not a valid email address. Should be your@email.com',
              isValid: context.read<LoginCubit>().isEmailValid,
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
                  'Password less than 6 characters or contains wrong characters',
              isValid: context.read<LoginCubit>().isPasswordValid,
              onChanged: (value) {
                context.read<LoginCubit>().password = value;
                context.read<LoginCubit>().validateFields();
              },
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => widget.callback(1),
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
              text: 'SIGN UP',
              onPress: context.read<LoginCubit>().verifiedThree
                  ? () => print('Sign Up')
                  : null,
            ),
          ],
        );
      },
    );
  }
}
