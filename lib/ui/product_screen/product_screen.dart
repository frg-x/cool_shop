import 'package:cool_shop/cubit/cart/cart_cubit.dart';
import 'package:cool_shop/ui/categories_screen/filters_screen/models/filter_color.dart';
import 'package:cool_shop/ui/categories_screen/filters_screen/models/filter_size.dart';
import 'package:cool_shop/constants.dart';
import 'package:cool_shop/cubit/products/products_cubit.dart';
import 'package:cool_shop/ui/home_screen/widgets/home_screen_product_card.dart';
import 'package:cool_shop/models/cart_item.dart';
import 'package:cool_shop/models/product.dart';
import 'package:cool_shop/ui/product_screen/widgets/big_image.dart';
import 'package:cool_shop/ui/widgets/big_button.dart';
import 'package:cool_shop/ui/widgets/custom_snackbar.dart';
import 'package:cool_shop/ui/widgets/favorite_button.dart';
import 'package:cool_shop/ui/widgets/modal_sheet_divider.dart';
import 'package:cool_shop/ui/widgets/rating_stars.dart';
import 'package:cool_shop/ui/widgets/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_bottom_navbar.dart';
import 'custom_transparent_page_route.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    return Color(int.parse("0xFF$hexColor"));
  }

  Product getProductById(BuildContext context, int id) {
    final currentProduct = context
        .read<ProductsCubit>()
        .productsList
        .firstWhere((element) => element.id == id);
    filterColors = [];
    currentProduct.colors.forEach((element) {
      final filterColor = FilterColor(
          id: int.parse(element['id']),
          title: element['title'],
          color: _getColorFromHex(element['color']),
          isSelected: false);
      filterColors.add(filterColor);
    });
    filterSizes = [];
    currentProduct.sizes.forEach((element) {
      final filterSize = FilterSize(
          id: int.parse(element['id']),
          title: element['title'],
          isSelected: false);
      filterSizes.add(filterSize);
    });
    return currentProduct;
  }

  late Product product;

  bool isFav = false;
  List<FilterSize> filterSizes = [];
  List<FilterColor> filterColors = [];

  String selectedColor = '';
  String selectedSize = 'Size';
  int selectedSizeIndex = -1;

  @override
  void didChangeDependencies() {
    product = getProductById(context, widget.id);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    CartItem cartItem = CartItem(
      id: product.id,
      imageUrl: product.imageUrl,
      title: product.title,
      price: product.price,
      size: selectedSize,
      color: selectedColor,
      quantity: 1,
    );
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state is CartProductError) {
          CustomSnackbar(context: context, text: state.text, duration: 2);
        }
      },
      child: Scaffold(
        bottomNavigationBar: ProductBottomNavBar(cartItem: cartItem),
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
                    return GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        CustomTransparentPageRoute(
                          pageBuilder: (context, Animation<double> animation,
                              Animation<double> secondaryAnimation) {
                            return BigImage(imageUrl: product.imageUrl);
                          },
                        ),
                      ),
                      child: Hero(
                        tag: product.imageUrl,
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
                          'XS',
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
                            selectedColor = value.toString();
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
                        items: filterColors
                            .asMap()
                            .map(
                              (index, element) => MapEntry(
                                index,
                                DropdownMenuItem(
                                  child: Text(
                                    element.title,
                                    style: AllStyles.dark14w500,
                                  ),
                                  value: element.title,
                                ),
                              ),
                            )
                            .values
                            .toList(),
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
                                imageUrl: reversedProductsList
                                    .elementAt(index)
                                    .imageUrl,
                                price:
                                    reversedProductsList.elementAt(index).price,
                                discount: reversedProductsList
                                    .elementAt(index)
                                    .discount,
                                rating: reversedProductsList
                                    .elementAt(index)
                                    .rating,
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
      ),
    );
  }

  void selectSize(int index) {
    filterSizes[index].isSelected = !filterSizes[index].isSelected;
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
    if (selectedSize == filterSizes[index].title) {
      selectedSize = 'Size';
      selectedSizeIndex = -1;
    } else {
      selectedSize = filterSizes[index].title;
      selectedSizeIndex = index;
    }
    print(selectedSize);
    setState(() {});
  }

  void selectSizeSheet(BuildContext context, String index, Function onPress) {
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
                  //padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 120,
                  width: double.infinity,
                  //color: Colors.amberAccent,
                  alignment: Alignment.center,
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    direction: Axis.horizontal,
                    runSpacing: 12,
                    spacing: 12,
                    children: filterSizes
                        .asMap()
                        .map(
                          (index, element) => MapEntry(
                            index,
                            RoundedButton(
                              title: element.title,
                              width: MediaQuery.of(context).size.width * 0.28,
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
}
