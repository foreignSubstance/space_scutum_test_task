import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:space_scutum_test_task/models/component_properties_model.dart';
import 'package:space_scutum_test_task/models/question_model.dart';
import 'package:space_scutum_test_task/providers/current_question_provider.dart';
import 'package:space_scutum_test_task/providers/query_configuration_provider.dart';
import 'package:space_scutum_test_task/providers/timer_provider.dart';
import 'package:space_scutum_test_task/providers/user_answers_provider.dart';
import 'package:space_scutum_test_task/screens/home_screen.dart';
import 'package:space_scutum_test_task/widgets/custom_button_widget.dart';
import 'package:space_scutum_test_task/widgets/users_score_widget.dart';

class ResultsScreen extends ConsumerWidget {
  const ResultsScreen({
    super.key,
    required this.userScore,
    required this.questions,
  });
  final int userScore;
  final List<Question> questions;

  void resetAllData(WidgetRef ref) {
    ref.read(timerProvider.notifier).stopTimer();
    ref.read(queryConfigurationProvider.notifier).clearSettings();
    ref.read(currentIndexProvider.notifier).resetIndex();
    ref.read(userAnswersProvider.notifier).resetAnswers();
  }

  void showHomeScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAnswers = ref.read(userAnswersProvider);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Congratulations, you\'ve completed this quiz!',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: ComponentSizes.defaultPadding),
              UsersScoreWidget(score: userScore),
              const SizedBox(height: ComponentSizes.defaultPadding),
              Text(
                'So... let`s recap',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: ComponentSizes.defaultPadding / 4),
              InfoListWidget(questions: questions, userAnswers: userAnswers),
              const SizedBox(height: ComponentSizes.defaultPadding),
              CustomButtonWidget(
                onTap: () {
                  resetAllData(ref);
                  showHomeScreen(context);
                },
                label: 'Play again',
              )
            ],
          ),
        ),
      ),
    );
  }
}

class InfoListWidget extends StatelessWidget {
  const InfoListWidget({
    super.key,
    required this.questions,
    required this.userAnswers,
  });

  final List<Question> questions;
  final Map<int, String> userAnswers;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return QuestionInfoWidget(
            index: index,
            question: questions[index].question,
            correctAnswer: questions[index].correctAnswer,
            userAnswer: userAnswers[index],
          );
        },
      ),
    );
  }
}

class QuestionInfoWidget extends StatelessWidget {
  final int index;
  final String question;
  final String correctAnswer;
  final String? userAnswer;

  const QuestionInfoWidget({
    super.key,
    required this.index,
    required this.question,
    required this.correctAnswer,
    required this.userAnswer,
  });

  @override
  Widget build(BuildContext context) {
    final indexColor = userAnswer == correctAnswer
        ? ComponentColors.primaryGreen
        : ComponentColors.primaryRed;
    final shadowColor = userAnswer == correctAnswer
        ? ComponentColors.accentGreen
        : ComponentColors.accentRed;
    return Container(
      margin: const EdgeInsets.only(bottom: ComponentSizes.defaultPadding / 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          ComponentSizes.defaultRadius,
        ),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        children: [
          IndexIndicator(indexColor: indexColor, index: index),
          QuestionInfo(
            question: question,
            correctAnswer: correctAnswer,
            userAnswer: userAnswer,
          ),
        ],
      ),
    );
  }
}

class QuestionInfo extends StatelessWidget {
  const QuestionInfo({
    super.key,
    required this.question,
    required this.correctAnswer,
    required this.userAnswer,
  });

  final String question;
  final String correctAnswer;
  final String? userAnswer;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(
          top: ComponentSizes.defaultPadding / 2,
          bottom: ComponentSizes.defaultPadding / 2,
          right: ComponentSizes.defaultPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailsText(
              headline: 'Question: ',
              text: question,
            ),
            DetailsText(
              headline: 'Correct answer: ',
              text: correctAnswer,
            ),
            DetailsText(
              headline: 'Yours answer: ',
              text: userAnswer ?? '',
            ),
          ],
        ),
      ),
    );
  }
}

class IndexIndicator extends StatelessWidget {
  const IndexIndicator({
    super.key,
    required this.indexColor,
    required this.index,
  });

  final Color indexColor;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(ComponentSizes.defaultPadding),
      width: ComponentSizes.indexRadius,
      height: ComponentSizes.indexRadius,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: indexColor,
      ),
      child: Text(
        '${index + 1}',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}

class DetailsText extends StatelessWidget {
  const DetailsText({
    super.key,
    required this.headline,
    required this.text,
  });

  final String headline;
  final String text;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(
        style: const TextStyle(color: Colors.black),
        children: [
          TextSpan(
            text: headline,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: text)
        ],
      ),
    );
  }
}
