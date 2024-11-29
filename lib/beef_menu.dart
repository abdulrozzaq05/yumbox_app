class BeefMenu {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;

  BeefMenu({
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
  });

  factory BeefMenu.fromJson(Map<String, dynamic> json) {
    return BeefMenu(
      idMeal: json['idMeal'],
      strMeal: json['strMeal'],
      strMealThumb: json['strMealThumb'],
    );
  }
}
