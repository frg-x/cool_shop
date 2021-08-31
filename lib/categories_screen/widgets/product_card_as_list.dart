import 'package:cool_shop/constants.dart';
import 'package:cool_shop/widgets/favorite_button.dart';
import 'package:cool_shop/widgets/rating_stars.dart';
import 'package:flutter/material.dart';

class ProductCardAsList extends StatefulWidget {
  const ProductCardAsList({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.onPress,
    required this.price,
    required this.discount,
    required this.rating,
    required this.ratingCount,
    required this.collection,
  }) : super(key: key);

  final String imageUrl;
  final String title;
  final double price;
  final double discount;
  final int rating;
  final int ratingCount;
  final String collection;
  final Function onPress;

  @override
  _ProductCardAsListState createState() => _ProductCardAsListState();
}

class _ProductCardAsListState extends State<ProductCardAsList> {
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    // final String discountText =
    //     (discount * 100).floor().toStringAsFixed(0);
    final String discountPrice =
        (widget.price * (1 - widget.discount)).floor().toStringAsFixed(0);

    return Stack(
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
                  child: Image.network(
                    widget.imageUrl,
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
                  padding: const EdgeInsets.only(left: 11, top: 11),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: AllStyles.dark16w600,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.collection,
                        style: AllStyles.gray11,
                      ),
                      const SizedBox(height: 9),
                      Container(
                        height: 12,
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            RatingStars(count: widget.rating),
                            const SizedBox(width: 3),
                            Text('(${widget.ratingCount})',
                                style: AllStyles.gray10),
                          ],
                        ),
                      ),
                      const SizedBox(height: 9),
                      widget.discount > 0
                          ? Row(
                              children: [
                                Text(
                                  '${widget.price.toStringAsFixed(0)}\$',
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
                              '${widget.price.toStringAsFixed(0)}\$',
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
          child: GestureDetector(
            onTap: () {
              setState(() {
                isFav = !isFav;
              });
            },
            child: FavoriteButton(isFav: isFav),
          ),
        ),
      ],
    );
  }
}
