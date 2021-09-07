import 'package:cool_shop/widgets/big_button.dart';
import 'package:flutter/material.dart';
import 'package:cool_shop/constants.dart';

class ProductBottomNavBar extends StatelessWidget {
  const ProductBottomNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 112,
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
      padding: EdgeInsets.fromLTRB(16, 20, 16, 44),
      child: BigButton(
        onPress: () {},
        text: 'ADD TO CART',
      ),
    );
  }
}
