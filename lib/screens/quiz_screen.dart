import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:space_scutum_test_task/providers/fetched_data_provider.dart';
import 'package:space_scutum_test_task/screens/error_screen.dart';
import 'package:space_scutum_test_task/widgets/questions_widget.dart';

class QuizScreen extends ConsumerWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final someList = ref.watch(fetchedDataProvider);
    final content = someList.when(
      data: (list) => QuestionsWidget(questionsList: list),
      error: (error, stack) => const ErrorScreen(),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
    return Scaffold(
      body: content,
    );
  }
}
