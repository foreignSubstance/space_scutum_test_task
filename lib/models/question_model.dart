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
      difficulty: json['difficulty'] as String,
      category: json['category'] as String,
      question: json['question'] as String,
      correctAnswer: json['correct_answer'] as String,
      incorrectAnswers: (json['incorrect_answers'] as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
    );
  }
  @override
  String toString() {
    return question;
  }
}
