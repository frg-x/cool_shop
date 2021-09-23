import 'package:cool_shop/constants.dart';
import 'package:cool_shop/cubit/favorites/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({
    Key? key,
    required this.isFav,
    required this.productId,
  }) : super(key: key);

  final bool isFav;
  final int productId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context
          .read<FavoritesCubit>()
          .addToFavorites(productId.toString(), false),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 4,
              color: isFav
                  ? AllColors.primary.withOpacity(0.16)
                  : AllColors.black.withOpacity(0.08),
            ),
          ],
          color: isFav ? AllColors.primary : AllColors.white,
          //color: AllColors.primary,
        ),
        child: Center(
            child: isFav
                ? SvgPicture.asset(
                    'assets/icons/fav_active.svg',
                    //width: 24,
                  )
                : SvgPicture.asset(
                    'assets/icons/fav_not_active.svg',
                    //width: 24,
                  )),
      ),
    );
  }
}
