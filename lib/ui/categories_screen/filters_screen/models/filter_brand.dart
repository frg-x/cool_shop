class FilterBrand {
  FilterBrand({required this.title, required this.isSelected});
  String title;
  bool isSelected;

  FilterBrand copyWith({
    String? title,
    bool? isSelected,
  }) {
    return FilterBrand(
      title: title ?? this.title,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
