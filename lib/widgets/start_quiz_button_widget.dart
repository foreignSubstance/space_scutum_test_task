import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:space_scutum_test_task/models/component_properties_model.dart';
import 'package:space_scutum_test_task/providers/current_question_provider.dart';
import 'package:space_scutum_test_task/providers/query_configuration_provider.dart';
import 'package:space_scutum_test_task/providers/timer_provider.dart';
import 'package:space_scutum_test_task/screens/quiz_screen.dart';
import 'package:space_scutum_test_task/widgets/alert_widget.dart';
import 'package:space_scutum_test_task/widgets/custom_button_widget.dart';

class StartQuizButtonWidget extends ConsumerWidget {
  const StartQuizButtonWidget({
    super.key,
  });

  void _startQuiz(BuildContext context, WidgetRef ref) async {
    final isCategorySet = ref.read(queryConfigurationProvider).category != null;
    final isDifficultySet =
        ref.read(queryConfigurationProvider).difficulty != null;
    if (isDifficultySet && isCategorySet) {
      ref.read(timerProvider.notifier).startTimer(() {
        onQuestionTimeEnd(ref);
      });
      _showQuizScreen(context);
    } else {
      _showAlertDialog(context);
    }
  }

  void onQuestionTimeEnd(WidgetRef ref) {
    final index = ref.read(currentIndexProvider);
    final questionsAmount =
        ref.read(queryConfigurationProvider).questionsAmount;
    if (index < questionsAmount - 1) {
      ref.read(currentIndexProvider.notifier).incrementIndex();
    } else {
      ref.read(timerProvider.notifier).pauseTimer();
    }
  }

  void _showQuizScreen(BuildContext context) {
    HapticFeedback.lightImpact();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const QuizScreen(),
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, _, __) {
        return AlertWidget(
          width: ComponentSizes.dialogWidth,
          height: ComponentSizes.dialogHeight,
          type: AlertType.error,
          title: 'Oops!',
          bodyText:
              'Please make sure that you set both category and difficulty.',
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        Tween<Offset> tween = Tween(
          begin: const Offset(1, 0),
          end: Offset.zero,
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
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomButtonWidget(
      label: 'Start quiz',
      onTap: () {
        _startQuiz(context, ref);
      },
    );
  }
}
