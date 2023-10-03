import 'package:flutter/material.dart';

enum GroceryCategory { fruits, vegetables, sweets, drinks }

class Grocery {
  final String name;
  final int quantity;
  final GroceryCategory category;
  Grocery({
    required this.name,
    required this.quantity,
    required this.category,
  });
}

const groceryCategoryColors = {
  GroceryCategory.fruits: Colors.amberAccent,
  GroceryCategory.vegetables: Colors.green,
  GroceryCategory.sweets: Colors.red,
  GroceryCategory.drinks: Colors.blue,
};
