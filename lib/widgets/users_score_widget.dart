import 'package:flutter/material.dart';
import 'package:space_scutum_test_task/models/component_properties_model.dart';

class UsersScoreWidget extends StatelessWidget {
  const UsersScoreWidget({
    super.key,
    required this.score,
  });

  final int score;

  @override
  Widget build(BuildContext context) {
    final TextStyle textTheme = Theme.of(context)
        .textTheme
        .titleLarge!
        .copyWith(color: ComponentColors.primaryButtonBlue, fontSize: 32);
    return Container(
      width: ComponentSizes.screenWidth,
      height: ComponentSizes.buttonHeight * 3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ComponentSizes.defaultRadius),
        boxShadow: const [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(0, 5),
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: textTheme,
              children: [
                const TextSpan(
                  text: 'Your Score is \n',
                ),
                TextSpan(
                  text: '$score',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
