import 'package:yumbox_app/http_service.dart';
import 'package:flutter/material.dart';
import 'food.dart';
import 'food_detail.dart';

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  late int categoriesCount = 7;
  late List<Category> categories = [];
  late HttpService service;

  Future<void> initialize() async {
    categories = await service.getCategories() ?? [];
    setState(() {
      categoriesCount = categories.length;
    });
    print("Categories Count: $categoriesCount"); // Debugging purpose
  }

  @override
  void initState() {
    service = HttpService();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: categoriesCount,
        itemBuilder: (context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: Image.network(
                categories[position].strCategoryThumb,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(categories[position].strCategory),
              onTap: () {
                // Tambahkan navigasi atau aksi ketika item ditekan
              },
            ),
          );
        },
      ),
    );
  }
}
