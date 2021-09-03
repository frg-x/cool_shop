import 'package:cool_shop/constants.dart';
import 'package:flutter/material.dart';

class RoundedSquareCategory extends StatelessWidget {
  RoundedSquareCategory({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onPress,
  }) : super(key: key);

  final String title;
  final bool isSelected;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress(),
      child: Container(
        height: 40,
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? AllColors.primary : AllColors.white,
          border: isSelected
              ? Border.all(color: Colors.transparent)
              : Border.all(
                  color: AllColors.gray,
                  width: 0.4,
                ),
        ),
        child: Text(
          title,
          style: isSelected ? AllStyles.white14w400 : AllStyles.dark14w400,
        ),
      ),
    );
  }
}
