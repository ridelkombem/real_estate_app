import 'package:flutter/material.dart';
import 'package:real_estate_final_app/model/question_result_screen.dart';
import 'package:real_estate_final_app/model/questions.dart';

class QuestionPageManager extends StatefulWidget {
  const QuestionPageManager({super.key});

  @override
  State<QuestionPageManager> createState() => _QuestionPageManagerState();
}

class _QuestionPageManagerState extends State<QuestionPageManager> {
  List<String> selectedAnswers = [];

  void choseAnswer(answer) {
    selectedAnswers.add(answer);
    if (selectedAnswers.length == questions.length) {
      setState(() {
        activeScreen = 'result-screen';
      });
    }
  }

  var activeScreen = 'question-screen';

  restartQuiz() {
    setState(() {
      selectedAnswers = [];

      activeScreen = 'question-screen';
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screenWidget = QuestionScreen(
      choseAnswer,
    );
    if (activeScreen == 'question-screen') {
      screenWidget = QuestionScreen(
        choseAnswer,
      );
    }
    if (activeScreen == 'result-screen') {
      screenWidget = QuestionResultScreen(selectedAnswers, restartQuiz);
    }
    return Scaffold(appBar: AppBar(), body: screenWidget);
  }
}

class QuestionScreen extends StatefulWidget {
  const QuestionScreen(this.choseAnswer, {super.key});
  final void Function(dynamic answer) choseAnswer;

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int questionNumber = 0;
  void answerQuestion(answer) {
    widget.choseAnswer(answer);
    setState(() {
      questionNumber++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentQuestionIndex = questions[questionNumber];
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Text(currentQuestionIndex.questionText),
            ...(currentQuestionIndex.questionAnswer).map((answer) {
              return TextButton(
                  onPressed: () {
                    answerQuestion(answer);
                  },
                  child: Text(answer));
            })
          ],
        ),
      ),
    );
  }
}
