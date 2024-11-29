import 'dart:convert'; // Untuk decoding JSON
import 'package:http/http.dart' as http;
import 'food.dart';
import 'beef_menu_page.dart';
import 'beef_menu.dart';

class HttpService {
  final String baseUrl =
      'https://www.themealdb.com/api/json/v1/1/categories.php';

  // Fungsi untuk mengambil kategori makanan
  Future<List<Category>?> getCategories() async {
    final String uri = baseUrl;

    http.Response result = await http.get(Uri.parse(uri));
    if (result.statusCode == 200) {
      var jsonResponse = json.decode(result.body);
      List<dynamic> categoriesJson = jsonResponse['categories'];
      List<Category> categories =
          categoriesJson.map((json) => Category.fromJson(json)).toList();
      return categories;
    } else {
      print("Failed to fetch data");
      return null;
    }
  }

  // Fungsi untuk mengambil data menu berbahan dasar beef
  Future<List<BeefMenu>?> getBeefMenu() async {
    const String url =
        'https://www.themealdb.com/api/json/v1/1/filter.php?i=beef';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      List<dynamic> mealsJson = jsonResponse['meals'];
      return mealsJson.map((meal) => BeefMenu.fromJson(meal)).toList();
    } else {
      print('Failed to fetch beef menu data');
      return null;
    }
  }

  Future<List<BeefMenu>?> getChickenMenu() async {
    const String url =
        'https://www.themealdb.com/api/json/v1/1/filter.php?i=chicken_breast';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      List<dynamic> mealsJson = jsonResponse['meals'];
      return mealsJson.map((meal) => BeefMenu.fromJson(meal)).toList();
    } else {
      print('Failed to fetch chicken menu data');
      return null;
    }
  }

  Future<List<BeefMenu>?> getLambMenu() async {
    const String url =
        'https://www.themealdb.com/api/json/v1/1/filter.php?i=lamb';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      List<dynamic> mealsJson = jsonResponse['meals'];
      return mealsJson.map((meal) => BeefMenu.fromJson(meal)).toList();
    } else {
      print('Failed to fetch lamb menu data');
      return null;
    }
  }

  Future<List<BeefMenu>?> getPorkMenu() async {
    const String url =
        'https://www.themealdb.com/api/json/v1/1/filter.php?i=pork';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      List<dynamic> mealsJson = jsonResponse['meals'];
      return mealsJson.map((meal) => BeefMenu.fromJson(meal)).toList();
    } else {
      print('Failed to fetch pork menu data');
      return null;
    }
  }

  Future<Map<String, dynamic>?> getMealDetail(String idMeal) async {
    final String url =
        'https://www.themealdb.com/api/json/v1/1/lookup.php?i=$idMeal';

    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return jsonResponse['meals'] != null ? jsonResponse['meals'][0] : null;
    } else {
      print("Failed to fetch meal detail");
      return null;
    }
  }

  Future<List<dynamic>?> getMeals(String ingredient) async {
    final String url =
        'https://www.themealdb.com/api/json/v1/1/filter.php?i=$ingredient';

    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return jsonResponse['meals'];
    } else {
      print("Failed to fetch meals for ingredient: $ingredient");
      return null;
    }
  }
}
