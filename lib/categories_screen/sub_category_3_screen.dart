// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:cool_shop/constants.dart';
import 'package:cool_shop/cubit/tab_switching/tab_switching_cubit.dart';
import 'package:cool_shop/widgets/big_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SubCategory_3_Screen extends StatefulWidget {
  static const namedRoute = '/subcat3';

  const SubCategory_3_Screen({
    Key? key,
  }) : super(key: key);
  @override
  _SubCategory_3_ScreenState createState() => _SubCategory_3_ScreenState();
}

class _SubCategory_3_ScreenState extends State<SubCategory_3_Screen> {
  @override
  Widget build(BuildContext context) {
    final title = ModalRoute.of(context)!.settings.arguments as String;
    return BlocBuilder<TabSwitchingCubit, TabSwitchingState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AllColors.appBackgroundColor,
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
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      title,
                      style: AllStyles.gray14,
                    ),
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
