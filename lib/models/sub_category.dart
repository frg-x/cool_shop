import 'sub_category_2.dart';

class SubCategory {
  SubCategory(
      {required this.id,
      required this.title,
      required this.image,
      required this.subSubCategories});
  int id;
  String title;
  String? image;
  List<SubCategory_2> subSubCategories;
}
