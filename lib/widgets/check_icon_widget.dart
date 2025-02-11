import 'package:flutter/material.dart';

class CheckIconWidget extends StatelessWidget {
  const CheckIconWidget({
    super.key,
    required this.isChecked,
  });

  final bool isChecked;

  @override
  Widget build(BuildContext context) {
    final decoration = isChecked
        ? BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0xff107eeb),
            border: Border.all(
              color: const Color(0xff107eeb),
              strokeAlign: BorderSide.strokeAlignInside,
              width: 2,
            ),
          )
        : BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xff21486a),
              strokeAlign: BorderSide.strokeAlignInside,
              width: 2,
            ),
          );
    return Container(
      decoration: decoration,
      child: Text(
        String.fromCharCode(Icons.check.codePoint),
        style: TextStyle(
          color: isChecked ? Colors.white : Colors.transparent,
          fontFamily: Icons.check.fontFamily,
          fontSize: 21,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
