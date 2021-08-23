import 'package:cool_shop/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onPress,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress(),
      child: ColoredBox(
        color: AllColors.appBackgroundColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(17),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AllStyles.dark16w600),
                      const SizedBox(height: 9),
                      Text(
                        subtitle,
                        style: AllStyles.gray11,
                      ),
                    ],
                  ),
                  SvgPicture.asset('assets/icons/arrow_forward.svg'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
