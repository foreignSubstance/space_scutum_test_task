import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentIndexNotifier extends StateNotifier<int> {
  CurrentIndexNotifier() : super(0);

  void incrementIndex() {
    state++;
  }

  void resetIndex() {
    state = 0;
  }
}

final currentIndexProvider = StateNotifierProvider<CurrentIndexNotifier, int>(
    (ref) => CurrentIndexNotifier());
