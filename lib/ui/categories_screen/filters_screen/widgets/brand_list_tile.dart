import 'package:cool_shop/constants.dart';
import 'package:flutter/material.dart';

class BrandListTile extends StatelessWidget {
  const BrandListTile({
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
      onTap: () => onPress(!isSelected),
      child: Container(
        height: 54,
        width: double.infinity,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style:
                  isSelected ? AllStyles.primary16w600 : AllStyles.dark16w400,
            ),
            Transform.scale(
              scale: 1.2,
              child: IgnorePointer(
                child: Checkbox(
                  value: isSelected,
                  onChanged: (_) {},
                  activeColor: AllColors.primary,
                  checkColor: AllColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  side: const BorderSide(
                    color: AllColors.gray,
                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
