import 'package:flutter/material.dart';
import 'package:real_estate_final_app/model/questions.dart';


class QuestionResultScreen extends StatelessWidget {
  const QuestionResultScreen(
    this.chosenAnswers,
    this.restartQuiz, {
    super.key,
  });

  final List<String> chosenAnswers;
  final void Function() restartQuiz;

  List<Map<String, dynamic>> get summary {
    List<Map<String, dynamic>> summaryList = [];
    for (var i = 0; i < chosenAnswers.length; i++) {
      summaryList.add({
        'questionIndex': i,
        'questions': questions[i].questionText,
        'correctAnswers': questions[i].questionAnswer[0],
        'chosenAnswers': chosenAnswers[i],
      });
    }
    return summaryList;
  }

  @override
  Widget build(BuildContext context) {
    int numberQuestions = questions.length;
    var correctQuestions =
        summary.where((e) => e['chosenAnswers'] == e['correctAnswers']).length;

    return Scaffold(
      body: Container(
        color: Colors.purpleAccent,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                  'You have passed ${(correctQuestions).toString()} out of ${(numberQuestions).toString()} questions'),
            ),
            SummaryData(summary: summary),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton.icon(
                  style: TextButton.styleFrom(foregroundColor: Colors.white),
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    restartQuiz();
                  },
                  label: const Text('Restart Quiz')),
            )
          ],
        ),
      ),
    );
  }
}

class SummaryData extends StatelessWidget {
  const SummaryData({
    super.key,
    required this.summary,
  });

  final List<Map<String, dynamic>> summary;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
            children: ((summary)).map((data) {
          return SummaryItem(data);
        }).toList()),
      ),
    );
  }
}

class SummaryItem extends StatelessWidget {
  const SummaryItem(
    this.data, {
    super.key,
  });
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    var isCorrect = data['chosenAnswers'] == data['correctAnswers'];
    var questionIndex = data['questionIndex'];

    return Row(
      children: [
        QuestionIdentifier(isCorrect: isCorrect, questionIndex: questionIndex),
        Expanded(
          child: Column(
            children: [
              Text(
                data['questions'] as String,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
              Text(data['chosenAnswers'] as String,
                  style: TextStyle(color: Colors.purple.shade700)),
              Text(
                data['correctAnswers'] as String,
                style: const TextStyle(color: Colors.greenAccent),
              )
            ],
          ),
        )
      ],
    );
  }
}

class QuestionIdentifier extends StatelessWidget {
  const QuestionIdentifier({
    super.key,
    required this.isCorrect,
    required this.questionIndex,
  });

  final bool isCorrect;
  final int questionIndex;

  @override
  Widget build(BuildContext context) {
    int questionChangesNumber = questionIndex + 1;
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: isCorrect ? Colors.green : Colors.red,
      ),
      height: 30,
      width: 30,
      child: FittedBox(
        child: Text(
          questionChangesNumber.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
