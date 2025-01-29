import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:space_scutum_test_task/models/component_sizes_model.dart';
import 'package:space_scutum_test_task/providers/query_configuration_provider.dart';
import 'package:space_scutum_test_task/screens/home_screen.dart';
import 'package:space_scutum_test_task/widgets/custom_button_widget.dart';
import 'package:space_scutum_test_task/widgets/users_score_widget.dart';

class ResultsScreen extends ConsumerWidget {
  const ResultsScreen({super.key, required this.userScore});
  final int userScore;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              UsersScoreWidget(score: userScore),
              Text(
                'Let\'s keep testing your knowledge by playing more quizzes!',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              CustomButtonWidget(
                onTap: () {
                  ref.read(queryConfigurationProvider.notifier).clearSettings();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                },
                label: 'Play again',
                buttonWidth: ComponentSizes.primaryButtonWidth,
                buttonHeight: ComponentSizes.primaryButtonHeight,
              )
            ],
          ),
        ),
      ),
    );
  }
}
