import 'package:flutter/material.dart';

class MealDetailPage extends StatelessWidget {
  final String mealName;
  final String mealImage;
  final String mealInstructions;
  final List<String> ingredients;

  MealDetailPage({
    required this.mealName,
    required this.mealImage,
    required this.mealInstructions,
    required this.ingredients,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mealName),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              mealImage,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Ingredients",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ...ingredients.map((ingredient) => ListTile(
                  leading: Icon(Icons.check_circle_outline),
                  title: Text(ingredient),
                )),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Instructions",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(mealInstructions),
            ),
          ],
        ),
      ),
    );
  }
}
