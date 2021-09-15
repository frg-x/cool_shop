import 'package:cool_shop/constants.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onPress,
    required this.width,
  }) : super(key: key);

  final String title;
  final bool isSelected;
  final Function onPress;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress(),
      child: Container(
        height: 40,
        width: width,
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
