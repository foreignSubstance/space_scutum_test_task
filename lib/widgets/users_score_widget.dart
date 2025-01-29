import 'package:flutter/material.dart';

class UsersScoreWidget extends StatelessWidget {
  const UsersScoreWidget({
    super.key,
    required this.score,
  });

  final int score;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            offset: Offset(0, 5),
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        children: [
          Text(
            'Your Score is',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: const Color(0xff107eeb), fontSize: 36),
          ),
          Text(
            '$score',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: const Color(0xff107eeb), fontSize: 64),
          ),
        ],
      ),
    );
  }
}
