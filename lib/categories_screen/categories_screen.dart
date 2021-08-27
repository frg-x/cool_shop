// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:cool_shop/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/heading_category_item.dart';
import 'sub_category_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: CONSTANTS.categoryNavigatorKey,
      onGenerateRoute: (route) => MaterialPageRoute(
        settings: route,
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text(
              'Categories',
              style: AllStyles.dark18w600,
            ),
            backgroundColor: AllColors.appBackgroundColor,
            elevation: 8,
            shadowColor: AllColors.black.withOpacity(0.25),
            brightness: Brightness.light,
            iconTheme: const IconThemeData(color: AllColors.dark),
            leading: GestureDetector(
              onTap: () {},
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
          body: CategoryBody(),
        ),
      ),
    );
  }
}

class CategoryBody extends StatefulWidget {
  const CategoryBody({Key? key}) : super(key: key);

  @override
  State<CategoryBody> createState() => _CategoryBodyState();
}

class _CategoryBodyState extends State<CategoryBody> {
  int currentTabNumber = 0;

  void selectCategoryTab(int number) {
    setState(() {
      currentTabNumber = number;
    });
  }

  // int activeScreenNumber = 1;

  @override
  Widget build(BuildContext context) {
    //int activeScreenNumber = (state as TabsSwitch).activeScreenNumber;
    return Column(
      children: [
        SizedBox(
          height: 44,
          child: Row(
            children: categories
                .map(
                  (item) => HeadingCategoryItem(
                    currentTabNumber: currentTabNumber,
                    tabNumber: item.id,
                    title: item.title,
                    onPress: () => selectCategoryTab(item.id),
                  ),
                )
                .toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: SubCategoryScreen(
            id: currentTabNumber,
          ),
        ),
      ],
    );
  }
}
