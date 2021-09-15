import 'package:flutter/material.dart';

void showCustomSnackbar(
    {required BuildContext context,
    required String text,
    required int duration}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        softWrap: true,
      ),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 75),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      duration: Duration(seconds: duration),
    ),
  );
}
