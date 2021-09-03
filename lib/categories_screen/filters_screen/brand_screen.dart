// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:cool_shop/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'models/filter_brand.dart';
import 'widgets/brand_list_tile.dart';
import 'brand_bottom_nav_bar.dart';

class BrandScreen extends StatefulWidget {
  const BrandScreen({
    Key? key,
    required this.brandList,
  }) : super(key: key);

  final List<FilterBrand> brandList;

  @override
  _BrandScreenState createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  List<FilterBrand> oldSelectedBrandList = [];
  List<FilterBrand> brandList = [];
  List<FilterBrand> filteredBrandList = [];

  FilterBrand brand = FilterBrand(title: 'Test', isSelected: false);

  @override
  void initState() {
    oldSelectedBrandList = copyList(widget.brandList);
    brandList = copyList(widget.brandList);
    filteredBrandList = copyList(widget.brandList);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void selectBrand(int index, bool value) {
      filteredBrandList[index].isSelected = value;
      setState(() {});
    }

    void filterBrands(String text) {
      filteredBrandList = brandList
          .where((element) =>
              element.title.toLowerCase().contains(text.toLowerCase()))
          .toList();
      setState(() {});
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Brand',
          style: AllStyles.dark18w600,
        ),
        backgroundColor: AllColors.appBackgroundColor,
        elevation: 3,
        shadowColor: AllColors.black.withOpacity(0.3),
        brightness: Brightness.light,
        iconTheme: const IconThemeData(color: AllColors.dark),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop(oldSelectedBrandList);
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
      bottomNavigationBar: BrandBottomNavBar(
        brandList: filteredBrandList,
        oldSelectedBrandList: oldSelectedBrandList,
      ),
      backgroundColor: AllColors.appBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(16, 21, 16, 0),
            child: Container(
              height: 40,
              width: MediaQuery.of(context).size.width - 32,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 1),
                    blurRadius: 8,
                    color: AllColors.black.withOpacity(0.05),
                  ),
                ],
              ),
              child: TextField(
                onChanged: (value) => filterBrands(value),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AllColors.appBackgroundColor,
                  contentPadding: EdgeInsets.fromLTRB(0, 9, 0, 9),
                  prefixIcon: Icon(
                    CupertinoIcons.search,
                    size: 20,
                  ),
                  hintText: 'Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(23)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(23)),
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 16, right: 16, top: 0),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 2),
                    blurRadius: 2,
                    color: AllColors.black.withOpacity(0.05),
                  )
                ],
                color: AllColors.appBackgroundColor,
              ),
              child: ListView.builder(
                itemBuilder: (_, index) {
                  return BrandListTile(
                    title: filteredBrandList.elementAt(index).title,
                    isSelected: filteredBrandList.elementAt(index).isSelected,
                    onPress: (value) => selectBrand(index, value),
                  );
                },
                shrinkWrap: true,
                itemCount: filteredBrandList.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
