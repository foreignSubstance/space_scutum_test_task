import 'package:flutter/material.dart';
import 'package:space_scutum_test_task/models/question_model.dart';
import 'package:space_scutum_test_task/widgets/all_answers_widget.dart';

class QuestionsBodyWidget extends StatelessWidget {
  const QuestionsBodyWidget({
    super.key,
    required this.index,
    required this.borderWidth,
    required this.data,
  });

  final int index;
  final double borderWidth;
  final Question data;

  @override
  Widget build(BuildContext context) {
    final answers = [...data.incorrectAnswers, data.correctAnswer]..shuffle();
    final fixedQuestion = data.question;
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            fixedQuestion,
            maxLines: 5,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          AllAnswersWidget(
            answers: answers,
            currentQuestionIndex: index,
          ),
        ],
      ),
    );
  }
}
