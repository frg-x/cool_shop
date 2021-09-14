import 'package:cool_shop/constants.dart';
import 'package:cool_shop/models/cart_item.dart';
import 'package:cool_shop/ui/product_screen/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'bag_screen_change_quantity.dart';

class BagScreenCartItem extends StatefulWidget {
  const BagScreenCartItem({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  final CartItem cartItem;

  @override
  _BagScreenCartItemState createState() => _BagScreenCartItemState();
}

class _BagScreenCartItemState extends State<BagScreenCartItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Constants.globalNavigatorKey.currentState!.push(
        MaterialPageRoute(
          builder: (ctx) => ProductScreen(id: widget.cartItem.id),
        ),
      ),
      child: Container(
        height: 104,
        margin: EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 1),
              blurRadius: 25,
              color: AllColors.black.withOpacity(0.08),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 104,
              height: 104,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                child: Image.network(
                  widget.cartItem.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                color: AllColors.white,
              ),
            ),
            Expanded(
              child: Container(
                height: 104,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 11),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 11),
                            Text(
                              widget.cartItem.title,
                              style: AllStyles.dark16w600,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Color: ',
                                      style: AllStyles.gray11,
                                    ),
                                    Text(
                                      widget.cartItem.color,
                                      style: AllStyles.dark11w400,
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 16),
                                Row(
                                  children: [
                                    Text(
                                      'Size: ',
                                      style: AllStyles.gray11,
                                    ),
                                    Text(
                                      widget.cartItem.size,
                                      style: AllStyles.dark11w400,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => print('more'),
                          child: SvgPicture.asset(
                              'assets/icons/cart_item_more.svg'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              ChangeQuantityButton(
                                action: ChangeQuantityAction.add,
                                cartItem: widget.cartItem,
                              ),
                              const SizedBox(width: 16),
                              Text(
                                widget.cartItem.quantity.toString(),
                                style: AllStyles.dark14w500,
                              ),
                              const SizedBox(width: 16),
                              ChangeQuantityButton(
                                action: ChangeQuantityAction.substract,
                                cartItem: widget.cartItem,
                              ),
                            ],
                          ),
                          Text(
                            '${widget.cartItem.price.toStringAsFixed(0)}\$',
                            style: AllStyles.dark14w500,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  color: AllColors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
