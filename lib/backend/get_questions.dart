import 'package:http/http.dart' as http;
import 'dart:convert';

// Model class for Questions
class Question {
  final String category;
  final List<String> questions;

  Question({required this.category, required this.questions});

  factory Question.fromJson(Map<String, dynamic> json) {
    List<String> questionsFromJson = List<String>.from(json['question'][0]);

    return Question(
      category: json['category'],
      questions: questionsFromJson,
    );
  }
}

// Service to fetch questions
class QuestionService {
  Future<List<Question>> fetchQuestions() async {
    final response = await http.get(Uri.parse(
        'https://github-cloud-run-service-scocq2dp5a-ey.a.run.app/questions'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Question.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load questions');
    }
  }
}
