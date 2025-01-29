import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimerNotifier extends StateNotifier<double> {
  TimerNotifier() : super(0);
  void incrementTimer() {
    state = (state * 10 + 1) / 10;
  }

  void resetTimer() {
    state = 0;
  }
}

final timerProvider =
    StateNotifierProvider<TimerNotifier, double>((ref) => TimerNotifier());
