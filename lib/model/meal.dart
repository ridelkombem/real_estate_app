import 'package:flutter/foundation.dart';

enum Affordability { affordable, pricey, luxurious }

enum Complexity { simple, challenging, hard }

class Meal {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final List<String> categories;
  final List<String> ingredients;
  final List<String> steps;
  bool isGlutenFree;
  bool isVegan;
  bool isVegetarian;
  bool isLactoseFree;
 
  final Affordability affordability;
  final Complexity complexity;

  Meal({
   
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.categories,
    required this.ingredients,
    required this.steps,
    required this.isGlutenFree,
    required this.isVegan,
    required this.isVegetarian,
    required this.isLactoseFree,
    required this.affordability,
    required this.complexity,
  });
}
