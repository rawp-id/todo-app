import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo/models/todo.dart';

class TodoRepository {
  final String _baseUrl = 'https://todo.rawp.info/api/todos';

  Future<List<TodoModel>> fetchTodos() async {
    try {
      print("Sending GET request to $_baseUrl");

      final response = await http.get(
        Uri.parse(_baseUrl)
      );

      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        if (jsonData['success'] == true) {
          return (jsonData['data'] as List)
              .map((item) => TodoModel.fromJson(item))
              .toList();
        } else {
          throw Exception("API error: ${jsonData['message']}");
        }
      } else {
        throw Exception('Failed to load todos. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print("Error fetching todos: $error");
      rethrow; // Re-throw to handle this error at a higher level if needed
    }
  }
}
