import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:space_scutum_test_task/providers/user_answers_provider.dart';
import 'package:space_scutum_test_task/widgets/check_icon_widget.dart';

class AnswerButtonWidget extends ConsumerWidget {
  const AnswerButtonWidget({
    super.key,
    required this.text,
    required this.onTap,
    required this.isSelected,
    required this.answerIndex,
    required this.currentQuestionIndex,
  });
  final String text;
  final Function(int) onTap;
  final bool isSelected;
  final int answerIndex;
  final int currentQuestionIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: OutlinedButton.icon(
        onPressed: () {
          if (ref.read(userAnswersProvider)[currentQuestionIndex] != text) {
            onTap(answerIndex);
            ref
                .read(userAnswersProvider.notifier)
                .setAnswers(currentQuestionIndex, text);
          }
        },
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: BorderSide(
            color:
                isSelected ? const Color(0xff107eeb) : const Color(0xff21486a),
            width: 4,
            strokeAlign: BorderSide.strokeAlignOutside,
          ),
        ),
        iconAlignment: IconAlignment.end,
        icon: CheckIconWidget(isChecked: isSelected),
        label: Align(
          alignment: Alignment.topLeft,
          child: Text(
            text,
            maxLines: 2,
            overflow: TextOverflow.clip,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
