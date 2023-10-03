import 'package:flutter/material.dart';
import 'package:real_estate_final_app/model/quiz_question.dart';
import 'package:real_estate_final_app/model/quiz_resultScreen.dart';

class QuizPageManager extends StatefulWidget {
  const QuizPageManager({super.key});

  @override
  State<QuizPageManager> createState() => _QuizPageManagerState();
}

class _QuizPageManagerState extends State<QuizPageManager> {
  var activeScreen = 'questionsScreen';

  int totalScore = 0;

  void getScore(int score) {
    totalScore = score + totalScore;
  }

  void switchScreen() {
    setState(() {
      activeScreen = 'resultScreen';
      totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget =
        QuizQuestionScreen(finalScore: getScore, resultscreen: switchScreen);

    if (activeScreen == 'resultScreen') {
      screenWidget = QuizResultScreen(
        totalScore,
      );
    }

    return Scaffold(
      body: Container(
        child: screenWidget,
      ),
    );
  }
}
