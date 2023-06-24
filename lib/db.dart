import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quiz_app/question_model.dart';

class DBconnect {
  final url = Uri.parse(
      'https://quiz-app-6084a-default-rtdb.asia-southeast1.firebasedatabase.app.json');
  Future<void> addQuestion(Question question) async {
    http.post(url, body: json.encode({'title':question.title,
    'option':question.options}));
  }
}
