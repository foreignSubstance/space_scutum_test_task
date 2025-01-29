import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:space_scutum_test_task/models/component_sizes_model.dart';
import 'package:space_scutum_test_task/models/question_model.dart';
import 'package:space_scutum_test_task/providers/query_configuration_provider.dart';
import 'package:space_scutum_test_task/providers/timer_provider.dart';
import 'package:space_scutum_test_task/providers/user_answers_provider.dart';
import 'package:space_scutum_test_task/screens/results_screen.dart';
import 'package:space_scutum_test_task/widgets/custom_button_widget.dart';
import 'package:space_scutum_test_task/widgets/single_question_widget.dart';
import 'package:space_scutum_test_task/widgets/timer_widget.dart';

class QuestionsWidget extends ConsumerStatefulWidget {
  final List<Question> questionsList;

  const QuestionsWidget({
    super.key,
    required this.questionsList,
  });

  @override
  ConsumerState<QuestionsWidget> createState() => _QuestionsWidgetState();
}

class _QuestionsWidgetState extends ConsumerState<QuestionsWidget> {
  int _index = 0;

  void showNextQuestion() {
    ref.read(timerProvider.notifier).resetTimer();
    _index++;
    setState(() {});
  }

  void showQuizResult([Timer? timer]) {
    timer?.cancel();
    ref.read(timerProvider.notifier).resetTimer();

    final answers = ref.read(userAnswersProvider);
    int score = 0;
    for (var answer in answers.entries) {
      final correctAnswer = widget.questionsList[answer.key].correctAnswer;
      final chosenAnswer = answer.value;
      if (correctAnswer == chosenAnswer) score++;
    }
    score = (score * 100) ~/ widget.questionsList.length;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return ResultsScreen(userScore: score);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isTimeFinite = ref.watch(queryConfigurationProvider).time != 55;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: ComponentSizes.defaultPadding,
      ),
      child: Column(
        children: [
          SizedBox(height: ComponentSizes.freeSpace),
          if (isTimeFinite)
            TimerWidget(
              onTimeEnd: (timer) {
                if (_index == widget.questionsList.length - 1) {
                  showQuizResult(timer);
                } else {
                  showNextQuestion();
                }
              },
            ),
          SizedBox(height: ComponentSizes.freeSpace),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Question ${_index + 1}/${widget.questionsList.length}',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          Text(
            '.' * 100,
            overflow: TextOverflow.clip,
            maxLines: 1,
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(fontSize: 16),
          ),
          Expanded(
            child: SingleQuestionWidget(
              data: widget.questionsList[_index],
              index: _index,
              borderWidth: ComponentSizes.borderWidth,
            ),
          ),
          SizedBox(height: ComponentSizes.freeSpace),
          CustomButtonWidget(
            buttonWidth: ComponentSizes.primaryButtonWidth,
            buttonHeight: ComponentSizes.primaryButtonHeight,
            label: (_index == widget.questionsList.length - 1)
                ? 'Show result'
                : 'Next',
            onTap: (_index == widget.questionsList.length - 1)
                ? showQuizResult
                : showNextQuestion,
          ),
          SizedBox(height: ComponentSizes.freeSpace)
        ],
      ),
    );
  }
}
