// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cool_shop/constants.dart';
import 'package:cool_shop/cubit/products/products_cubit.dart';
import 'package:cool_shop/ui/home_screen/widgets/home_screen_product_card.dart';
import 'package:cool_shop/cubit/login/login_cubit.dart';
import 'package:cool_shop/models/product.dart';
import 'package:cool_shop/ui/widgets/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductsCubit, ProductsState>(
      listener: (context, state) {
        if (state is ProductsError) {
          CustomSnackbar(context: context, text: state.message, duration: 4);
        }
      },
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ColoredBox(
          color: AllColors.appBackgroundColor,
          child: BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              return Column(
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
                                  'Sale',
                                  style: AllStyles.headlineActive,
                                ),
                                const Text('View all',
                                    style: AllStyles.dark14w400),
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
                        child: BlocBuilder<ProductsCubit, ProductsState>(
                          builder: (context, state) {
                            //print(state);
                            if (state is ProductsLoaded) {
                              List<Product> productsList = state.products;
                              return ListView.separated(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 14),
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: productsList.length,
                                separatorBuilder: (ctx, int index) =>
                                    const SizedBox(width: 20.0),
                                itemBuilder: (ctx, int index) {
                                  return HomeScreenProductCard(
                                    id: productsList.elementAt(index).id,
                                    imageUrl:
                                        productsList.elementAt(index).imageUrl,
                                    price: productsList.elementAt(index).price,
                                    discount:
                                        productsList.elementAt(index).discount,
                                    rating:
                                        productsList.elementAt(index).rating,
                                    ratingCount: productsList
                                        .elementAt(index)
                                        .ratingCount,
                                    title: productsList.elementAt(index).title,
                                    collection: productsList
                                        .elementAt(index)
                                        .collection,
                                  );
                                },
                              );
                            } else if (state is ProductsLoading ||
                                state is ProductsInitial) {
                              return const Center(
                                child: CupertinoActivityIndicator(),
                              );
                            } else {
                              return SizedBox.expand(
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(20),
                                  color: AllColors.white,
                                  child: Text(
                                    ':( Some thing went wrong!',
                                    style: AllStyles.dark16w500,
                                  ),
                                ),
                              );
                            }
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
                                const Text('New',
                                    style: AllStyles.headlineActive),
                                const Text('View all',
                                    style: AllStyles.dark14w400),
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
                        child: BlocBuilder<ProductsCubit, ProductsState>(
                          builder: (context, state) {
                            if (state is ProductsLoaded) {
                              Iterable<Product> reversedProductsList =
                                  state.products.reversed;
                              return ListView.separated(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 14),
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: reversedProductsList.length,
                                separatorBuilder: (ctx, int index) =>
                                    const SizedBox(width: 20.0),
                                itemBuilder: (ctx, int index) {
                                  return HomeScreenProductCard(
                                    id: reversedProductsList
                                        .elementAt(index)
                                        .id,
                                    imageUrl: reversedProductsList
                                        .elementAt(index)
                                        .imageUrl,
                                    price: reversedProductsList
                                        .elementAt(index)
                                        .price,
                                    discount: reversedProductsList
                                        .elementAt(index)
                                        .discount,
                                    rating: reversedProductsList
                                        .elementAt(index)
                                        .rating,
                                    ratingCount: reversedProductsList
                                        .elementAt(index)
                                        .ratingCount,
                                    title: reversedProductsList
                                        .elementAt(index)
                                        .title,
                                    collection: reversedProductsList
                                        .elementAt(index)
                                        .collection,
                                  );
                                },
                              );
                            } else if (state is ProductsLoading ||
                                state is ProductsInitial) {
                              return const Center(
                                child: CupertinoActivityIndicator(),
                              );
                            } else {
                              return SizedBox.expand(
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(20),
                                  color: AllColors.white,
                                  child: Text(
                                    ':( Some thing went wrong!',
                                    style: AllStyles.dark16w500,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
