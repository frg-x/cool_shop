// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cool_shop/constants.dart';
import 'package:cool_shop/home_screen/widgets/home_screen_product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.testScreenTitle}) : super(key: key);

  final String testScreenTitle;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final reversedProductsList = mainScreenProducts.reversed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ColoredBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                    'assets/images/header.png',
                    fit: BoxFit.fitWidth,
                    width: double.infinity,
                  ),
                  const Positioned(
                    bottom: 26,
                    left: 18,
                    child: Text(
                      'Street clothes',
                      style: TextStyle(
                        fontSize: 34,
                        color: AllColors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Sale (${widget.testScreenTitle})',
                              style: AllStyles.headlineActive,
                            ),
                            const Text('View all', style: AllStyles.dark14w400),
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        const Text(
                          'Super summer sale',
                          style: TextStyle(color: AllColors.gray),
                        ),
                        const SizedBox(height: 22.0),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 280,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: mainScreenProducts.length,
                      separatorBuilder: (ctx, int index) =>
                          const SizedBox(width: 20.0),
                      itemBuilder: (ctx, int index) {
                        return MainScreenProductCard(
                          imageURL: mainScreenProducts[index].imageURL,
                          price: mainScreenProducts[index].price,
                          priceDiscounted:
                              mainScreenProducts[index].priceDiscounted,
                          rating: mainScreenProducts[index].rating,
                          rewiewsNumber:
                              mainScreenProducts[index].reviewsNumber,
                          title: mainScreenProducts[index].title,
                          vendor: mainScreenProducts[index].vendor,
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text('New', style: AllStyles.headlineActive),
                            const Text('View all', style: AllStyles.dark14w400),
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        const Text(
                          'You’ve never seen it before!',
                          style: TextStyle(color: AllColors.gray),
                        ),
                        const SizedBox(height: 22.0),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 280,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: reversedProductsList.length,
                      separatorBuilder: (ctx, int index) =>
                          const SizedBox(width: 20.0),
                      itemBuilder: (ctx, int index) {
                        return MainScreenProductCard(
                          imageURL:
                              reversedProductsList.elementAt(index).imageURL,
                          price: reversedProductsList.elementAt(index).price,
                          priceDiscounted: reversedProductsList
                              .elementAt(index)
                              .priceDiscounted,
                          rating: reversedProductsList.elementAt(index).rating,
                          rewiewsNumber: reversedProductsList
                              .elementAt(index)
                              .reviewsNumber,
                          title: reversedProductsList.elementAt(index).title,
                          vendor: reversedProductsList.elementAt(index).vendor,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          color: const Color(0xFFF9F9F9),
        ),
      ),
    );
  }
}
