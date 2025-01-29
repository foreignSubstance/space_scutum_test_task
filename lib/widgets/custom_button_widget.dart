import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget(
      {super.key,
      required this.buttonWidth,
      required this.buttonHeight,
      required this.label,
      required this.onTap});

  final double buttonWidth;
  final double buttonHeight;
  final String label;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ButtonAppearance(
        context: context,
        width: buttonWidth,
        height: buttonHeight,
        label: label,
      ),
      child: Material(
        color: Colors.transparent,
        child: Ink(
          width: buttonWidth,
          height: buttonHeight,
          child: InkWell(
              borderRadius: BorderRadius.circular(buttonHeight / 2),
              onTap: onTap),
        ),
      ),
    );
  }
}

class ButtonAppearance extends CustomPainter {
  final BuildContext context;
  final double width;
  final double height;
  final String label;

  ButtonAppearance(
      {super.repaint,
      required this.context,
      required this.width,
      required this.height,
      required this.label});
  @override
  void paint(Canvas canvas, Size size) {
    final mainPainter = Paint();
    mainPainter.color = const Color(0xff107eeb);

    final mainOffset = Offset(width / 2, height / 2);
    final mainShape = Rect.fromCenter(
      center: mainOffset,
      width: width,
      height: height,
    );
    final mask = RRect.fromRectAndRadius(mainShape, Radius.circular(width));
    canvas.clipRRect(mask);

    canvas.drawRect(mainShape, mainPainter);

    mainPainter.color = const Color(0xff2d8ded);
    canvas.drawCircle(
        Offset(width / 4, height / 2) + mainOffset, width / 4, mainPainter);
    canvas.drawCircle(
        Offset(-width / 4, -height / 4) + mainOffset, width / 8, mainPainter);
    canvas.drawCircle(
        Offset(-width / 4, height / 4) + mainOffset, width / 24, mainPainter);

    final buttonLabel = TextPainter(
      text: TextSpan(
        text: label,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
          shadows: [
            const Shadow(
              color: Colors.black,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
      ),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );
    buttonLabel.layout();

    final textHeight = buttonLabel.computeLineMetrics()[0].height;
    final textWidth = buttonLabel.computeLineMetrics()[0].width;
    final textOffset = Offset(
      -textWidth / 2,
      -textHeight / 2,
    );
    buttonLabel.paint(canvas, textOffset + mainOffset);
  }

  @override
  bool shouldRepaint(ButtonAppearance oldDelegate) {
    return false;
  }
}
