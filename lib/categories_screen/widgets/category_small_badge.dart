import 'package:cool_shop/constants.dart';
import 'package:flutter/material.dart';

class CategorySmallBadge extends StatelessWidget {
  const CategorySmallBadge({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: Text(
        title,
        style: AllStyles.white14w400,
      ),
      padding: EdgeInsets.fromLTRB(25, 8, 25, 7),
      decoration: BoxDecoration(
        color: AllColors.dark,
        borderRadius: BorderRadius.circular(29),
      ),
    );
  }
}
