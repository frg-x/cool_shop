import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AllColors {
  static const primary = Color(0xFFDB3022);
  static const appBackgroundColor = Color(0xFFF9F9F9);

  static const dark = Color(0xFF222222);
  static const white = Color(0xFFFFFFFF);
  static const bigButtonShadow = Color(0xFFD32626);
  static const error = Color(0xFFF01F0E);
  static const success = Color(0xFF2AA952);

  static const bigTextFieldLabelColor = Color(0xFF9B9B9B);
  static const bigTextFieldTextColor = Color(0xFF2D2D2D);
}

class AllStyles {
  static const headlineActive = TextStyle(
    fontSize: 34,
    fontWeight: FontWeight.w700,
  );

  static const headlineNotActive = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w300,
  );

  static const bigButton = TextStyle(
    color: AllColors.white,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const bigTextFieldError = TextStyle(
    color: AllColors.error,
    fontSize: 11,
    height: 0.5,
  );

  static const bigTextFieldLabel = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    fontFamily: AllStrings.fontFamily,
    color: AllColors.bigTextFieldLabelColor,
  );
  static const dark14w400 = TextStyle(
    color: AllColors.dark,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
}

class AllStrings {
  static const fontFamily = 'Metropolis';
}

enum TextFieldType {
  name,
  email,
  password,
}

enum PageTypes {
  signUp,
  login,
  forgotPassword,
}
