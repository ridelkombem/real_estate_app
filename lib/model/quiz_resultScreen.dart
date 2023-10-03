
import 'package:flutter/material.dart';

class QuizResultScreen extends StatelessWidget {
  const QuizResultScreen(
    this.totalScore, {
    super.key,
  });
  final int totalScore;

  String get decision {
    String resultText;
    if (totalScore <= 8) {
      resultText = 'You are Awesome and Innocent!';
    } else if (totalScore <= 12) {
      resultText = 'Pretty Likeable!';
    } else if (totalScore <= 8) {
      resultText = 'You are Strange!';
    } else {
      resultText = 'You are so bad!';
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
              child:
                  Container(color: Colors.amberAccent, child: Text(decision))),
          TextButton(onPressed: () {}, child: const Text('Restart Quiz'))
        ],
      ),
    );
  }
}
