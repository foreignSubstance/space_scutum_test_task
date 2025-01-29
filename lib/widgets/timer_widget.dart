import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:space_scutum_test_task/models/component_sizes_model.dart';
import 'package:space_scutum_test_task/providers/query_configuration_provider.dart';
import 'package:space_scutum_test_task/providers/timer_provider.dart';

class TimerWidget extends ConsumerStatefulWidget {
  const TimerWidget({
    super.key,
    required this.onTimeEnd,
  });

  final void Function(Timer) onTimeEnd;

  @override
  ConsumerState<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends ConsumerState<TimerWidget> {
  double spentTime = 0;
  late int totalTime;
  late final Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 100), timerCallback);
    totalTime = ref.read(queryConfigurationProvider).time!;
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void timerCallback(Timer timer) {
    spentTime = ref.read(timerProvider);
    if (spentTime < totalTime) {
      setState(() {
        ref.read(timerProvider.notifier).incrementTimer();
      });
    } else {
      widget.onTimeEnd(timer);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentValue = ((ComponentSizes.screenWidth -
                2 * ComponentSizes.borderWidth -
                2 * ComponentSizes.defaultPadding) *
            spentTime) /
        totalTime;
    return SizedBox(
      width: ComponentSizes.screenWidth,
      height: ComponentSizes.freeSpace,
      child: CustomPaint(
        painter: TimerAppearance(
          progressionValue: currentValue,
          borderWidth: ComponentSizes.borderWidth,
        ),
        child: Center(
          child: Text(
            spentTime.toStringAsFixed(0),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class TimerAppearance extends CustomPainter {
  final double progressionValue;
  final double borderWidth;

  TimerAppearance({
    super.repaint,
    required this.progressionValue,
    required this.borderWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final mainPaint = Paint();

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final Rect baseRect = Rect.fromCenter(
      center: Offset(centerX, centerY),
      width: size.width,
      height: size.height,
    );
    final RRect baseRoundedRect = RRect.fromRectAndRadius(
      baseRect,
      Radius.circular(size.height / 2),
    );
    mainPaint.color = const Color(0xff3f4768);
    canvas.drawRRect(baseRoundedRect, mainPaint);

    final double underlayBarWidth = size.width - borderWidth * 2;
    final double underlayBarHeight = size.height - borderWidth * 2;
    final Rect underlayRect = Rect.fromLTWH(
      0 + borderWidth,
      centerY - underlayBarHeight / 2,
      underlayBarWidth,
      underlayBarHeight,
    );
    final RRect underlayRoundedRect = RRect.fromRectAndRadius(
      underlayRect,
      Radius.circular(underlayBarHeight / 2),
    );
    mainPaint.color = const Color(0xff2a3150);
    canvas.drawRRect(underlayRoundedRect, mainPaint);

    final Rect progressRect = Rect.fromLTWH(
      -underlayBarWidth + borderWidth + progressionValue,
      centerY - underlayBarHeight / 2,
      underlayBarWidth,
      underlayBarHeight,
    );
    final RRect progressRoundedRect = RRect.fromRectAndRadius(
      progressRect,
      Radius.circular(underlayBarHeight / 2),
    );
    final Path progressPath = Path.combine(
      PathOperation.intersect,
      Path()..addRRect(underlayRoundedRect),
      Path()..addRRect(progressRoundedRect),
    );

    mainPaint.shader = const LinearGradient(
        colors: [Color(0xffff4f66), Color(0xffb370fd)],
        tileMode: TileMode.clamp,
        stops: [0, 1]).createShader(progressRect);

    canvas.drawPath(progressPath, mainPaint);
    const icon = Icons.timer;
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    textPainter.text = TextSpan(
      text: String.fromCharCode(icon.codePoint),
      style: TextStyle(
        fontFamily: icon.fontFamily,
        fontSize: 20,
      ),
    );
    textPainter.layout();
    final iconHeight = textPainter.computeLineMetrics()[0].height;
    final iconWidth = textPainter.computeLineMetrics()[0].width;
    textPainter.paint(
      canvas,
      Offset(
        2 * centerX - borderWidth - underlayBarHeight / 2 - iconWidth / 2,
        centerY - iconHeight / 2,
      ),
    );
  }

  @override
  bool shouldRepaint(TimerAppearance oldDelegate) {
    return progressionValue != oldDelegate.progressionValue;
  }
}
