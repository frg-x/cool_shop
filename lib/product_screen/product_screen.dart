import 'package:cool_shop/categories_screen/filters_screen/models/filter_size.dart';
import 'package:cool_shop/constants.dart';
import 'package:cool_shop/cubit/products/products_cubit.dart';
import 'package:cool_shop/home_screen/widgets/home_screen_product_card.dart';
import 'package:cool_shop/models/product.dart';
import 'package:cool_shop/product_screen/widgets/big_image.dart';
import 'package:cool_shop/widgets/big_button.dart';
import 'package:cool_shop/widgets/favorite_button.dart';
import 'package:cool_shop/widgets/modal_sheet_divider.dart';
import 'package:cool_shop/widgets/rating_stars.dart';
import 'package:cool_shop/widgets/rounded_square_100x40.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_bottom_navbar.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Product getProductById(BuildContext context, int id) {
    return context
        .read<ProductsCubit>()
        .productsList
        .firstWhere((element) => element.id == id);
  }

  String _selectedSize = '';
  String _selectedColor = '';
  bool isFav = false;
  List<FilterSize> filterSizes = [
    FilterSize(size: 'XS', isSelected: false),
    FilterSize(size: 'S', isSelected: false),
    FilterSize(size: 'M', isSelected: false),
    FilterSize(size: 'L', isSelected: false),
    FilterSize(size: 'XL', isSelected: false),
  ];

  String selectedSize = 'Size';
  int selectedSizeIndex = -1;

  void selectSize(int index) {
    setState(() {
      //filterSizes[index].isSelected = !filterSizes[index].isSelected;
      for (int i = 0; i < filterSizes.length; i++) {
        if (i != index) {
          filterSizes[i].isSelected = false;
        }
      }

      if (index == selectedSizeIndex) {
        filterSizes[index].isSelected = false;
      } else {
        filterSizes[index].isSelected = true;
      }
      if (selectedSize == filterSizes[index].size) {
        selectedSize = 'Size';
        selectedSizeIndex = -1;
      } else {
        selectedSize = filterSizes[index].size;
        selectedSizeIndex = index;
      }
    });
  }

  void selectSizeSheet(
      BuildContext context, String currentSize, Function onPress) {
    showModalBottomSheet(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(34.0),
            topRight: Radius.circular(34.0),
          ),
        ),
        backgroundColor: AllColors.appBackgroundColor,
        context: context,
        useRootNavigator: true,
        builder: (context) {
          return Container(
            height: 398,
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ModalSheetDivider(),
                const SizedBox(height: 16),
                const Text(
                  'Select size',
                  style: AllStyles.dark18w600,
                ),
                const SizedBox(height: 22),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 120,
                  width: double.infinity,
                  //color: Colors.amberAccent,
                  alignment: Alignment.center,
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    direction: Axis.horizontal,
                    runSpacing: 16,
                    spacing: 22,
                    children: filterSizes
                        .asMap()
                        .map(
                          (index, element) => MapEntry(
                            index,
                            RoundedSquare100x40(
                              title: element.size,
                              isSelected: element.isSelected,
                              onPress: () {
                                selectSize(index);
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        )
                        .values
                        .toList(),
                  ),
                ),
                Divider(),
                Container(
                  height: 48,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Size info',
                        style: AllStyles.dark16w400,
                      ),
                      SvgPicture.asset(
                        'assets/icons/small_arrow_forward_dark.svg',
                      ),
                    ],
                  ),
                ),
                Divider(),
                const SizedBox(height: 28),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: BigButton(
                    text: 'ADD TO CART',
                    onPress: () => print('ADD TO CART'),
                  ),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final product = getProductById(context, widget.id);
    return Scaffold(
      bottomNavigationBar: ProductBottomNavBar(),
      appBar: AppBar(
        title: Text(
          product.title,
          style: AllStyles.dark18w600,
        ),
        backgroundColor: AllColors.white,
        elevation: 8,
        shadowColor: AllColors.black.withOpacity(0.25),
        brightness: Brightness.light,
        iconTheme: const IconThemeData(color: AllColors.dark),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            width: 24,
            height: 24,
            child: Icon(CupertinoIcons.back),
          ),
        ),
        leadingWidth: 40,
        actions: [
          GestureDetector(
            onTap: () => print('Sharing the URL'),
            child: Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: SvgPicture.asset('assets/icons/share.svg'),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 413,
              child: PageView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Hero(
                    tag: product.imageUrl,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => BigImage(
                              url: product.imageUrl,
                              uniqueId: product.imageUrl),
                        ),
                      ),
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 138,
                    height: 40,
                    child: TextField(
                      //value: 'M',
                      // onChanged: (value) {
                      //   setState(() {
                      //     _selectedSize = value.toString();
                      //     //print(_selectedSize);
                      //   });
                      // },
                      onTap: () => selectSizeSheet(
                        context,
                        'ffff',
                        () {},
                      ),
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: selectedSize,
                        hintStyle: AllStyles.dark14w500,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AllColors.sizeOptionRedBorder,
                            width: 0.4,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AllColors.sizeOptionRedBorder,
                            width: 0.4,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AllColors.sizeOptionRedBorder,
                            width: 0.4,
                          ),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(12, 10, 12, 10),
                        suffixIcon: Padding(
                          padding: EdgeInsets.all(10),
                          child: SvgPicture.asset(
                            'assets/icons/option_arrow_down.svg',
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 138,
                    height: 40,
                    child: DropdownButtonFormField(
                      onChanged: (value) {
                        setState(() {
                          _selectedColor = value.toString();
                          //print(_selectedColor);
                        });
                      },
                      icon: SvgPicture.asset(
                          'assets/icons/option_arrow_down.svg'),
                      decoration: InputDecoration(
                        hintText: 'Color',
                        hintStyle: AllStyles.dark14w500,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: AllColors.dark,
                            width: 0.4,
                          ),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(12, 10, 12, 10),
                      ),
                      items: [
                        DropdownMenuItem(
                          child: Text(
                            'Black',
                            style: AllStyles.dark14w500,
                          ),
                          value: 'Black',
                        ),
                        DropdownMenuItem(
                          child: Text(
                            'Red',
                            style: AllStyles.dark14w500,
                          ),
                          value: 'Red',
                        ),
                        DropdownMenuItem(
                          child: Text(
                            'Gray',
                            style: AllStyles.dark14w500,
                          ),
                          value: 'Gray',
                        ),
                        DropdownMenuItem(
                          child: Text(
                            'Purple',
                            style: AllStyles.dark14w500,
                          ),
                          value: 'Purple',
                        ),
                        DropdownMenuItem(
                          child: Text(
                            'White',
                            style: AllStyles.dark14w500,
                          ),
                          value: 'White',
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isFav = !isFav;
                      });
                    },
                    child: FavoriteButton(isFav: isFav),
                  )
                ],
              ),
            ),
            const SizedBox(height: 22),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.collection,
                        style: AllStyles.dark24w600,
                      ),
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: AllStyles.dark24w600,
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'Short black dress',
                    style: AllStyles.gray11,
                  ),
                  const SizedBox(height: 9),
                  Container(
                    height: 12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        RatingStars(count: product.rating),
                        const SizedBox(width: 3),
                        Text(
                          '(${product.ratingCount})',
                          style: AllStyles.gray10,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    child: const Text(
                      'Short dress in soft cotton jersey with decorative buttons down the front and a wide, frill-trimmed square neckline with concealed elastication. Elasticated seam under the bust and short puff sleeves with a small frill trim.',
                      style: AllStyles.productDescriprtion,
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              height: 48,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Shipping info',
                    style: AllStyles.dark16w400,
                  ),
                  SvgPicture.asset(
                    'assets/icons/small_arrow_forward_dark.svg',
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              height: 48,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Support',
                    style: AllStyles.dark16w400,
                  ),
                  SvgPicture.asset(
                    'assets/icons/small_arrow_forward_dark.svg',
                  ),
                ],
              ),
            ),
            Divider(),
            BlocBuilder<ProductsCubit, ProductsState>(
              builder: (context, state) {
                if (state is ProductsLoaded) {
                  Iterable<Product> reversedProductsList =
                      state.products.reversed;
                  return Column(
                    children: [
                      const SizedBox(height: 24),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'You can also like this',
                              style: AllStyles.dark18w600,
                            ),
                            Text(
                              '${reversedProductsList.length} items',
                              style: AllStyles.gray11,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 280,
                        child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: reversedProductsList.length,
                          separatorBuilder: (ctx, int index) =>
                              const SizedBox(width: 20.0),
                          itemBuilder: (ctx, int index) {
                            return HomeScreenProductCard(
                              id: reversedProductsList.elementAt(index).id,
                              imageURL: reversedProductsList
                                  .elementAt(index)
                                  .imageUrl,
                              price:
                                  reversedProductsList.elementAt(index).price,
                              discount: reversedProductsList
                                  .elementAt(index)
                                  .discount,
                              rating:
                                  reversedProductsList.elementAt(index).rating,
                              ratingCount: reversedProductsList
                                  .elementAt(index)
                                  .ratingCount,
                              title:
                                  reversedProductsList.elementAt(index).title,
                              collection: reversedProductsList
                                  .elementAt(index)
                                  .collection,
                            );
                          },
                        ),
                      ),
                    ],
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
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
