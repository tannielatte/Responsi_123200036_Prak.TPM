import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:responsi_123200036_prak/ListCategoryPage.dart';
import 'ListCategoryPage.dart';

class Category {
  String strCategory;
  String strCategoryThumb;

  Category({required this.strCategory, required this.strCategoryThumb});
}

class Kategori extends StatefulWidget {
  @override
  _KategoriState createState() => _KategoriState();
}

class _KategoriState extends State<Kategori> {
  List<Category> categories = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  void fetchCategories() async {
    final response =
    await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'));
    final data = json.decode(response.body);
    List<Category> fetchedCategories = [];
    for (var category in data['categories']) {
      fetchedCategories.add(
        Category(
          strCategory: category['strCategory'],
          strCategoryThumb: category['strCategoryThumb'],
        ),
      );
    }
    setState(() {
      categories = fetchedCategories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category Meal', textAlign: TextAlign.center),
        centerTitle: true,
      ),
      backgroundColor: Colors.blue[100], // Background color: Grey
      body: GridView.builder(
        padding: EdgeInsets.all(16.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ListMakananPage(category: categories[index].strCategory),
                ),
              );
            },
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.grey, // Card background color: White
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.network(
                      categories[index].strCategoryThumb,
                      width: 120,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    categories[index].strCategory,
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
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
