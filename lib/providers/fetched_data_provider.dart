import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:space_scutum_test_task/models/question_model.dart';
import 'package:http/http.dart' as http;
import 'package:space_scutum_test_task/providers/query_configuration_provider.dart';

final fetchedDataProvider =
    FutureProvider.autoDispose<List<Question>>((ref) async {
  final configuration = ref.read(queryConfigurationProvider);
  final rawUrl = configuration.setQuery();
  final response = await http.get(Uri.parse(rawUrl));
  final json = jsonDecode(response.body) as Map<String, dynamic>;
  final rawQuestions = json['results'] as List<dynamic>;
  final questions = rawQuestions.map(
    (element) {
      return Question.fromJson(element as Map<String, dynamic>);
    },
  ).toList();
  return questions;
});

final geminiDataProvider =
    FutureProvider.autoDispose<List<dynamic>>((ref) async {
  final schema = Schema.array(
    description: 'List of questions',
    items: Schema.object(
      properties: {
        'index': Schema.integer(description: 'question index, index 0 - start'),
        'question': Schema.string(description: 'question text'),
        'answer_index': Schema.integer(
            description: 'index of correct answer, index 0 - start'),
        'hint': Schema.string(description: 'hint for the user'),
        'options': Schema.array(
          description: 'list of answer options',
          items: Schema.string(description: 'answer option'),
        )
      },
      requiredProperties: ['index', 'question', 'answer_index', 'options'],
    ),
  );
  final model = GenerativeModel(
    model: 'gemini-2.0-flash',
    apiKey: 'AIzaSyC97L6ewZeN_qAe7QjbuXwVMtJVDi8vM8U',
    generationConfig: GenerationConfig(
      responseMimeType: 'application/json',
      responseSchema: schema,
    ),
  );

  const promt =
      'Кількість питань - 50, кількість варіантів - 4, тема - Фільми, складність - важка, мова - українська';
  final content = [Content.text(promt)];
  final response = await model.generateContent(content);
  final List<dynamic> result = json.decode(response.text!);
  return result;
});
