import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:space_scutum_test_task/models/component_properties_model.dart';
import 'package:space_scutum_test_task/models/question_model.dart';
import 'package:space_scutum_test_task/providers/current_question_provider.dart';
import 'package:space_scutum_test_task/providers/query_configuration_provider.dart';
import 'package:space_scutum_test_task/providers/timer_provider.dart';
import 'package:space_scutum_test_task/providers/user_answers_provider.dart';
import 'package:space_scutum_test_task/screens/results_screen.dart';
import 'package:space_scutum_test_task/widgets/alert_widget.dart';
import 'package:space_scutum_test_task/widgets/custom_button_widget.dart';
import 'package:space_scutum_test_task/widgets/questions_body_widget.dart';
import 'package:space_scutum_test_task/widgets/questions_tracker_widget.dart';
import 'package:space_scutum_test_task/widgets/timer_widget.dart';

class QuestionsWidget extends ConsumerWidget {
  final List<Question> questionsList;

  const QuestionsWidget({
    super.key,
    required this.questionsList,
  });

  void showNextQuestion(WidgetRef ref) {
    ref.read(timerProvider.notifier).startTimer();
    ref.read(currentIndexProvider.notifier).incrementIndex();
  }

  Map<int, Color> setTrackerColors(WidgetRef ref, int index) {
    final answers = ref.read(userAnswersProvider);
    final Map<int, Color> trackerColors = {};
    trackerColors[index] = Colors.blue;
    for (int i = 0; i < index; i++) {
      if (answers[i] != questionsList[i].correctAnswer) {
        trackerColors[i] = Colors.red;
      } else {
        trackerColors[i] = Colors.green;
      }
    }
    return trackerColors;
  }

  void showQuizResult({required BuildContext context, required WidgetRef ref}) {
    ref.read(timerProvider.notifier).stopTimer();
    int score = countUserScore(ref);
    navigateToResult(context, score);
  }

  void navigateToResult(BuildContext context, int score) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) {
          return ResultsScreen(
            userScore: score,
            questions: questionsList,
          );
        },
      ),
    );
  }

  int countUserScore(WidgetRef ref) {
    final answers = ref.read(userAnswersProvider);
    int score = 0;
    for (var answer in answers.entries) {
      final correctAnswer = questionsList[answer.key].correctAnswer;
      final chosenAnswer = answer.value;
      if (correctAnswer == chosenAnswer) score++;
    }
    score = (score * 100) ~/ questionsList.length;
    return score;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalTime = ref.read(queryConfigurationProvider).time!;
    final currentIndex = ref.watch(currentIndexProvider);
    final questionsAmount = questionsList.length;
    final isTimeFinite = totalTime != 55;
    final colors = setTrackerColors(ref, currentIndex);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: ComponentSizes.defaultPadding,
      ),
      child: Column(
        children: [
          if (isTimeFinite) const TimerWidget(),
          SizedBox(height: ComponentSizes.freeSpace),
          QuestionsTrackerWidget(
            index: currentIndex,
            amount: questionsAmount,
            colors: colors,
          ),
          QuestionsBodyWidget(
            data: questionsList[currentIndex],
            index: currentIndex,
            borderWidth: ComponentSizes.borderWidth,
          ),
          SizedBox(height: ComponentSizes.freeSpace),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const PauseButtonWidget(),
              CustomButtonWidget(
                label: (currentIndex == questionsAmount - 1)
                    ? 'Show result'
                    : 'Next',
                onTap: () {
                  (currentIndex == questionsAmount - 1)
                      ? showQuizResult(context: context, ref: ref)
                      : showNextQuestion(ref);
                },
              ),
            ],
          ),
          SizedBox(height: ComponentSizes.freeSpace)
        ],
      ),
    );
  }
}

class PauseButtonWidget extends StatelessWidget {
  const PauseButtonWidget({
    super.key,
  });

  void showConfirmationDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, _) {
        return AlertWidget(
          width: ComponentSizes.dialogWidth,
          height: ComponentSizes.dialogHeight,
          type: AlertType.warning,
          title: 'Hello there!',
          bodyText: 'All your progress will be lost. Are you sure?',
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        Tween<Offset> tween = Tween(
          begin: const Offset(1, 0),
          end: const Offset(0, 0),
        );
        return SlideTransition(
          position: tween.animate(animation),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return ElevatedButton.icon(
          onPressed: () {
            ref.read(timerProvider.notifier).pauseTimer();
            showConfirmationDialog(context);
          },
          label: const Icon(
            Icons.power_settings_new_rounded,
            color: Colors.white,
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xfffc2e20),
            fixedSize: Size.fromHeight(ComponentSizes.buttonHeight),
          ),
        );
      },
    );
  }
}
