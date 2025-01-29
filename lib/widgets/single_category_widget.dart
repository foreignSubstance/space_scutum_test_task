import 'package:flutter/material.dart';

class SingleCategoryWidget extends StatelessWidget {
  const SingleCategoryWidget({
    super.key,
    required this.onCategoryChose,
    required this.title,
    required this.isSelected,
  });

  final void Function() onCategoryChose;
  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCategoryChose,
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
