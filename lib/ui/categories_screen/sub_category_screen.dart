// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cool_shop/ui/categories_screen/sub_sub_category_screen.dart';
import 'package:cool_shop/constants.dart';
import 'package:cool_shop/cubit/tab_switching/tab_switching_cubit.dart';
import 'package:cool_shop/models/sub_category_2.dart';
import 'package:cool_shop/ui/widgets/big_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubCategoryScreen extends StatefulWidget {
  const SubCategoryScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final subSubCategories =
        ModalRoute.of(context)!.settings.arguments as List<SubCategory2>;
    return BlocBuilder<TabSwitchingCubit, TabSwitchingState>(
      builder: (context, state) {
        //activeScreenNumber = (state as TabsSwitch).activeScreenNumber;
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Categories',
              style: AllStyles.dark18w600,
            ),
            backgroundColor: AllColors.appBackgroundColor,
            elevation: 8,
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
            centerTitle: true,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BigButton(
                      child: const Text(
                        'VIEW ALL ITEMS',
                        style: AllStyles.bigButton,
                      ),
                      onPress: () {},
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Choose category',
                      style: AllStyles.gray14,
                    ),
                  ],
                ),
              ),
              //const SizedBox(height: 18),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (cxt, index) {
                      return SubSubCatItem(
                        title: subSubCategories[index].title,
                        onPress: () =>
                            Constants.categoryNavigatorKey.currentState!.push(
                          MaterialPageRoute(
                            builder: (ctx) => const SubSubCategoryScreen(),
                            settings: RouteSettings(
                              arguments: subSubCategories[index].title,
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (ctx, _) {
                      return const Divider();
                    },
                    itemCount: subSubCategories.length),
              ),
            ],
          ),
        );
      },
    );
  }
}

class SubSubCatItem extends StatelessWidget {
  const SubSubCatItem({Key? key, required this.title, required this.onPress})
      : super(key: key);
  final String title;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPress(),
      child: Container(
        padding: const EdgeInsets.only(left: 40),
        height: 47,
        width: double.infinity,
        color: Colors.transparent,
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: AllStyles.dark16w400,
        ),
      ),
    );
  }
}
