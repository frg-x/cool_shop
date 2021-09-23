// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cool_shop/models/product.dart';
import 'package:cool_shop/ui/categories_screen/filters_screen/filters_screen.dart';
import 'package:cool_shop/ui/categories_screen/widgets/product_card_as_list.dart';
import 'package:cool_shop/constants.dart';
import 'package:cool_shop/cubit/products/products_cubit.dart';
import 'package:cool_shop/models/sub_category.dart';
import 'package:cool_shop/ui/widgets/modal_sheet_divider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'widgets/category_small_badge.dart';
import 'widgets/product_card_as_grid.dart';

enum SortingTypes {
  popular,
  newest,
  customerReview,
  priceLowToHigh,
  priceHighToLow,
}

class SubSubCategoryScreen extends StatefulWidget {
  const SubSubCategoryScreen({
    Key? key,
  }) : super(key: key);
  @override
  _SubSubCategoryScreenState createState() => _SubSubCategoryScreenState();
}

class _SubSubCategoryScreenState extends State<SubSubCategoryScreen> {
  bool isGrid = false;
  SortingTypes sortingType = SortingTypes.priceLowToHigh;
  String sortingTypeValue = '';

  Map<SortingTypes, String> sortingTypesMap = {
    SortingTypes.customerReview: 'Customer review',
    SortingTypes.newest: 'Newest',
    SortingTypes.popular: 'Popular',
    SortingTypes.priceLowToHigh: 'Price: lowest to high',
    SortingTypes.priceHighToLow: 'Price: highest to low',
  };

  void selectSortingFunction(SortingTypes current) {
    setState(() {
      sortingType = current;
      sortingTypesMap.forEach((key, value) {
        if (key == current) {
          sortingTypeValue = value;
        }
      });
    });
  }

  @override
  void initState() {
    selectSortingFunction(sortingType);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final title = ModalRoute.of(context)!.settings.arguments as String;
    final subcat =
        (categories.elementAt(0).subCategories.elementAt(2) as SubCategory)
            .subSubCategories
            .reversed;

    List<Product> productsList = [];
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is ProductsLoaded) {
          productsList = state.products;
        }

        return Scaffold(
          backgroundColor: AllColors.appBackgroundColor,
          appBar: AppBar(
            backgroundColor: AllColors.white,
            elevation: 0,
            shadowColor: AllColors.black.withOpacity(0.25),
            systemOverlayStyle: SystemUiOverlayStyle.light,
            iconTheme: const IconThemeData(color: AllColors.dark),
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const SizedBox(
                width: 24,
                height: 24,
                child: Icon(CupertinoIcons.back),
              ),
            ),
            leadingWidth: 40,
            actions: [
              const Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.search,
                  color: AllColors.dark,
                  size: 26,
                ),
              ),
            ],
            title: isGrid
                ? const Text(
                    'Women\'s tops',
                    style: AllStyles.dark18w600,
                  )
                : const Text(''),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              isGrid
                  ? GridView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 168, 16, 0),
                      physics: const BouncingScrollPhysics(),
                      itemCount: productsList.length,
                      itemBuilder: (ctx, int index) {
                        return ProductCardAsGrid(
                          product: productsList.elementAt(index),
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 20,
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        mainAxisExtent: 270,
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(16, 156, 16, 0),
                      physics: const BouncingScrollPhysics(),
                      itemCount: productsList.length,
                      itemBuilder: (ctx, int index) {
                        return ProductCardAsList(
                          product: productsList.elementAt(index),
                        );
                      },
                    ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 4),
                      blurRadius: 12,
                      color: AllColors.black.withOpacity(0.12),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
                      child: isGrid
                          ? const Text('')
                          : const Text(
                              'Women\'s tops',
                              style: AllStyles.headlineActive,
                            ),
                    ),
                    SizedBox(
                      height: 30,
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          return CategorySmallBadge(
                              title: (subcat.elementAt(index)).title);
                        },
                        separatorBuilder: (_, index) {
                          return const SizedBox(width: 7);
                        },
                        itemCount: subcat.length,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      color: AllColors.appBackgroundColor,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 3,
                            child: GestureDetector(
                              onTap: () => Constants
                                  .globalNavigatorKey.currentState!
                                  .push(
                                MaterialPageRoute(
                                  builder: (context) => const FiltersScreen(),
                                ),
                              ),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                      'assets/icons/filter_list.svg'),
                                  const SizedBox(width: 7),
                                  const Text(
                                    'Filters',
                                    style: AllStyles.dark11w400,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 6,
                            child: GestureDetector(
                              onTap: () => sortingTypeSheet(
                                  context,
                                  sortingTypesMap,
                                  sortingType,
                                  selectSortingFunction),
                              child: Row(
                                children: [
                                  SvgPicture.asset('assets/icons/sorting.svg'),
                                  const SizedBox(width: 7),
                                  Text(
                                    sortingTypeValue,
                                    style: AllStyles.dark11w400,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isGrid = !isGrid;
                                  });
                                },
                                child: SelectView(isGrid: isGrid)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

void sortingTypeSheet(
    BuildContext context,
    Map<SortingTypes, String> sortingTypesMap,
    SortingTypes currentSortingType,
    Function onPress) {
  showModalBottomSheet(
      elevation: 8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      backgroundColor: AllColors.appBackgroundColor,
      context: context,
      useRootNavigator: true,
      builder: (context) {
        return Container(
          height: 352,
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ModalSheetDivider(),
              const SizedBox(height: 16),
              const Text(
                'Sort by',
                style: AllStyles.dark18w600,
              ),
              const SizedBox(height: 16),
              Column(
                children: sortingTypesMap.entries.map((e) {
                  return GestureDetector(
                    onTap: () {
                      onPress(e.key);
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      color: currentSortingType == e.key
                          ? AllColors.primary
                          : AllColors.appBackgroundColor,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        e.value,
                        style: currentSortingType == e.key
                            ? AllStyles.white16w600
                            : AllStyles.dark16w400,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      });
}

class SelectView extends StatelessWidget {
  const SelectView({
    Key? key,
    required this.isGrid,
  }) : super(key: key);

  final bool isGrid;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      width: 24,
      child: isGrid
          ? SvgPicture.asset('assets/icons/list.svg')
          : SvgPicture.asset('assets/icons/grid.svg'),
    );
  }
}
