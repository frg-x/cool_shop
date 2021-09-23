import 'package:cool_shop/constants.dart';
import 'package:cool_shop/models/product.dart';
import 'package:cool_shop/ui/product_screen/product_screen.dart';
import 'package:cool_shop/ui/widgets/custom_transparent_page_route.dart';
import 'package:cool_shop/ui/widgets/favorite_button.dart';
import 'package:cool_shop/ui/widgets/rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ProductCardAsList extends StatefulWidget {
  const ProductCardAsList({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  _ProductCardAsListState createState() => _ProductCardAsListState();
}

class _ProductCardAsListState extends State<ProductCardAsList> {
  bool isFav = false;
  String uuid = const Uuid().v4();

  @override
  Widget build(BuildContext context) {
    // final String discountText =
    //     (discount * 100).floor().toStringAsFixed(0);
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
          Container(
            height: 130,
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
                        widget.product.imageUrl,
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
                    padding: const EdgeInsets.only(left: 11, top: 11),
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.title,
                          style: AllStyles.dark16w600,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.product.collection,
                          style: AllStyles.gray11,
                        ),
                        const SizedBox(height: 9),
                        SizedBox(
                          height: 12,
                          width: 100,
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
                        const SizedBox(height: 9),
                        widget.product.discount > 0
                            ? Row(
                                children: [
                                  Text(
                                    '${widget.product.price.toStringAsFixed(0)}\$',
                                    style: AllStyles.gray14w400.copyWith(
                                        decoration: TextDecoration.lineThrough),
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
          Positioned(
            bottom: 4,
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
