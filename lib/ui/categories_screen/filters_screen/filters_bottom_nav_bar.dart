import 'package:cool_shop/constants.dart';
import 'package:cool_shop/ui/widgets/medium_button.dart';
import 'package:flutter/material.dart';

class FiltersBottomNavBar extends StatelessWidget {
  const FiltersBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 104,
      decoration: BoxDecoration(
        color: AllColors.appBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -4),
            blurRadius: 8,
            color: AllColors.black.withOpacity(0.1),
          )
        ],
      ),
      padding: EdgeInsets.fromLTRB(16, 20, 16, 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MediumButton(
            onPress: () => Navigator.of(context).pop(),
            text: 'Discard',
            color: AllColors.white,
          ),
          MediumButton(
              onPress: () => print('Apply'),
              text: 'Apply',
              color: AllColors.primary),
        ],
      ),
    );
  }
}
