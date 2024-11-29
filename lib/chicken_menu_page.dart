import 'package:flutter/material.dart';
import 'package:yumbox_app/http_service.dart';
import 'meal_detail.dart';

class ChickenMenuPage extends StatefulWidget {
  @override
  _ChickenMenuPageState createState() => _ChickenMenuPageState();
}

class _ChickenMenuPageState extends State<ChickenMenuPage> {
  final HttpService service = HttpService();
  List<dynamic> meals = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMeals();
  }

  Future<void> fetchMeals() async {
    final data = await service.getMeals('chicken');
    setState(() {
      meals = data ?? [];
      isLoading = false;
    });
  }

  void fetchMealDetail(String idMeal) async {
    final mealDetail = await service.getMealDetail(idMeal);
    if (mealDetail != null) {
      final ingredients = <String>[];
      for (int i = 1; i <= 20; i++) {
        final ingredient = mealDetail['strIngredient$i'];
        final measure = mealDetail['strMeasure$i'];
        if (ingredient != null && ingredient.isNotEmpty) {
          ingredients.add('$ingredient - $measure');
        }
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MealDetailPage(
            mealName: mealDetail['strMeal'],
            mealImage: mealDetail['strMealThumb'],
            mealInstructions:
                mealDetail['strInstructions'] ?? 'No instructions provided.',
            ingredients: ingredients,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chicken Menu"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 kolom
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 0.8, // Mengatur rasio card
              ),
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: InkWell(
                    onTap: () {
                      fetchMealDetail(meal['idMeal']);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                            child: Image.network(
                              meal['strMealThumb'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            meal['strMeal'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
