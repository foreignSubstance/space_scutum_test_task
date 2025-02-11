import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:space_scutum_test_task/models/component_properties_model.dart';
import 'package:space_scutum_test_task/providers/current_question_provider.dart';
import 'package:space_scutum_test_task/providers/query_configuration_provider.dart';
import 'package:space_scutum_test_task/providers/timer_provider.dart';
import 'package:space_scutum_test_task/providers/user_answers_provider.dart';
import 'package:space_scutum_test_task/screens/home_screen.dart';

class AlertWidget extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final String bodyText;
  final AlertType type;
  const AlertWidget({
    super.key,
    required this.width,
    required this.height,
    required this.title,
    required this.bodyText,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        DialogBodyWidget(
          type: type,
          width: width,
          height: height,
          title: title,
          bodyText: bodyText,
        ),
        DialogButton(
          height: height,
          type: AlertType.error,
        ),
        if (type == AlertType.warning)
          DialogButton(
            height: height,
            type: AlertType.warning,
          ),
      ],
    );
  }
}

class DialogBodyWidget extends StatelessWidget {
  const DialogBodyWidget({
    super.key,
    required this.type,
    required this.width,
    required this.height,
    required this.title,
    required this.bodyText,
  });

  final AlertType type;
  final double width;
  final double height;
  final String title;
  final String bodyText;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: AlertAppearance(
        context: context,
        alertType: type,
      ),
      child: SizedBox(
        width: width,
        height: height,
        child: Padding(
          padding: EdgeInsets.only(
            left: height,
            right: ComponentSizes.defaultPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                bodyText,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DialogButton extends ConsumerWidget {
  final double height;
  final AlertType type;

  const DialogButton({
    super.key,
    required this.height,
    required this.type,
  });

  void onCancel(BuildContext context, WidgetRef ref) {
    ref.read(timerProvider.notifier).resumeTimer();
    Navigator.of(context).pop();
  }

  void onConfirm(BuildContext context, WidgetRef ref) {
    resedData(ref);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (ctx) {
          return const HomeScreen();
        },
      ),
    );
  }

  void resedData(WidgetRef ref) {
    ref.read(timerProvider.notifier).stopTimer();
    ref.read(queryConfigurationProvider.notifier).clearSettings();
    ref.read(currentIndexProvider.notifier).resetIndex();
    ref.read(userAnswersProvider.notifier).resetAnswers();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double leftPos =
        ComponentSizes.screenWidth - ComponentSizes.defaultPadding - height / 2;
    final double topPos;
    final String label;
    final void Function() onTap;

    switch (type) {
      case AlertType.error:
        topPos = ComponentSizes.screenHeight / 2 - height / 2;
        label = 'X';
        onTap = () {
          onCancel(context, ref);
        };
        break;
      case AlertType.warning:
        topPos = ComponentSizes.screenHeight / 2;
        label = '✓';
        onTap = () {
          onConfirm(context, ref);
        };
        break;
    }

    return Positioned(
      left: leftPos,
      top: topPos,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: height / 2,
          height: height / 2,
          decoration: const BoxDecoration(color: Colors.transparent),
          alignment: Alignment.center,
          child: Baseline(
            baseline: 24,
            baselineType: TextBaseline.alphabetic,
            child: Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }
}

enum AlertType { error, warning }

enum ButtonType { confitm, cancel }

class AlertAppearance extends CustomPainter {
  final BuildContext context;
  final AlertType alertType;

  AlertAppearance({
    super.repaint,
    required this.context,
    required this.alertType,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Color primaryColor;
    final Color secondaryColor;
    final Paint paint = Paint();
    switch (alertType) {
      case AlertType.error:
        primaryColor = const Color(0xfffc2e20);
        secondaryColor = const Color(0xff940000);
        break;
      case AlertType.warning:
        primaryColor = const Color(0xfff9943b);
        secondaryColor = const Color(0xffd05301);
        break;
      default:
        primaryColor = const Color(0xff65acf0);
        secondaryColor = const Color(0xff2a72c3);
    }

    paint.color = primaryColor;

    //Helpers
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radiusDimension = size.height / 4;

    //Main Shape
    final Rect rect = Rect.fromCenter(
      center: center,
      width: size.width,
      height: size.height,
    );
    final Radius radius = Radius.circular(radiusDimension);
    final RRect mainRRect = RRect.fromRectAndRadius(rect, radius);
    canvas.drawRRect(mainRRect, paint);

    //Color for label and circles
    paint.color = secondaryColor;

    //Label
    final Offset labelOffset = Offset(2 * radiusDimension, 0);
    canvas.drawCircle(labelOffset, radiusDimension, paint);
    final double arcDisplaceX = radiusDimension / 16;
    final double arcDisplaceY = radiusDimension / 4;
    final labelPath = Path()
      ..moveTo(
          2 * radiusDimension - arcDisplaceX, radiusDimension + arcDisplaceY)
      ..arcToPoint(
        Offset(
            2 * radiusDimension + arcDisplaceX, radiusDimension + arcDisplaceY),
        radius: const Radius.circular(2),
        clockwise: false,
      )
      ..lineTo(3 * radiusDimension, 0)
      ..lineTo(radiusDimension, 0)
      ..close();
    canvas.drawPath(labelPath, paint);
    //Label symbol
    final String text = switch (alertType) {
      AlertType.error => '!',
      AlertType.warning => '?',
    };
    final labelText = TextPainter(
        text: TextSpan(
          text: text,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 24),
        ),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center);
    labelText.layout();
    final textOffset = Offset(
      labelOffset.dx - labelText.size.width / 2,
      -labelText.size.height / 2,
    );
    labelText.paint(canvas, textOffset);

    // Tiny circle
    final double tinyOffsetX = radiusDimension / 2;
    final double tinyOffsetY = radiusDimension + radiusDimension / 2;
    final double tinyRadius = radiusDimension / 8;
    final Offset tinyCircleOffset = Offset(tinyOffsetX, tinyOffsetY);
    canvas.drawCircle(tinyCircleOffset, tinyRadius, paint);

    //Small circle
    final double smallOffsetX = radiusDimension;
    final double smallOffsetY = size.height / 2 + size.height / 8;
    final double smallRadius = radiusDimension / 5;
    final Offset smallCircleOffset = Offset(smallOffsetX, smallOffsetY);
    canvas.drawCircle(smallCircleOffset, smallRadius, paint);

    //Medium circle
    final double mediumOffsetX = 3 * radiusDimension - radiusDimension / 2;
    final double mediumOffsetY = size.height / 2 + size.height / 32;
    final double mediumRadius = radiusDimension / 3;
    final Offset mediumCircleOffset = Offset(mediumOffsetX, mediumOffsetY);
    canvas.drawCircle(mediumCircleOffset, mediumRadius, paint);

    //Big circle
    canvas.clipRRect(mainRRect);
    final double bigOffsetX = size.width / 32;
    final double bigOffsetY = size.height + size.height / 4;
    final double bigRadius = size.height / 2;
    final Offset bigCircleOffset = Offset(bigOffsetX, bigOffsetY);
    canvas.drawCircle(bigCircleOffset, bigRadius, paint);
  }

  @override
  bool shouldRepaint(AlertAppearance oldDelegate) {
    return false;
  }
}
