// views/todo_screen.dart
import 'package:flutter/material.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/repository/todo_repositort.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TodoRepository _repository = TodoRepository();
  late Future<List<TodoModel>> _todoList;

  @override
  void initState() {
    super.initState();
    _todoList = _repository.fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body: FutureBuilder<List<TodoModel>>(
        future: _todoList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No Todos available.'));
          }

          final todos = snapshot.data!;

          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];
              return ListTile(
                title: Text(todo.title),
                subtitle: Text(todo.description),
                trailing: Icon(
                  todo.isCompleted ? Icons.check_circle : Icons.circle_outlined,
                  color: todo.isCompleted ? Colors.green : Colors.grey,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
