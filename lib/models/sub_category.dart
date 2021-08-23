import 'sub_sub_category.dart';

class SubCategory {
  SubCategory(
      {required this.id,
      required this.title,
      required this.image,
      required this.subSubCategories});
  int id;
  String title;
  String? image;
  List<SubSubCategory> subSubCategories;
}
