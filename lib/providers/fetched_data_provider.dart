import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
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
