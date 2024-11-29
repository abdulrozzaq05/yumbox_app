import 'package:flutter/material.dart';
import 'package:yumbox_app/http_service.dart';
import 'meal_detail.dart';

class PorkMenuPage extends StatefulWidget {
  @override
  _PorkMenuPageState createState() => _PorkMenuPageState();
}

class _PorkMenuPageState extends State<PorkMenuPage> {
  final HttpService service = HttpService();
  List<dynamic> meals = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMeals();
  }

  Future<void> fetchMeals() async {
    final data = await service.getMeals('pork');
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
        title: const Text("Pork Menu"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(10.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];
                return Card(
                  elevation: 3,
                  margin: EdgeInsets.zero,
                  child: InkWell(
                    onTap: () {
                      fetchMealDetail(meal['idMeal']);
                    },
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.network(
                            meal['strMealThumb'],
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            meal['strMeal'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
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
