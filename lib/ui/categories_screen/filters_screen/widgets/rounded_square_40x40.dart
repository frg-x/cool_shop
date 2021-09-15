import 'package:cool_shop/constants.dart';
import 'package:flutter/material.dart';

class RoundedSquare40x40 extends StatelessWidget {
  const RoundedSquare40x40({
    Key? key,
    required this.size,
    required this.isSelected,
    required this.onPress,
  }) : super(key: key);

  final String size;
  final bool isSelected;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress(),
      child: Container(
        height: 40,
        width: 40,
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
          size,
          style: isSelected ? AllStyles.white14w400 : AllStyles.dark14w400,
        ),
      ),
    );
  }
}
