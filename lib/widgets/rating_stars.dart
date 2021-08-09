import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RatingStars extends StatelessWidget {
  const RatingStars({Key? key, required this.count}) : super(key: key);

  final int count;

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      children: [
        for (int i = 0; i < 5; i++)
          i < count
              ? SvgPicture.asset('assets/icons/star_yellow.svg')
              : SvgPicture.asset('assets/icons/star_gray.svg')
      ],
    );
  }
}
