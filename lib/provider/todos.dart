import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/api/firebase_api.dart';
import 'package:to_do_app/model/todo.dart';

class TodosProvider extends ChangeNotifier {
  List<ToDo> _todos = [
    // ToDo(createdTime: DateTime.now(), title: 'Walk the Dog'),
    // ToDo(createdTime: DateTime.now(), title: 'Buy the Food', description: '''
    // -Eggs
    // -Veggies '''),
    // ToDo(
    //     createdTime: DateTime.now(),
    //     title: 'Family Trip',
    //     description: '''-Goa'''),
  ];

  List<ToDo> get todos => _todos.where((todo) => todo.isDone == false).toList();
  List<ToDo> get todosCompleted =>
      _todos.where((todo) => todo.isDone == true).toList();

  void setTodos(List<ToDo> todos) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _todos = todos;
      notifyListeners();
    });
  }

  void addTodo(ToDo todo) => FirebaseApi.createTodo(todo);

  void removeTodo(ToDo todo) => FirebaseApi.deleteTodo(todo);

  void updateTodo(ToDo todo, String title, String description) {
    todo.title = title;
    todo.description = description;
    FirebaseApi.updateTodo(todo);
  }

  bool toggleTodoStatus(ToDo todo) {
    todo.isDone = !todo.isDone;
    FirebaseApi.updateTodo(todo);
    return todo.isDone;
  }
}
