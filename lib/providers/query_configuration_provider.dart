import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:space_scutum_test_task/models/quiz_configurator_model.dart';

class QueryConfigurationNotifier extends StateNotifier<QuizConfigurator> {
  QueryConfigurationNotifier() : super(QuizConfigurator());

  void setSettings({
    int? questionsAmount,
    int? time,
    int? category,
    String? difficulty,
  }) {
    state = state.copyWith(
        questionsAmount: questionsAmount,
        time: time,
        category: category,
        difficulty: difficulty);
  }

  void clearSettings() {
    state = QuizConfigurator();
  }
}

final queryConfigurationProvider =
    StateNotifierProvider<QueryConfigurationNotifier, QuizConfigurator>(
        (ref) => QueryConfigurationNotifier());
