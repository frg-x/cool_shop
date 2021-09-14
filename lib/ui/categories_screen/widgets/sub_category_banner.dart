// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cool_shop/constants.dart';
import 'package:flutter/material.dart';

class SubCategoryBanner extends StatelessWidget {
  const SubCategoryBanner({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('SUMMER SALES', style: AllStyles.white24w600),
          const SizedBox(height: 6),
          const Text('Up to 50% off', style: AllStyles.white14w500),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AllColors.primary,
      ),
    );
  }
}
