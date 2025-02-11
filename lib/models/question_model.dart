import 'package:space_scutum_test_task/utility.dart';

class Question {
  final String difficulty;
  final String category;
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  Question(
      {required this.difficulty,
      required this.category,
      required this.question,
      required this.correctAnswer,
      required this.incorrectAnswers});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      difficulty: json['difficulty'].toString(),
      category: json['category'].toString(),
      question: json['question'].toString().fixString(),
      correctAnswer: json['correct_answer'].toString().fixString(),
      incorrectAnswers: (json['incorrect_answers'] as List<dynamic>)
          .map((e) => e.toString().fixString())
          .toList(),
    );
  }
  @override
  String toString() {
    return question;
  }
}
