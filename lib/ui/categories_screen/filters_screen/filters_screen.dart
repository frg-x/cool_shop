// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:cool_shop/ui/categories_screen/filters_screen/models/filter_category.dart';
import 'package:cool_shop/ui/categories_screen/filters_screen/models/filter_color.dart';
import 'package:cool_shop/ui/categories_screen/filters_screen/models/filter_size.dart';
import 'package:cool_shop/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'brand_screen.dart';
import 'filters_bottom_nav_bar.dart';
import 'models/filter_brand.dart';
import 'widgets/colored_circle_36x36.dart';
import 'widgets/rounded_square_40x40.dart';
import '../../widgets/rounded_square_100x40.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({
    Key? key,
  }) : super(key: key);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  RangeValues _initialValues = const RangeValues(75, 135);
  List<FilterColor> filterColors = [
    FilterColor(
        id: 1,
        title: 'Dark Gray',
        color: const Color(0xFF020202),
        isSelected: false),
    FilterColor(
        id: 2,
        title: 'Gray',
        color: const Color(0xFFF7F7F7),
        isSelected: false),
    FilterColor(
        id: 3, title: 'Red', color: const Color(0xFFB82222), isSelected: false),
    FilterColor(
        id: 4,
        title: 'Beige',
        color: const Color(0xFFBEA9A9),
        isSelected: false),
    FilterColor(
        id: 5,
        title: 'Skin',
        color: const Color(0xFFE2BB8D),
        isSelected: false),
    FilterColor(
        id: 6,
        title: 'Deep Blue',
        color: const Color(0xFF151867),
        isSelected: false),
  ];

  List<FilterSize> filterSizes = [
    FilterSize(id: 1, title: 'XS', isSelected: false),
    FilterSize(id: 2, title: 'S', isSelected: false),
    FilterSize(id: 3, title: 'M', isSelected: false),
    FilterSize(id: 4, title: 'L', isSelected: false),
    FilterSize(id: 5, title: 'XL', isSelected: false),
  ];

  List<FilterCategory> filterCategory = [
    FilterCategory(title: 'All', isSelected: false),
    FilterCategory(title: 'Women', isSelected: false),
    FilterCategory(title: 'Men', isSelected: false),
    FilterCategory(title: 'Boys', isSelected: false),
    FilterCategory(title: 'Girls', isSelected: false),
  ];

  List<FilterBrand> brandList = [
    FilterBrand(title: 'adidas', isSelected: false),
    FilterBrand(title: 'adidas Originals', isSelected: false),
    FilterBrand(title: 'Blend', isSelected: false),
    FilterBrand(title: 'Boutique Moschino', isSelected: false),
    FilterBrand(title: 'Champion', isSelected: false),
    FilterBrand(title: 'Diesel', isSelected: false),
    FilterBrand(title: 'Jack & Jones', isSelected: false),
    FilterBrand(title: 'Naf Naf', isSelected: false),
    FilterBrand(title: 'Red Valentino', isSelected: false),
    FilterBrand(title: 'H & M ', isSelected: false),
    FilterBrand(title: 's.Oliver', isSelected: false),
  ];

  List<Map<String, dynamic>> oldSelectedBrandList = [];
  List<String> selectedBrands = [];

  void selectColor(int index) {
    setState(() {
      filterColors[index].isSelected = !filterColors[index].isSelected;
    });
  }

  void selectSize(int index) {
    setState(() {
      filterSizes[index].isSelected = !filterSizes[index].isSelected;
    });
  }

  void selectCategory(int index) {
    setState(() {
      filterCategory[index].isSelected = !filterCategory[index].isSelected;
    });
  }

  void updateSelectedBrandsList(List<FilterBrand> list) {
    selectedBrands = [];
    brandList = [];
    brandList = copyList(list);
    for (var element in list) {
      if (element.isSelected) {
        selectedBrands.add(element.title);
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Filters',
          style: AllStyles.dark18w600,
        ),
        backgroundColor: AllColors.appBackgroundColor,
        elevation: 3,
        shadowColor: AllColors.black.withOpacity(0.3),
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
        centerTitle: true,
      ),
      bottomNavigationBar: const FiltersBottomNavBar(),
      extendBody: true,
      body: SizedBox(
        height: MediaQuery.of(context).size.height - 104,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 2),
              Container(
                height: 42,
                padding: const EdgeInsets.only(left: 16),
                width: double.infinity,
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Price range',
                  style: AllStyles.dark16w600,
                ),
                color: AllColors.appBackgroundColor,
              ),
              Container(
                height: 88,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 2),
                      blurRadius: 2,
                      color: AllColors.black.withOpacity(0.05),
                    )
                  ],
                  color: AllColors.white,
                ),
                child: Stack(
                  children: [
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: AllColors.primary,
                        trackHeight: 2.0,
                        inactiveTrackColor: AllColors.gray,
                        thumbColor: AllColors.primary,
                        overlayColor: Colors.transparent,
                        rangeThumbShape: const RoundRangeSliderThumbShape(
                          enabledThumbRadius: 11.0,
                        ),
                        showValueIndicator: ShowValueIndicator.never,
                      ),
                      child: RangeSlider(
                        min: 0,
                        max: 200,
                        //divisions: 40,
                        labels: RangeLabels(
                          _initialValues.start.toString(),
                          _initialValues.end.toString(),
                        ),
                        values: _initialValues,
                        onChanged: (values) {
                          setState(() {
                            _initialValues = values;
                            //print(_values);
                          });
                        },
                      ),
                    ),
                    Positioned(
                      left: 16,
                      top: 21,
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width - 32,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                                '\$${_initialValues.start.round().toString()}'),
                            Text('\$${_initialValues.end.round().toString()}'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 2),
              Container(
                height: 42,
                padding: const EdgeInsets.only(left: 16),
                width: double.infinity,
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Colors',
                  style: AllStyles.dark16w600,
                ),
                color: AllColors.appBackgroundColor,
              ),
              Container(
                height: 88,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 2),
                      blurRadius: 2,
                      color: AllColors.black.withOpacity(0.05),
                    )
                  ],
                  color: AllColors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: filterColors
                      .asMap()
                      .map(
                        (index, element) => MapEntry(
                          index,
                          ColoredCircle36x36(
                            color: element.color,
                            isSelected: element.isSelected,
                            onPress: () => selectColor(index),
                          ),
                        ),
                      )
                      .values
                      .toList(),
                ),
              ),
              const SizedBox(height: 2),
              Container(
                height: 42,
                padding: const EdgeInsets.only(left: 16),
                width: double.infinity,
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Sizes',
                  style: AllStyles.dark16w600,
                ),
                color: AllColors.appBackgroundColor,
              ),
              Container(
                height: 88,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 2),
                      blurRadius: 2,
                      color: AllColors.black.withOpacity(0.05),
                    )
                  ],
                  color: AllColors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: filterSizes
                      .asMap()
                      .map(
                        (index, element) => MapEntry(
                          index,
                          Row(
                            children: [
                              RoundedSquare40x40(
                                size: element.title,
                                isSelected: element.isSelected,
                                onPress: () => selectSize(index),
                              ),
                              const SizedBox(width: 16),
                            ],
                          ),
                        ),
                      )
                      .values
                      .toList(),
                ),
              ),
              const SizedBox(height: 2),
              Container(
                height: 42,
                padding: const EdgeInsets.only(left: 16),
                width: double.infinity,
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Category',
                  style: AllStyles.dark16w600,
                ),
                color: AllColors.appBackgroundColor,
              ),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 2),
                      blurRadius: 2,
                      color: AllColors.black.withOpacity(0.05),
                    )
                  ],
                  color: AllColors.white,
                ),
                child: Wrap(
                  spacing: 12,
                  direction: Axis.horizontal,
                  runSpacing: 12,
                  children: filterCategory
                      .asMap()
                      .map(
                        (index, element) => MapEntry(
                          index,
                          RoundedSquare100x40(
                            title: element.title,
                            isSelected: element.isSelected,
                            onPress: () => selectCategory(index),
                          ),
                        ),
                      )
                      .values
                      .toList(),
                ),
              ),
              const SizedBox(height: 2),
              GestureDetector(
                onTap: () async {
                  Navigator.of(context)
                      .push(
                    MaterialPageRoute(
                      builder: ((context) => BrandScreen(brandList: brandList)),
                    ),
                  )
                      .then((value) {
                    updateSelectedBrandsList(value);
                  });
                },
                child: Container(
                  height: 56,
                  padding: const EdgeInsets.only(left: 16),
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  color: AllColors.appBackgroundColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 12),
                          const Text(
                            'Brand',
                            style: AllStyles.dark16w600,
                          ),
                          const SizedBox(height: 3),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              selectedBrands.join(', '),
                              style: AllStyles.gray11,
                              maxLines: 3,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ],
                      ),
                      SvgPicture.asset('assets/icons/arrow_forward_dark.svg'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
