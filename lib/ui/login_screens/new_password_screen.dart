// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cool_shop/constants.dart';
import 'package:cool_shop/cubit/login/login_cubit.dart';
import 'package:cool_shop/ui/login_screens/login_screen.dart';
import 'package:cool_shop/ui/widgets/big_button.dart';
import 'package:cool_shop/ui/widgets/big_text_field.dart';
import 'package:cool_shop/ui/widgets/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  _NewPasswordScreenState createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  String password = '';
  String confirmPassword = '';

  bool verifyPasswords() {
    if (password.isNotEmpty && confirmPassword.isNotEmpty) {
      return password == confirmPassword;
    }
    return false;
  }

  bool isConfirmPasswordValid() {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&*]+")
            .hasMatch(confirmPassword) &&
        confirmPassword.length >= 6;
  }

  bool isPasswordValid() {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&*]+").hasMatch(password) &&
        password.length >= 6;
  }

  @override
  Widget build(BuildContext context) {
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
        child: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            //print('new password screen state: $state');
            if (state is LoginStatus &&
                state.messageType == MessageType.success &&
                state.showOnScreen == ShowOnScreen.newPassword) {
              showCustomSnackbar(
                  context: context, text: state.message, duration: 3);
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
              );
            }
          },
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
                          'New ',
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
              const SizedBox(height: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BigTextField(
                    text: password,
                    type: TextFieldType.password,
                    labelText: 'New password',
                    errorText:
                        'Password less 6 characters or contains wrong characters',
                    isValid: isPasswordValid(),
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                  ),
                  BigTextField(
                    text: confirmPassword,
                    type: TextFieldType.password,
                    labelText: 'Repeat password',
                    errorText:
                        'Password less 6 characters or contains wrong characters',
                    isValid: isConfirmPasswordValid(),
                    onChanged: (value) {
                      setState(() {
                        confirmPassword = value;
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  (verifyPasswords() ||
                          !(password.isNotEmpty || confirmPassword.isNotEmpty))
                      ? const Text('')
                      : const Text(
                          'Passwords are not matched',
                          style: AllStyles.primary14w400,
                        ),
                  const SizedBox(height: 55),
                  BigButton(
                    child: const Text(
                      'SAVE',
                      style: AllStyles.bigButton,
                    ),
                    onPress: verifyPasswords()
                        ? () =>
                            context.read<LoginCubit>().saveNewPassword(password)
                        : null,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
