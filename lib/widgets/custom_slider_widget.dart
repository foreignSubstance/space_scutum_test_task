import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:space_scutum_test_task/providers/query_configuration_provider.dart';

class CustomSliderWidget extends StatelessWidget {
  const CustomSliderWidget({
    super.key,
    required this.min,
    required this.max,
    required this.divisions,
    required this.type,
  });

  final double min;
  final double max;
  final int divisions;
  final String type;

  @override
  Widget build(BuildContext context) {
    final sliderThemeData = SliderTheme.of(context).copyWith(
      trackHeight: 20,
      thumbShape: SliderThumbAppearance(
        thumbRadius: 20,
        min: min,
        max: max,
      ),
      tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 2),
      activeTrackColor: const Color(0xFF0072ff),
      inactiveTrackColor: const Color(0xFF0072ff).withOpacity(0.3),
      activeTickMarkColor: Colors.white,
      inactiveTickMarkColor: Colors.white.withOpacity(0.3),
      overlayColor: Colors.white.withOpacity(0.3),
      thumbColor: const Color(0xFF0072ff),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SliderTheme(
        data: sliderThemeData,
        child: CustomSlider(
          min: min,
          max: max,
          divisions: divisions,
          type: type,
        ),
      ),
    );
  }
}

class CustomSlider extends ConsumerStatefulWidget {
  const CustomSlider({
    super.key,
    required this.min,
    required this.max,
    required this.divisions,
    required this.type,
  });
  final double min;
  final double max;
  final int divisions;
  final String type;

  @override
  ConsumerState<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends ConsumerState<CustomSlider> {
  late double _currentSliderValue;
  @override
  void initState() {
    super.initState();
    _currentSliderValue = widget.min;
  }

  void onChanged(double value) {
    _currentSliderValue = value.floorToDouble();
    final notifier = ref.read(queryConfigurationProvider.notifier);

    setState(
      () {
        HapticFeedback.lightImpact();
        if (widget.type == 'time') {
          notifier.setSettings(time: _currentSliderValue.toInt());
        } else if (widget.type == 'quantity') {
          notifier.setSettings(questionsAmount: _currentSliderValue.toInt());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: _currentSliderValue,
      onChanged: onChanged,
      min: widget.min,
      max: widget.max,
      divisions: widget.divisions,
    );
  }
}

class SliderThumbAppearance extends SliderComponentShape {
  final double thumbRadius;
  final double min;
  final double max;

  const SliderThumbAppearance({
    required this.thumbRadius,
    required this.min,
    required this.max,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final canvas = context.canvas;
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, thumbRadius, paint);

    String thumbText = getValue(value);

    final span = TextSpan(
      text: thumbText != '55' ? thumbText : '∞',
      style: TextStyle(
        color: sliderTheme.thumbColor,
        fontSize: thumbRadius * 0.8,
        fontWeight: FontWeight.bold,
      ),
    );

    final textPainter = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    textPainter.layout();
    final textCenter = Offset(
      center.dx - textPainter.width / 2,
      center.dy - textPainter.height / 2,
    );
    textPainter.paint(canvas, textCenter);
  }

  String getValue(double value) {
    return (min + (max - min) * value).toStringAsFixed(0);
  }
}
