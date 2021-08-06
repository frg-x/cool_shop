import 'package:cool_shop/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialCard extends StatelessWidget {
  const SocialCard({
    Key? key,
    required this.image,
    required this.onPress,
  }) : super(key: key);

  final String image;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress(),
      child: Container(
        width: 92,
        height: 64,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: AllColors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 1),
                blurRadius: 8,
              )
            ]),
        child: Center(
          child: SvgPicture.asset(image),
        ),
      ),
    );
  }
}
