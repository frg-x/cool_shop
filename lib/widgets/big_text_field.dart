// ignore_for_file: unused_import

import 'package:cool_shop/constants.dart';
import 'package:cool_shop/login_screens/sign_in_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BigTextField extends StatelessWidget {
  BigTextField({
    Key? key,
    required this.labelText,
    required this.errorText,
    required this.type,
    required this.onChanged,
    required this.text,
    required this.isValid,
  }) : super(key: key);

  final String labelText;
  final String errorText;
  final TextFieldType type;
  final Function onChanged;
  final String text;
  final bool isValid;

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final TextInputType _textInputType;

    if (type == TextFieldType.email) {
      _textInputType = TextInputType.emailAddress;
    } else if (type == TextFieldType.name) {
      _textInputType = TextInputType.text;
    } else {
      _textInputType = TextInputType.visiblePassword;
    }

    _controller.value = TextEditingValue(
      text: text,
      selection: TextSelection(
        baseOffset: text.length,
        extentOffset: text.length,
      ),
    );

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          padding: const EdgeInsets.only(bottom: 4),
          child: TextFormField(
            controller: _controller,
            onChanged: (value) => onChanged(value),
            onFieldSubmitted: (value) => onChanged(value),
            keyboardType: _textInputType,
            obscureText:
                _textInputType == TextInputType.visiblePassword ? true : false,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.always,
              alignLabelWithHint: true,
              errorText: text.isEmpty ? '' : (isValid ? '' : errorText),
              errorStyle: AllStyles.bigTextFieldError,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: text.isEmpty
                    ? BorderSide.none
                    : (isValid
                        ? BorderSide.none
                        : const BorderSide(color: AllColors.error, width: 1.0)),
              ),
              fillColor: AllColors.white,
              filled: true,
              suffixIcon: text.isEmpty
                  ? const Icon(
                      Icons.clear,
                      color: Colors.transparent,
                    )
                  : (isValid
                      ? const Icon(
                          Icons.check_outlined,
                          color: AllColors.success,
                          size: 28,
                        )
                      : const Icon(
                          Icons.clear,
                          color: AllColors.error,
                          size: 28,
                        )),
              isDense: true,
              contentPadding: const EdgeInsets.fromLTRB(20, 38, 24, 18),
            ),
            style: const TextStyle(
              color: AllColors.bigTextFieldTextColor,
              fontFamily: AllStrings.fontFamily,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            textAlignVertical: TextAlignVertical.bottom,
          ),
        ),
        Positioned(
          left: 18,
          top: 16,
          child: Text(
            labelText,
            style: AllStyles.bigTextFieldLabel,
          ),
        ),
        // Positioned(
        //   left: 18,
        //   top: 80,
        //   child: Text(
        //     errorText,
        //     style: AllStyles.bigTextFieldError,
        //   ),
        // ),
      ],
    );
  }
}
