import 'package:flutter/material.dart';

class FilterColor {
  FilterColor(
      {required this.id,
      required this.title,
      required this.color,
      required this.isSelected});
  int id;
  String title;
  Color color;
  bool isSelected;
}
