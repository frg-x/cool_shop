// ignore_for_file: sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:cool_shop/constants.dart';
import 'package:cool_shop/models/product.dart';
import 'package:cool_shop/ui/product_screen/product_screen.dart';
import 'package:cool_shop/ui/widgets/custom_transparent_page_route.dart';
import 'package:cool_shop/ui/widgets/discount_label.dart';
import 'package:cool_shop/ui/widgets/favorite_button.dart';
import 'package:cool_shop/ui/widgets/rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:uuid/uuid.dart';

class ProductCardAsGrid extends StatefulWidget {
  const ProductCardAsGrid({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  State<ProductCardAsGrid> createState() => _ProductCardAsGridState();
}

class _ProductCardAsGridState extends State<ProductCardAsGrid> {
  bool isFav = false;
  String uuid = const Uuid().v4();

  @override
  Widget build(BuildContext context) {
    final String discountText =
        (widget.product.discount * 100).floor().toStringAsFixed(0);
    final String discountPrice =
        (widget.product.price * (1 - widget.product.discount))
            .floor()
            .toStringAsFixed(0);
    return GestureDetector(
      onTap: () => Constants.globalNavigatorKey.currentState!.push(
        CustomTransparentPageRoute(
          pageBuilder: (context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return ProductScreen(
              product: widget.product,
              heroTag: uuid,
            );
          },
        ),
      ),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Hero(
                        tag: uuid,
                        child: Image.network(
                          widget.product.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    width: 180,
                    height: 190,
                  ),
                  widget.product.discount > 0
                      ? Positioned(
                          left: 9,
                          top: 8,
                          child: DiscountLabel(percentText: "-$discountText%"),
                        )
                      : Container(),
                ],
              ),
              const SizedBox(height: 8),
              Container(
                height: 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RatingStars(count: widget.product.rating),
                    const SizedBox(width: 3),
                    Text('(${widget.product.ratingCount})',
                        style: AllStyles.gray10),
                  ],
                ),
              ),
              const SizedBox(height: 7),
              Text(widget.product.collection, style: AllStyles.gray11),
              const SizedBox(height: 7),
              Text(
                widget.product.title,
                style: AllStyles.dark16w500,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5),
              widget.product.discount > 0
                  ? Row(
                      children: [
                        Text(
                          '${widget.product.price.toStringAsFixed(0)}\$',
                          style: AllStyles.gray14w400
                              .copyWith(decoration: TextDecoration.lineThrough),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '$discountPrice\$',
                          style: AllStyles.primary14w400,
                        ),
                      ],
                    )
                  : Text(
                      '${widget.product.price.toStringAsFixed(0)}\$',
                      style: AllStyles.dark14w500,
                    ),
            ],
          ),
          Positioned(
            top: 164,
            right: 0,
            child: FavoriteButton(
              isFav: isFav,
              productId: widget.product.id,
            ),
          ),
        ],
      ),
    );
  }
}
