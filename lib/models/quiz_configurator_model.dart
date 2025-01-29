class QuizConfigurator {
  final int questionsAmount;
  final int? time;
  final int? category;
  final String? difficulty;

  QuizConfigurator({
    this.questionsAmount = 10,
    this.time = 10,
    this.difficulty,
    this.category,
  });

  QuizConfigurator copyWith({
    int? questionsAmount,
    int? time,
    int? category,
    String? difficulty,
  }) {
    return QuizConfigurator(
      questionsAmount: questionsAmount ?? this.questionsAmount,
      time: time ?? this.time,
      category: category ?? this.category,
      difficulty: difficulty ?? this.difficulty,
    );
  }

  String setQuery() {
    final categoryString = category == null ? '' : '&category=$category';
    final difficultyString =
        difficulty == null ? '' : '&difficulty=$difficulty';
    String query =
        'https://opentdb.com/api.php?amount=$questionsAmount$categoryString$difficultyString';
    return query;
  }
}
