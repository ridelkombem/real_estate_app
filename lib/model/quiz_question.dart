import 'package:flutter/material.dart';
import 'package:real_estate_final_app/model/quizzes.dart';

class QuizQuestionScreen extends StatefulWidget {
  const QuizQuestionScreen({
    super.key,
    required this.finalScore,
    required this.resultscreen,
  });
  final void Function(int score) finalScore;
  final void Function() resultscreen;

  @override
  State<QuizQuestionScreen> createState() => _QuizQuestionScreenState();
}

class _QuizQuestionScreenState extends State<QuizQuestionScreen> {
  int questionNumber = 0;
  void answerQuestion(int score) {
    setState(() {
      if (questionNumber < quizzes.length - 1) {
        widget.finalScore(score);
        print(score);

        questionNumber++;
      } else {
        widget.resultscreen();
      }
    });
  }

  quizRestart() {
    setState(() {
      questionNumber = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
              child: Text(quizzes[questionNumber]['questionText'] as String)),
          ...(quizzes[questionNumber]['answers'] as List<Map<String, dynamic>>)
              //the spread operator naturally operates like a listviewbuilder index with values following index by index
              //the text at the index naturally equates the score at the index
              .map((answer) {
            return Center(
                child: Container(
                    child: TextButton(
              child: Text(answer['text']),
              onPressed: () {
                // String chosenAnswer = answer['text'];
                // selectedAnswer = chosenAnswer;
                int chosenScore = answer['score'];
                //the text at the index naturally equates the score at the index at each Textbutton

                answerQuestion(chosenScore);
              },
            )));
          })
        ],
      ),
    );
  }
}
