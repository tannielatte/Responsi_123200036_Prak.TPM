import 'package:flutter/material.dart';
import 'package:responsi_123200036_prak/Category.dart';
import 'Category.dart';
import 'package:http/http.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meal APLIKASI',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: Kategori(),
    );
  }
}

