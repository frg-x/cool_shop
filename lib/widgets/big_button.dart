import 'package:cool_shop/constants.dart';
import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  const BigButton({
    Key? key,
    required this.onPress,
    required this.text,
  }) : super(key: key);

  final Function? onPress;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AllColors.bigButtonShadow.withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ConstrainedBox(
        constraints:
            const BoxConstraints.tightFor(height: 48, width: double.infinity),
        child: ElevatedButton(
          onPressed: onPress != null ? () => onPress!() : null,
          child: Text(
            text,
            style: AllStyles.bigButton,
          ),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
