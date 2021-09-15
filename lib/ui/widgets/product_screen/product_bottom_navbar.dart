import 'package:cool_shop/cubit/cart/cart_cubit.dart';
import 'package:cool_shop/models/cart_item.dart';
import 'package:cool_shop/ui/widgets/big_button.dart';
import 'package:flutter/material.dart';
import 'package:cool_shop/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBottomNavBar extends StatelessWidget {
  const ProductBottomNavBar({Key? key, required this.cartItem})
      : super(key: key);

  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
      decoration: BoxDecoration(
        color: AllColors.appBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -4),
            blurRadius: 8,
            color: AllColors.black.withOpacity(0.1),
          )
        ],
      ),
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 44),
      child: BigButton(
        onPress: () => context.read<CartCubit>().addItem(cartItem),
        text: 'ADD TO CART',
      ),
    );
  }
}
