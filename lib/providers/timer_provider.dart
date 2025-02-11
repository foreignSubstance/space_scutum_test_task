import 'dart:async';
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:space_scutum_test_task/providers/query_configuration_provider.dart';

class TimerNotifier extends StateNotifier<TimerModel> {
  TimerNotifier({required this.time}) : super(_initialState);

  static final _initialState = TimerModel(state: TimerState.stopped, value: 0);

  final Ticker _ticker = Ticker();
  StreamSubscription<int>? _subscription;
  final int time;

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void startTimer([VoidCallback? onDone]) {
    _subscription?.cancel();
    _subscription = _ticker.tick(time).listen((time) {
      state = TimerModel(state: TimerState.running, value: time);
    })
      ..onDone(() {
        if (onDone != null) onDone();
        if (state.state == TimerState.running) startTimer(onDone);
      });
  }

  void pauseTimer() {
    _subscription?.pause();
    state = TimerModel(state: TimerState.paused, value: state.value);
  }

  void resumeTimer() {
    _subscription?.resume();
    state = TimerModel(state: TimerState.running, value: state.value);
  }

  void stopTimer() {
    _subscription?.cancel();
    state = _initialState;
  }
}

final timerProvider = StateNotifierProvider<TimerNotifier, TimerModel>((ref) {
  int time = ref.read(queryConfigurationProvider).time!;
  return TimerNotifier(
    time: time,
  );
});

class TimerModel {
  final TimerState state;
  final int value;

  TimerModel({required this.state, required this.value});
}

class Ticker {
  static const _tick = Duration(seconds: 1);
  Stream<int> tick(int time) {
    return Stream.periodic(_tick, (val) => val)
        .takeWhile((event) => event <= time);
  }
}

enum TimerState {
  running,
  paused,
  stopped,
}
