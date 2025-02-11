import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserAnswersNotifier extends StateNotifier<Map<int, String>> {
  UserAnswersNotifier() : super({});
  void setAnswers(int index, String answer) {
    var temp = Map.from(state);
    temp[index] = answer;
    state = Map.from(temp);
  }

  void resetAnswers() {
    state = {};
  }
}

final userAnswersProvider =
    StateNotifierProvider<UserAnswersNotifier, Map<int, String>>(
  (ref) => UserAnswersNotifier(),
);
