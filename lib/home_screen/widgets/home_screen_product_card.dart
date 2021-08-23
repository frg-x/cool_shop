// ignore_for_file: sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:cool_shop/constants.dart';
import 'package:cool_shop/widgets/discount_label.dart';
import 'package:cool_shop/widgets/favorite_button.dart';
import 'package:cool_shop/widgets/rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomeScreenProductCard extends StatefulWidget {
  const HomeScreenProductCard({
    Key? key,
    required this.imageURL,
    required this.collection,
    required this.title,
    required this.price,
    required this.discount,
    required this.rating,
    required this.ratingCount,
  }) : super(key: key);

  final String imageURL;
  final String collection;
  final String title;
  final double price;
  final double discount;
  final int rating;
  final int ratingCount;

  @override
  State<HomeScreenProductCard> createState() => _HomeScreenProductCardState();
}

class _HomeScreenProductCardState extends State<HomeScreenProductCard> {
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    final String discountText =
        (widget.discount * 100).floor().toStringAsFixed(0);
    final String discountPrice =
        (widget.price * (1 - widget.discount)).floor().toStringAsFixed(0);
    return Stack(children: [
      Container(
        width: 150,
        height: 270,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      widget.imageURL,
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: 150,
                  height: 190,
                ),
                Positioned(
                  left: 9,
                  top: 8,
                  child: DiscountLabel(percentText: "-$discountText%"),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              height: 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RatingStars(count: widget.rating),
                  const SizedBox(width: 3),
                  Text('(${widget.ratingCount})', style: AllStyles.gray10),
                ],
              ),
            ),
            const SizedBox(height: 7),
            Text(widget.collection, style: AllStyles.gray11),
            const SizedBox(height: 7),
            Text(
              widget.title,
              style: AllStyles.dark16w500,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Text(
                  '${widget.price.toStringAsFixed(0)}\$',
                  style: AllStyles.gray14w400
                      .copyWith(decoration: TextDecoration.lineThrough),
                ),
                const SizedBox(width: 4),
                Text(
                  '$discountPrice\$',
                  style: AllStyles.primary14w400,
                ),
              ],
            ),
          ],
        ),
      ),
      Positioned(
        top: 175,
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
    ]);
  }
}
