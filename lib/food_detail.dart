import 'package:flutter/material.dart';
import 'package:yumbox_app/food.dart';

class CategoryDetail extends StatelessWidget {
  final Category category;

  CategoryDetail(this.category);

  @override
  Widget build(BuildContext context) {
    String path = category.strCategoryThumb != null
        ? category.strCategoryThumb
        : 'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';

    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(category.strCategory),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16),
                height: height / 1.5,
                child: Image.network(path),
              ),
              Container(
                child: Text(category.strCategoryDescription),
                padding: EdgeInsets.only(left: 16, right: 16),
              ),
            ],
          ),
        ),
        
      ),
    );
  }
}
