import 'package:flutter/material.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'http_service.dart';
import 'food.dart';
import 'food_detail.dart';
import 'beef_menu_page.dart';
import 'chicken_menu_page.dart';
import 'lamb_menu_page.dart';
import 'pork_menu_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final HttpService service = HttpService();
  List<Category> categories = [];
  final List<String> carouselImages = [
    "https://www.themealdb.com/images/media/meals/1529444830.jpg",
    "https://www.themealdb.com/images/media/meals/1548772327.jpg",    
  ];

  @override
  void initState() {
    super.initState();
    service.getCategories().then((value) {
      setState(() {
        if (value != null) {
          categories = value.cast<Category>();
        } else {
          print("Data tidak ditemukan");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: GradientAppBar(
          title: const Text('YUMBOX'),
          gradient: LinearGradient(
            colors: [Colors.red.shade600, Colors.pink.shade200],
          ),
        ),
        body: categories.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Carousel Slider
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 200,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 6),
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,
                    ),
                    items: carouselImages.map((image) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(image),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              color: Colors.black.withOpacity(0.5),
                              child: Text(
                                "Discover Delicious Recipes!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),

                  // Section Title
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "What do you want to cook today?",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Divider
                  Divider(
                    color: Colors.grey.shade400,
                    thickness: 1.0,
                    indent: 16.0,
                    endIndent: 16.0,
                  ),
                  SizedBox(height: 10),

                  // Grid View untuk kategori
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(10.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final category = categories[index];
                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10.0),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CategoryDetail(category),
                                ),
                              );
                            },
                            child: Column(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(10.0)),
                                    child: Image.network(
                                      category.strCategoryThumb,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    category.strCategory,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
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
                  ),
                ],
              ),
        drawer: Drawer(
          child: Builder(
            builder: (BuildContext context) {
              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  const DrawerHeader(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(177, 236, 145, 145),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome to YumBox",
                          style: TextStyle(fontSize: 22),
                        ),
                        SizedBox(height: 5),
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage('image/player.jpg'),
                        ),
                        Text(
                          'SeleroBundo@gmail.com',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.fastfood),
                    title: Text('Beef'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => BeefMenuPage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.fastfood),
                    title: Text('Chicken'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ChickenMenuPage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.fastfood),
                    title: Text('Lamb'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LambMenuPage(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.fastfood),
                    title: const Text('Pork'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PorkMenuPage(),
                        ),
                      );
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Setting'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    trailing: const Icon(Icons.cancel),
                    title: const Text('Close'),
                    onTap: () {
                      Navigator.of(context).pop(); // Menutup Drawer
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
