import 'package:flutter/material.dart';

class DifficultyWidget extends StatelessWidget {
  const DifficultyWidget({
    super.key,
    required this.onLevelChose,
    required this.title,
    required this.isSelected,
  });

  final Function() onLevelChose;
  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onLevelChose,
      child: AnimatedContainer(
        height: isSelected ? 100 : 80,
        padding: EdgeInsets.symmetric(horizontal: isSelected ? 8 : 18),
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear,
        child: Image.asset(
          'assets/$title.png',
          color: isSelected ? null : const Color(0xff252c4a).withOpacity(0.3),
          colorBlendMode: BlendMode.dstATop,
        ),
      ),
    );
  }
}
