import 'package:cool_shop/constants.dart';
import 'package:flutter/material.dart';

class ColoredCircle36x36 extends StatelessWidget {
  const ColoredCircle36x36({
    Key? key,
    required this.color,
    required this.isSelected,
    required this.onPress,
  }) : super(key: key);

  final Color color;
  final bool isSelected;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: Colors.white,
              border: isSelected
                  ? Border.all(
                      color: AllColors.primary,
                      width: 1.0,
                    )
                  : Border.all(color: Colors.transparent),
            ),
          ),
          Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
