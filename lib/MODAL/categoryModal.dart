class CategoryModal {
  CategoryModal({
    required this.categoryId,
    required this.categoryName,
    required this.categoryImage,
    required this.subcategory,
  });

  String categoryId;
  String categoryName;
  String categoryImage;
  String subcategory;

  factory CategoryModal.fromJson(Map<String, dynamic> json) => CategoryModal(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        categoryImage: json["category_image"],
        subcategory: json["subcategory"],
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_name": categoryName,
        "category_image": categoryImage,
        "subcategory": subcategory,
      };
}
