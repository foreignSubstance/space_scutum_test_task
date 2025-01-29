import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:space_scutum_test_task/providers/query_configuration_provider.dart';
import 'package:space_scutum_test_task/widgets/single_difficulty_widget.dart';

class AllDifficultiesWidget extends ConsumerStatefulWidget {
  const AllDifficultiesWidget({super.key});

  @override
  ConsumerState<AllDifficultiesWidget> createState() =>
      _AllDifficultiesiesWidgetState();
}

class _AllDifficultiesiesWidgetState
    extends ConsumerState<AllDifficultiesWidget> {
  final List<String> _difficultyLevels = ['easy', 'medium', 'hard'];
  String selectedDifficulty = '';

  void setSelectedDifficulty(String title) {
    if (selectedDifficulty != title) {
      setState(() {
        selectedDifficulty = title;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ..._difficultyLevels.map(
            (difficulty) => DifficultyWidget(
              onLevelChose: () {
                HapticFeedback.lightImpact();
                ref
                    .read(queryConfigurationProvider.notifier)
                    .setSettings(difficulty: difficulty);
                setSelectedDifficulty(difficulty);
              },
              title: difficulty,
              isSelected: selectedDifficulty == difficulty,
            ),
          ),
        ],
      ),
    );
  }
}
