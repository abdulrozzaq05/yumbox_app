class Category {
  String idCategory;
  String strCategory;
  String strCategoryThumb;
  String strCategoryDescription;

  Category({
    required this.idCategory,
    required this.strCategory,
    required this.strCategoryThumb,
    required this.strCategoryDescription,
  });

  Category.fromJson(Map<String, dynamic> parsedJson)
      : idCategory = parsedJson['idCategory'],
        strCategory = parsedJson['strCategory'],
        strCategoryThumb = parsedJson['strCategoryThumb'],
        strCategoryDescription = parsedJson['strCategoryDescription'];
}
