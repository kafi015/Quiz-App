import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quizapp/Models/question_model.dart';

class DatabaseConnection {
  final url = Uri.parse(
      'https://quizapp-edd68-default-rtdb.asia-southeast1.firebasedatabase.app/questions.json');

  Future<void> addQuestion(Question question) async {
    http.post(url,
        body: json.encode({
          'title': question.title,
          'options': question.options,
        }));
  }

  Future<List<Question>> fetchQuestion() async {
    return http.get(url).then((response) {
      var data = json.decode(response.body) as Map<String, dynamic>;
      List<Question> newQuestions = [];
      data.forEach((key, value) {
        var newQuestion =
            Question(id: key, title: value['title'], options: Map.castFrom(value['options']));
        newQuestions.add(newQuestion);
      });

      return newQuestions;
    });

  }
}
