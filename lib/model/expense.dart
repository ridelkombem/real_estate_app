import 'package:flutter/material.dart';

enum Category { work, leisure, food, travel }

class Expense {
  final String title;
  final double amount;
  final Category category;
  final DateTime date;

  Expense(
      {required this.title,
      required this.amount,
      required this.category,
      required this.date});
}

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work
};


// class Task {
//   final String taskname;
//   bool isChecked;

//   Task({required this.taskname, this.isChecked = false});
// }


// List<bool> selectedCheckBox = [];


//     @override
//   void initState() {
//     selectedCheckBox = List<bool>.filled(taskbank.length, false);
//     super.initState();
//   }




//     Checkbox(
//      value: selectedCheckBox[i],
//     onChanged: (value) {
//     setState(() {
//     selectedCheckBox[i] = value!;
//        });
//        })