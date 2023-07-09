import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/model/todo.dart';
import 'package:to_do_app/utils.dart';

class FirebaseApi {
  static Future<String> createTodo(ToDo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc();
    todo.id = docTodo.id;
    await docTodo.set(todo.toJson());
    return docTodo.id;
  }

  static Stream<List<ToDo>> readTodos() => FirebaseFirestore.instance
      .collection('todo')
      .orderBy(ToDoField.createdTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(ToDo.fromJson));

  static Future updateTodo(ToDo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc();
    await docTodo.update(todo.toJson());
  }

  static Future deleteTodo(ToDo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc(todo.id);
    await docTodo.delete();
  }
}
