import 'package:cool_shop/constants.dart';
import 'package:cool_shop/cubit/cart/cart_cubit.dart';
import 'package:cool_shop/cubit/favorites/favorites_cubit.dart';
import 'package:cool_shop/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

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
  List<PopupMenuEntry<Object>> list = [];
  String uuid = const Uuid().v4();

  void initPopupMenu() {
    list.add(
      PopupMenuItem(
        height: 40,
        child: const Text(
          'Add to favorites',
          style: AllStyles.dark11w400,
        ),
        value: 'AddToFavorites',
        onTap: () => context
            .read<FavoritesCubit>()
            .addToFavorites(widget.cartItem.id.toString(), false),
      ),
    );
    list.add(
      const PopupMenuDivider(
        height: 1,
      ),
    );
    list.add(
      PopupMenuItem(
        height: 40,
        child: const Text(
          'Delete from the list',
          style: AllStyles.dark11w400,
        ),
        onTap: () => context.read<CartCubit>().deleteItem(widget.cartItem),
      ),
    );
  }

  @override
  void initState() {
    initPopupMenu();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 104,
      margin: const EdgeInsets.only(bottom: 24),
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
              child: Hero(
                tag: uuid,
                child: Image.network(
                  widget.cartItem.imageUrl,
                  fit: BoxFit.cover,
                ),
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
                                  const Text(
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
                                  const Text(
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
                      // GestureDetector(
                      //   //nTapDown: _showPopupMenu,
                      //   child: SvgPicture.asset(
                      //       'assets/icons/cart_item_more.svg'),
                      // ),
                      Container(
                        width: 30,
                        height: 30,
                        //color: Colors.green,
                        margin: const EdgeInsets.only(top: 5, right: 5),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                          ),
                          child: Transform.translate(
                            offset: const Offset(-5, -5),
                            child: PopupMenuButton(
                              icon: const Icon(
                                Icons.more_vert,
                                color: Color(0xFFC7C7C7),
                                size: 24,
                              ),
                              offset: const Offset(-28, -20),
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              itemBuilder: (context) => list,
                            ),
                          ),
                        ),
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
                            SizedBox(
                              width: 20,
                              child: Text(
                                widget.cartItem.quantity.toString(),
                                style: AllStyles.dark14w500,
                                textAlign: TextAlign.center,
                              ),
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
    );
  }
}
