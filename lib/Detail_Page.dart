import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:url_launcher/url_launcher.dart';

class DetailMakananPage extends StatefulWidget {
  final Map<String, dynamic> food;

  DetailMakananPage({required this.food});

  @override
  _DetailMakananPageState createState() => _DetailMakananPageState();
}

class _DetailMakananPageState extends State<DetailMakananPage> {
  Map<String, dynamic> foodDetails = {};

  @override
  void initState() {
    super.initState();
    fetchFoodDetails();
  }

  void fetchFoodDetails() {
    http
        .get(Uri.parse(
        'https://www.themealdb.com/api/json/v1/1/search.php?s=${widget.food['strMeal']}'))
        .then((response) {
      final data = json.decode(response.body);
      setState(() {
        foodDetails = data['meals'][0];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Meal ',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: foodDetails.isNotEmpty
          ? SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                foodDetails['strMeal'],
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  foodDetails['strMealThumb'],
                  width: 330,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Category: ' + foodDetails['strCategory'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 7.0),
                  Text(
                    'Area: ' + foodDetails['strArea'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Text(
                    foodDetails['strInstructions'],
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 15.0),
                  ElevatedButton(
                    onPressed: () {
                      //launch(foodDetails['strYoutube']);
                    },
                    child: Text('Lihat Video di YouTube'),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
          : Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
