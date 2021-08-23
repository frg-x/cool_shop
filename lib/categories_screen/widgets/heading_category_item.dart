import 'package:cool_shop/constants.dart';
import 'package:flutter/material.dart';

class HeadingCategoryItem extends StatelessWidget {
  const HeadingCategoryItem({
    Key? key,
    required this.currentTabNumber,
    required this.tabNumber,
    required this.title,
    required this.onPress,
  }) : super(key: key);

  final int currentTabNumber;
  final int tabNumber;
  final String title;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress(),
      child: Container(
        width: MediaQuery.of(context).size.width / 3,
        child: Center(
          child: Text(
            title,
            style: currentTabNumber == tabNumber
                ? AllStyles.dark16w600
                : AllStyles.dark16w400,
          ),
        ),
        decoration: BoxDecoration(
          border: currentTabNumber == tabNumber
              ? const Border(
                  bottom: BorderSide(
                    width: 3.0,
                    color: AllColors.primary,
                  ),
                )
              : const Border(
                  bottom: BorderSide(
                    width: 3.0,
                    color: AllColors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
