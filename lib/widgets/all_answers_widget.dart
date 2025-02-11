import 'package:flutter/material.dart';
import 'package:space_scutum_test_task/widgets/answer_button_widget.dart';

class AllAnswersWidget extends StatefulWidget {
  const AllAnswersWidget({
    super.key,
    required this.answers,
    required this.currentQuestionIndex,
  });
  final List<String> answers;
  final int currentQuestionIndex;

  @override
  State<AllAnswersWidget> createState() => _AllAnswersWidgetState();
}

class _AllAnswersWidgetState extends State<AllAnswersWidget> {
  int? selectedIndex;

  void updateCurrentIndex(int index) {
    if (selectedIndex != index) {
      setState(() {
        selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = [
      for (int i = 0; i < widget.answers.length; i++)
        AnswerButtonWidget(
          text: widget.answers[i],
          answerIndex: i,
          isSelected: selectedIndex == i,
          onTap: updateCurrentIndex,
          currentQuestionIndex: widget.currentQuestionIndex,
        )
    ];
    selectedIndex = null;
    return Column(
      children: buttons,
    );
  }
}
