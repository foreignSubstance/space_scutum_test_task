import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:space_scutum_test_task/models/component_properties_model.dart';

class QuestionsTrackerWidget extends StatelessWidget {
  const QuestionsTrackerWidget({
    super.key,
    required this.index,
    required this.amount,
    required this.colors,
  });

  final int index;
  final int amount;
  final Map<int, Color> colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TrackerHeaderWidget(index: index, amount: amount),
        _TrackerBarWidget(amount: amount, colors: colors),
      ],
    );
  }
}

class _TrackerHeaderWidget extends StatelessWidget {
  const _TrackerHeaderWidget({
    required this.index,
    required this.amount,
  });

  final int index;
  final int amount;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Question ${index + 1}/$amount',
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }
}

class _TrackerBarWidget extends ConsumerWidget {
  const _TrackerBarWidget({
    required this.amount,
    required this.colors,
  });

  final int amount;
  final Map<int, Color> colors;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double segmentWidth =
        (ComponentSizes.screenWidth - 2 * ComponentSizes.defaultPadding) /
            (amount + 2);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        amount,
        (index) {
          return _TrackerSegmentWidget(
            width: segmentWidth,
            color: colors[index] ?? const Color(0xff9099c2),
          );
        },
      ),
    );
  }
}

class _TrackerSegmentWidget extends StatelessWidget {
  const _TrackerSegmentWidget({
    required this.width,
    required this.color,
  });
  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      width: width,
      height: 3,
      color: color,
    );
  }
}
