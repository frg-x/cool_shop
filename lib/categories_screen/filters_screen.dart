// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:cool_shop/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'widgets/filters_bottom_nav_bar.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({
    Key? key,
  }) : super(key: key);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  RangeValues _initialValues = RangeValues(30, 300);

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
        centerTitle: true,
      ),
      bottomNavigationBar: FiltersBottomNavBar(),
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
                padding: EdgeInsets.only(left: 16),
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
                      offset: Offset(0, 2),
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
                        rangeThumbShape: RoundRangeSliderThumbShape(
                          enabledThumbRadius: 11.0,
                        ),
                        showValueIndicator: ShowValueIndicator.never,
                      ),
                      child: RangeSlider(
                        min: 0,
                        max: 500,
                        divisions: 100,
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
                padding: EdgeInsets.only(left: 16),
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
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 2,
                      color: AllColors.black.withOpacity(0.05),
                    )
                  ],
                  color: AllColors.white,
                ),
              ),
              const SizedBox(height: 2),
              Container(
                height: 42,
                padding: EdgeInsets.only(left: 16),
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
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 2,
                      color: AllColors.black.withOpacity(0.05),
                    )
                  ],
                  color: AllColors.white,
                ),
              ),
              const SizedBox(height: 2),
              Container(
                height: 42,
                padding: EdgeInsets.only(left: 16),
                width: double.infinity,
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Category',
                  style: AllStyles.dark16w600,
                ),
                color: AllColors.appBackgroundColor,
              ),
              Container(
                height: 88,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 2,
                      color: AllColors.black.withOpacity(0.05),
                    )
                  ],
                  color: AllColors.white,
                ),
              ),
              const SizedBox(height: 2),
              Container(
                height: 42,
                padding: EdgeInsets.only(left: 16),
                width: double.infinity,
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Brand',
                  style: AllStyles.dark16w600,
                ),
                color: AllColors.appBackgroundColor,
              ),
              Container(
                height: 88,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 2,
                      color: AllColors.black.withOpacity(0.05),
                    )
                  ],
                  color: AllColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
