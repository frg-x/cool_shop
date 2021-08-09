import 'package:cool_shop/constants.dart';
import 'package:flutter/material.dart';

class DiscountLabel extends StatelessWidget {
  const DiscountLabel({Key? key, required this.percentText}) : super(key: key);

  final String percentText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(29.0),
        color: AllColors.primary,
      ),
      child: Text(percentText, style: AllStyles.discountLabel),
    );
  }
}
