// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cool_shop/ui/categories_screen/sub_category_screen.dart';
import 'package:cool_shop/constants.dart';
import 'package:cool_shop/models/sub_category.dart';
import 'package:flutter/material.dart';

import 'sub_category_banner.dart';

class CaregoriesList extends StatelessWidget {
  const CaregoriesList({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    final category = categories.firstWhere((element) => element.id == id);
    final subCategories = category.subCategories;
    List<Widget> list = [];
    for (var element in subCategories) {
      if (element.runtimeType == SubCategoryBanner) {
        list.add(element as SubCategoryBanner);
      } else {
        list.add(
          CategoryBigCard(
            image: (element as SubCategory).image!,
            title: (element.title),
            onPress: () => Constants.categoryNavigatorKey.currentState!.push(
              MaterialPageRoute(
                builder: (context) => SubCategoryScreen(id: id),
                settings: RouteSettings(arguments: element.subSubCategories),
              ),
            ),
          ),
        );
      }
    }
    return ListView.builder(
      itemBuilder: (_, index) {
        return list.elementAt(index);
      },
      itemCount: list.length,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
    );
  }
}

class CategoryBigCard extends StatelessWidget {
  const CategoryBigCard({
    Key? key,
    required this.title,
    required this.image,
    required this.onPress,
  }) : super(key: key);

  final String title;
  final String image;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () => onPress(),
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 1),
                  blurRadius: 25,
                  color: AllColors.black.withOpacity(0.08),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 100,
                    padding: const EdgeInsets.only(left: 23),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      style: AllStyles.dark18w600,
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                      color: AllColors.white,
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 100,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      color: AllColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
