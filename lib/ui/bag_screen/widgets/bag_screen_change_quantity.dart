import 'package:cool_shop/constants.dart';
import 'package:cool_shop/cubit/cart/cart_cubit.dart';
import 'package:cool_shop/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum ChangeQuantityAction {
  add,
  substract,
}

class ChangeQuantityButton extends StatelessWidget {
  ChangeQuantityButton({
    Key? key,
    required this.cartItem,
    required this.action,
  }) : super(key: key);

  final ChangeQuantityAction action;
  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        action == ChangeQuantityAction.add
            ? context.read<CartCubit>().incrementCartItem(cartItem)
            : context.read<CartCubit>().decrementCartItem(cartItem);
      },
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 8,
              color: AllColors.black.withOpacity(0.1),
            ),
          ],
          color: AllColors.white,
          //color: AllColors.primary,
        ),
        child: Center(
          child: action == ChangeQuantityAction.add
              ? SvgPicture.asset(
                  'assets/icons/action_add.svg',
                )
              : SvgPicture.asset(
                  'assets/icons/action_substract.svg',
                ),
        ),
      ),
    );
  }
}
