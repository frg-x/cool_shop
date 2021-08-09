// ignore_for_file: sized_box_for_whitespace, prefer_const_literals_to_create_immutables

import 'package:cool_shop/constants.dart';
import 'package:cool_shop/widgets/discount_label.dart';
import 'package:cool_shop/widgets/favorite_button.dart';
import 'package:cool_shop/widgets/rating_stars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MainScreenProductCard extends StatefulWidget {
  const MainScreenProductCard({
    Key? key,
    required this.imageURL,
    required this.vendor,
    required this.title,
    required this.price,
    required this.priceDiscounted,
    required this.rating,
    required this.rewiewsNumber,
  }) : super(key: key);

  final String imageURL;
  final String vendor;
  final String title;
  final double price;
  final double priceDiscounted;
  final int rating;
  final int rewiewsNumber;

  @override
  State<MainScreenProductCard> createState() => _MainScreenProductCardState();
}

class _MainScreenProductCardState extends State<MainScreenProductCard> {
  bool isFav = false;

  @override
  Widget build(BuildContext context) {
    final String percentText =
        ((1 - widget.priceDiscounted / widget.price) * 100)
            .floor()
            .toStringAsFixed(0);
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
                  child: DiscountLabel(percentText: "-$percentText%"),
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
                  Text('(${widget.rewiewsNumber})', style: AllStyles.gray10),
                ],
              ),
            ),
            const SizedBox(height: 7),
            Text(widget.vendor, style: AllStyles.gray11),
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
                  '${widget.priceDiscounted.toStringAsFixed(0)}\$',
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
