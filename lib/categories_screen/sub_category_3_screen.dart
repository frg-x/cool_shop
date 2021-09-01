// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cool_shop/categories_screen/widgets/product_card_as_list.dart';
import 'package:cool_shop/constants.dart';
import 'package:cool_shop/cubit/products/products_cubit.dart';
import 'package:cool_shop/cubit/tab_switching/tab_switching_cubit.dart';
import 'package:cool_shop/models/sub_category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'filters_screen.dart';
import 'widgets/category_small_badge.dart';
import 'widgets/product_card_as_grid.dart';

enum SortingTypes {
  popular,
  newest,
  customerReview,
  priceLowToHigh,
  priceHighToLow,
}

class SubCategory_3_Screen extends StatefulWidget {
  static const namedRoute = '/subcat3';

  const SubCategory_3_Screen({
    Key? key,
  }) : super(key: key);
  @override
  _SubCategory_3_ScreenState createState() => _SubCategory_3_ScreenState();
}

class _SubCategory_3_ScreenState extends State<SubCategory_3_Screen> {
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
    final productsList = context.read<ProductsCubit>().productsList;
    return BlocBuilder<TabSwitchingCubit, TabSwitchingState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AllColors.appBackgroundColor,
          appBar: AppBar(
            backgroundColor: AllColors.white,
            elevation: 0,
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
              const Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.search,
                  color: AllColors.dark,
                  size: 26,
                ),
              ),
            ],
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
                          title: productsList.elementAt(index).title,
                          imageUrl: productsList.elementAt(index).imageUrl,
                          //onPress: () {},
                          price: productsList.elementAt(index).price,
                          discount: productsList.elementAt(index).discount,
                          rating: productsList.elementAt(index).rating,
                          ratingCount:
                              productsList.elementAt(index).ratingCount,
                          collection: productsList.elementAt(index).collection,
                        );
                      },
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                          title: productsList.elementAt(index).title,
                          imageUrl: productsList.elementAt(index).imageUrl,
                          onPress: () {},
                          price: productsList.elementAt(index).price,
                          discount: productsList.elementAt(index).discount,
                          rating: productsList.elementAt(index).rating,
                          ratingCount:
                              productsList.elementAt(index).ratingCount,
                          collection: productsList.elementAt(index).collection,
                        );
                      },
                    ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 4),
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
                      child: Text(
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
                          return SizedBox(width: 7);
                        },
                        itemCount: subcat.length,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      child: Container(
                        color: AllColors.appBackgroundColor,
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 3,
                              child: GestureDetector(
                                onTap: () => CONSTANTS
                                    .globalNavigatorKey.currentState!
                                    .push(MaterialPageRoute(
                                        builder: (context) => FiltersScreen())),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                        'assets/icons/filter_list.svg'),
                                    SizedBox(width: 7),
                                    Text(
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
                                onTap: () => SelectSortingTypeSheet(
                                    context,
                                    sortingTypesMap,
                                    sortingType,
                                    selectSortingFunction),
                                child: Container(
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                          'assets/icons/sorting.svg'),
                                      SizedBox(width: 7),
                                      Text(
                                        sortingTypeValue,
                                        style: AllStyles.dark11w400,
                                      ),
                                    ],
                                  ),
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

Widget modalSheetDivider() {
  return Container(
    height: 6.0,
    width: 60.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(3)),
      color: AllColors.modalSheetLine,
    ),
  );
}

void SelectSortingTypeSheet(
    BuildContext context,
    Map<SortingTypes, String> sortingTypesMap,
    SortingTypes currentSortingType,
    Function onPress) {
  showModalBottomSheet(
      elevation: 8,
      shape: RoundedRectangleBorder(
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
          padding: EdgeInsets.symmetric(vertical: 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              modalSheetDivider(),
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
                      padding: EdgeInsets.symmetric(horizontal: 16),
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

  final isGrid;

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

// class SelectSorting extends StatelessWidget {
//   const SelectSorting({Key? key, required this.sortingType}) : super(key: key);

//   final sortingType;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 24,
//       width: 24,
//       child: isGrid
//           ? SvgPicture.asset('assets/icons/list.svg')
//           : SvgPicture.asset('assets/icons/grid.svg'),
//     );
//   }
// }
