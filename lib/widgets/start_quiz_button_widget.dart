import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:space_scutum_test_task/models/component_sizes_model.dart';
import 'package:space_scutum_test_task/providers/query_configuration_provider.dart';
import 'package:space_scutum_test_task/screens/quiz_screen.dart';
import 'package:space_scutum_test_task/widgets/custom_button_widget.dart';

class StartQuizButtonWidget extends ConsumerWidget {
  const StartQuizButtonWidget({
    super.key,
  });

  void startQuiz(BuildContext context, WidgetRef ref) async {
    final isCategorySet = ref.read(queryConfigurationProvider).category != null;
    final isDifficultySet =
        ref.read(queryConfigurationProvider).difficulty != null;
    if (isDifficultySet && isCategorySet) {
      showQuizScreen(context);
    } else {
      showAlertDialog(context);
    }
  }

  void showQuizScreen(BuildContext context) {
    HapticFeedback.lightImpact();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const QuizScreen(),
      ),
    );
  }

  void showAlertDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xff107eeb),
        content: const Text(
          'Please make sure that you set both category and difficulty.',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'OK',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomButtonWidget(
      buttonWidth: ComponentSizes.primaryButtonWidth,
      buttonHeight: ComponentSizes.primaryButtonHeight,
      label: 'Start quiz',
      onTap: () {
        startQuiz(context, ref);
      },
    );
  }
}
