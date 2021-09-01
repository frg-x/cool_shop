import 'package:cool_shop/constants.dart';
import 'package:flutter/material.dart';

class MediumButton extends StatelessWidget {
  const MediumButton({
    Key? key,
    required this.onPress,
    required this.text,
    required this.color,
  }) : super(key: key);

  final Function? onPress;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          color == AllColors.white
              ? BoxShadow(color: Colors.transparent)
              : BoxShadow(
                  color: AllColors.bigButtonShadow.withOpacity(0.25),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
        ],
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints.tightFor(height: 36, width: 160),
        child: TextButton(
          onPressed: onPress != null ? () => onPress!() : null,
          child: Text(
            text,
            style: color == AllColors.white
                ? AllStyles.dark14w500
                : AllStyles.white14w400,
          ),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: color == AllColors.white
                    ? BorderSide(
                        width: 1,
                        color: AllColors.dark,
                      )
                    : BorderSide.none,
              ),
            ),
            backgroundColor: MaterialStateProperty.all<Color>(color),
            overlayColor: MaterialStateProperty.all<Color>(color),
          ),
        ),
      ),
    );
  }
}
